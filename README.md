# twitter-hubot

Hubot製のTwitter botです．


## 機能

- おはようやこんにちはなどのツイートに反応
- リプライに対してDOCOMOの雑談対話APIを使用して返答
-  10分ごとにツイートを取得してマルコフ連鎖したものをツイート

##  起動
`hubot_run.sh`のAPIキーを埋めて，`twitter_bot_id`をtwitterアカウントのIDに変更してから実行してください

```sh:hubot_run.sh
export HUBOT_TWITTER_KEY="【Consumer Key】"
export HUBOT_TWITTER_SECRET="【Secret Key】"
export HUBOT_TWITTER_TOKEN="【Access Token Key】"
export HUBOT_TWITTER_TOKEN_SECRET="【Access Token Secret Key】"
export HUBOT_DOCOMO_DIALOGUE_API_KEY="【DOCOMO API Key】"

bin/hubot -a twitter-userstream -n twitter_bot_id
```
