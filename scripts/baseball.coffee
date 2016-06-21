cheerio = require 'cheerio'
request = require 'request'

module.exports = (robot) ->
  robot.hear /(セリーグ|パリーグ|交流戦).*順位/i, (msg) ->
    baseUrl = 'http://baseball.yahoo.co.jp/npb/standings'
    request baseUrl + '/', (_, res) ->
      $ = cheerio.load res.body

      league = msg.match[1]
      switch league
        when "セリーグ"
          $('#sta_c .lt a').each ->
            a = $ @
            msg.send a.text()
        when "パリーグ"
          $('#sta_p .lt a').each ->
            a = $ @
            msg.send a.text()
        when "交流戦"
          $('#sta_i .lt a').each ->
            a = $ @
            msg.send a.text()
        else
          msg.send "セリーグ"
          $('#sta_c .lt a').each ->
            a = $ @
            msg.send a.text()
          msg.send "パリーグ"
          $('#sta_p .lt a').each ->
            a = $ @
            msg.send a.text()
          msg.send "交流戦"
          $('#sta_i .lt a').each ->
            a = $ @
            msg.send a.text()
