# Description:
#   リプライに対してDOCOMOの雑談APIを利用して返答
#

getTimeDiffAsMinutes = (old_msec) ->
  now = new Date()
  old = new Date(old_msec)
  diff_msec = now.getTime() - old.getTime()
  diff_minutes = parseInt( diff_msec / (60*1000), 10 )
  return diff_minutes

module.exports = (robot) ->
  robot.respond /(\S+)/i, (msg) ->
    DOCOMO_API_KEY = process.env.HUBOT_DOCOMO_DIALOGUE_API_KEY
    if DOCOMO_API_KEY == null
      robot.logger.error "DOCOMOの雑談APIが設定されていません．"
      return
    message = msg.message.text.replace(/\@\S+/ig, "")
    user_name = msg.message.user.name
    user_id = msg.message.user.id
    if message == " "
      msg.reply "#{user_name}さん，なんですか"
      return
    CONTEXT_ID = 'docomo-talk-context-' + user_id
    reg=/(リセット|reset)/
    if reg.test(message)
        robot.brain.set CONTEXT_ID, ''
        msg.reply '話題をリセットしました'
    else
        context = robot.brain.get CONTEXT_ID || ''
        CONTEXT_ID_TTL = 'docomo-talk-context-ttl-' + user_id
        TTL_MINUTES = 120
        old_msec = robot.brain.get CONTEXT_ID_TTL
        diff_minutes = getTimeDiffAsMinutes old_msec

        if diff_minutes > TTL_MINUTES
            context = ''

        url = 'https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=' + DOCOMO_API_KEY
        request = require('request')
        request.post
            url: url
            json:
                utt: message
                t: 30
                nickname: user_name
                context: context

            , (err, response, body) ->

              robot.brain.set CONTEXT_ID, body.context
              now_msec = new Date().getTime()
              robot.brain.set CONTEXT_ID_TTL, now_msec

              robot.logger.info "receive reply from #{user_name} -> #{message}"
              robot.logger.info "send replay to #{user_name} -> #{body.utt}"
              msg.reply body.utt
