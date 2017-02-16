![Redmine Chatwork](https://cloud.githubusercontent.com/assets/6197292/22987916/aab3c8b8-f3f3-11e6-9b39-8f53a53a2a42.png)

# Redmine Chatwork

This plugin notifies updates of Redmine tickets and wiki to your [ChatWork](http://www.chatwork.com/) room. You can change settings for each project by creating custom-fields.

## Compatible with:

* Redmine 3.3.x
* Redmine 3.2.x

## Installation

1. [Get your ChatWork API token from the authentication page](https://www.chatwork.com/service/packages/chatwork/subpackages/api/apply_beta_business.php)
2. Download this repository
3. Move `src/redmine_chatwork` to your plugins directory
4. Install `httpclient` by running `bundle install` from the plugin directory
5. Restart Redmine
6. Open plugin setting: `Administration > Plugins > Redmine Chatwork`
7. Set you API token and default room URL
8. Create "ChatWork" and "ChatWork Disabled" project custom field (option)

## Settings

![](https://cloud.githubusercontent.com/assets/6197292/22985457/d54cf20a-f3eb-11e6-8637-87ed17d3120d.png)

### Changing behavior for each project

You can override the room or turn off notifications by using project custom field. The name of the custom field must be same from the example.

![](https://cloud.githubusercontent.com/assets/6197292/22987131/209b667e-f3f1-11e6-8ce9-24305f09a1e1.png)

1. Create project custom fields:
  * A "Link" field named "ChatWork"
  * A "Boolean" field named "ChatWork Disabled"
2. Go to the project setting which you want to override from default.
3. Fill the "ChatWork" field to change the room to notify.
4. Set "No" at the "ChatWork Disabled" field not to send updates.

## Screenshot

![](https://cloud.githubusercontent.com/assets/6197292/22985404/aa72fb38-f3eb-11e6-8520-f855fa02c405.png)

## Changelog

### v0.2.0

* Change API endpoint from v1 to v2
* Add translation files (en and ja)

### v0.1.1

* Fix unexpected body escaping

### v0.1.0

* The first release

## Author

http://media-massage.net/profile/

## Acknowledge

This plugins is based on [sciyoshi/redmine-slack](https://github.com/sciyoshi/redmine-slack).

## License

MIT License
