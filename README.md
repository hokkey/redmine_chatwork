# ChatWork plugin for Redmine

This plugin posts updates to issues in your Redmine installation to the ChatWork
room.

It is based on [sciyoshi/redmine-slack](https://github.com/sciyoshi/redmine-slack).

Redmineのチケットの更新・Wikiの更新をChatWorkのルームへ自動で投稿するプラグインです。

Slack用のプラグイン[sciyoshi/redmine-slack](https://github.com/sciyoshi/redmine-slack)をベースにしています。

## Compatible with:

* Redmine 3.3.x
* Redmine 3.2.x

# Installation

1. Download this repository
2. Move `src/redmine_chatwork` to your plugins directory
4. Install `httpclient` dependency by running `bundle install` from the plugin directory
4. Restart Redmine
5. Config options from `Administration > Plugins > redmine_chatwork`
  
## Configuration／設定

### ChatWork API Token (required)

An api token on posting.

投稿に使用されるAPIトークンです。Redmineからの投稿は、このトークンに紐付くユーザーとしてみなされます。

### ChatWork Default Room URL (required)

A default room url of posts.

デフォルトで投稿先となるChatWorkルームのURLをセットしてください。

### Post Issue Updates? (option)

It posts issue updates.

チケットの変更があるとChatWorkへ通知します。
 
### Post Wiki Updates? (option)

It posts wiki updates.

Wikiページの作成・変更をChatWorkへ通知します。

# Options per project／プロジェクトごとのオプション

If you define specified custom fields, you can change plugin behavior per project.

指定された名称のカスタムフィールドを定義することで、プロジェクトごとにプラグインの挙動を変更できます。

### Override default room／デフォルトルームの上書き

If "ChatWork" field is exists and filled, it posts to this room.

プジェクトのカスタムフィールドに「ChatWork」が定義され、そこへルームのURLが記載されている場合、
そのプロジェクトの投稿はカスタムフィールドのルームへ変更されます。

### Don't post any updates／全ての更新を投稿しない

If 'ChatWork Disabled' field is exists and filed with '0', it won't post any updates.
It is good to set the custom filed as boolean type.

プロジェクトのカスタムフィールドに「ChatWork Disabled」が定義され、そこへ「0」がセットされている場合、
そのプロジェクトの変更はChatWorkに自動投稿されません。

カスタムフィールドのタイプを真偽値に設定することを推奨します。

# License

The MIT License (MIT)
