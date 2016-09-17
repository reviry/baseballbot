cheerio = require 'cheerio'
request = require 'request'

baseUrl = 'http://baseball.yahoo.co.jp/npb/standings/'

module.exports = (robot) ->
  robot.hear /(セリーグ|パリーグ|交流戦).*(順位)/i, (msg) ->
    request baseUrl, (_, res) ->
      $ = cheerio.load res.body

      console.log(msg.match)
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

  robot.hear /^順位$/i, (msg) ->
    request baseUrl, (_, res) ->
      $ = cheerio.load res.body

      console.log(msg.match)
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
