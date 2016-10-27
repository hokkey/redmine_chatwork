require 'httpclient'

class ChatWorkListener < Redmine::Hook::Listener
	def controller_issues_new_after_save(context={})
		issue = context[:issue]
		room = room_for_project issue.project
    disabled = check_disabled issue.project

    return if disabled
		return unless room
		return if issue.is_private?

		header = {
				:project => escape(issue.project),
				:title => escape(issue),
				:url => object_url(issue),
				:author => escape(issue.author),
				:assigned_to => escape(issue.assigned_to)
		}

		body = escape issue.description if issue.description

		speak room, header, body
	end

	def controller_issues_edit_after_save(context={})
		issue = context[:issue]
		journal = context[:journal]
		room = room_for_project issue.project
    disabled = check_disabled issue.project

    return if disabled
		return unless room and Setting.plugin_redmine_chatwork[:post_updates] == '1'
		return if issue.is_private?
    return if not journal.notes

		header = {
				:project => escape(issue.project),
				:title => escape(issue),
				:url => object_url(issue),
				:author => escape(issue.author),
				:assigned_to => escape(issue.assigned_to.to_s),
				:status => escape(issue.status.to_s),
		}

		body = escape journal.notes if journal.notes

		speak room, header, body
  end

  def controller_wiki_edit_after_save(context = {})
    return unless Setting.plugin_redmine_chatwork[:post_wiki_updates] == '1'

    project = context[:project]
		page = context[:page]
		room = room_for_project project
    disabled = check_disabled project

    return if disabled

    header = {
        :project => escape(project),
        :title => escape(page.title),
        :url => object_url(page)
    }

    body = "#{page.content.author} updated the wiki"

    speak room, header, body
  end

	def speak(room, header, body=nil, footer=nil)
		url = 'https://api.chatwork.com/v1/rooms/'
		token = Setting.plugin_redmine_chatwork[:token]
		content = create_body body, header, footer
    reqHeader = { 'X-ChatWorkToken' => token }
    endpoint = "#{url}#{room}/messages"

		begin
			client = HTTPClient.new
			client.ssl_config.cert_store.set_default_paths
			client.ssl_config.ssl_version = :auto
      client.post_async(endpoint, "body=#{content}", reqHeader)

		rescue Exception => e
			Rails.logger.info("cannot connect to #{endpoint}")
			Rails.logger.info(e)
		end
	end

  def create_body(body=nil, header=nil, footer=nil)
    result = '[info]'

    if header
      result +=
          "[title]#{header[:project] if header[:project]} #{header[:title] if header[:title]} #{'(' + header[:status] + ')' if header[:status]}\n#{header[:url] if header[:url]}\n#{'Author: ' + header[:author] if header[:author]}#{', Assignee: ' + header[:assigned_to] if header[:assigned_to]}[/title]"
    end

    if body
      result += body
    end

    result += '[/info]'
  end

private
	def escape(msg)
		msg.to_s.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;").gsub(" ", '+')
  end

	def object_url(obj)
		if Setting.host_name.to_s =~ /\A(https?\:\/\/)?(.+?)(\:(\d+))?(\/.+)?\z/i
			host, port, prefix = $2, $4, $5
			Rails.application.routes.url_for(obj.event_url({
				:host => host,
				:protocol => Setting.protocol,
				:port => port,
				:script_name => prefix
			}))
		else
			Rails.application.routes.url_for(obj.event_url({
				:host => Setting.host_name,
				:protocol => Setting.protocol
			}))
		end
  end

  def check_disabled(proj)
    return nil if proj.blank?

    cf = ProjectCustomField.find_by_name("ChatWork Disabled")
    state = proj.custom_value_for(cf).value rescue nil

    if state == nil
      return false
    end

    if state == '0'
      return false
    end

    true
  end

	def room_for_project(proj)
		return nil if proj.blank?

		cf = ProjectCustomField.find_by_name("ChatWork")

		val = [
			(proj.custom_value_for(cf).value rescue nil),
			Setting.plugin_redmine_chatwork[:room],
		].find{|v| v.present?}

		rid = val.match(/#!rid\d+/)

		rid[0][5..val.length]
	end
end
