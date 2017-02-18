#!/bin/sh

export HUBOT_TWITTER_KEY="【Consumer Key】"
export HUBOT_TWITTER_SECRET="【Secret Key】"
export HUBOT_TWITTER_TOKEN="【Access Token Key】"
export HUBOT_TWITTER_TOKEN_SECRET="【Access Token Secret Key】"
#export HUBOT_NAME=""

export HUBOT_DOCOMO_DIALOGUE_API_KEY="【DOCOMO API Key】"

bin/hubot -a twitter-userstream -n twitter_bot_id
