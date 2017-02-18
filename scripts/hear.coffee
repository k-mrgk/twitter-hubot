# Description:
#   TLの言葉に反応してリプライ送信
#

checkTweet = (tweet) ->
  reg = /\@|\#|RT/
  return reg.test(tweet)

module.exports = (robot) ->
  robot.hear /おは/i, (tweet) ->
    if !checkTweet(tweet.message.text)
      tweet.reply "おはにゃー(,,•́ωก̀,,)"

  robot.hear /(寝る|ねる|おやすみ)/i, (tweet) ->
    if !checkTweet(tweet.message.text)
      tweet.reply "おやすにゃー*<(¦3[*:🐾.｡]"

  robot.hear /(びーむ|ビーム|こうせん|ﾋﾞｰﾑ)/i, (tweet) ->
    if !checkTweet(tweet.message.text)
      tweet.reply "๛ก(ｰ̀ωｰ́ก)"
