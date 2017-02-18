# Description
#   10分おきにツイートを取得してマルコフ連鎖したものをツイート
#

checkTweet = (tweet) ->
    return /I\'m at|RT/.test(tweet)


cronJob = require('cron').CronJob
MarkovChain = require('markov-chain-kuromoji')
Twitter = require('twit')

client = new Twitter({
  consumer_key: process.env.HUBOT_TWITTER_KEY
  consumer_secret: process.env.HUBOT_TWITTER_SECRET
  access_token: process.env.HUBOT_TWITTER_TOKEN
  access_token_secret: process.env.HUBOT_TWITTER_TOKEN_SECRET
})

module.exports = (robot) ->
  job = new cronJob(
    cronTime: "*/10 * * * *"
    start: true
    onTick: ->
      client.get 'statuses/home_timeline', {count: 300}, (err, tweets, response) =>
        if !err?
          input = null
          for i in tweets
            if !checkTweet(i.text)
              input += "#{i.text}。"
          input = input.replace /。。|\]|」|】|』/g, '。'
          input = input.replace /(https?:\/\/[\x21-\x7e]+|\#|\[|「|【|『)/g, ''
          input = input.replace /(@[\x21-\x7e]+)/g, ''
          input = input.replace /\s*/g, ''
          markov = new MarkovChain(input)
          markov.start(5, (output) =>
            client.post 'statuses/update', {status: output}, (markov_err, data, response) =>
              if markov_err?
                robot.logger.error "markov #{markov_err}"
          )
        else
          robot.logger.error "tweet #{err}"
  )
