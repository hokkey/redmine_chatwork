require 'redmine'

require_dependency 'redmine_chatwork/listener'

Redmine::Plugin.register :redmine_chatwork do
	name 'Redmine Chatwork'
	author 'Hori Yuma'
	url 'https://github.com/hokkey/redmine_chatwork'
	author_url 'https://github.com/hokkey/'
	description 'ChatWork integration'
	version '0.1'

	requires_redmine :version_or_higher => '0.8.0'

	settings \
		:default => {
			'room' => nil,
      'token' => nil,
      'chatwork_url' => 'https://api.chatwork.com/v1/rooms/',
      'post_updates' => 1,
      'post_wiki_updates' => 1
		},
		:partial => 'settings/chatwork_settings'
end
