require 'redmine'

require_dependency 'redmine_chatwork/listener'

Redmine::Plugin.register :redmine_chatwork do
  name 'Redmine Chatwork'
  author 'Hori Yuma'
  url 'https://github.com/hokkey/redmine_chatwork'
  author_url 'https://github.com/hokkey/'
  description 'A Redmine plugin to notify updates to ChatWork rooms'
  version '0.2.0'

  requires_redmine :version_or_higher => '3.2.0'

  settings :default => {
      'room' => nil,
      'token' => nil,
      'post_updates' => '1',
      'post_wiki_updates' => '1'
  },
           :partial => 'settings/chatwork_settings'
end
