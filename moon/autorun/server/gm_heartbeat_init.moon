import Post from http
import Read from file
import Replace from string

class Pump
    new: (url) =>
        @url = url
        @interval = 2
        @timerName = "CFC_Heartbeat_Pump"

    heartbeat: =>
        Post @url .. "heartbeat", {}

    start: =>
        timer.Create @timerName, @interval, 0, -> @heartbeat

    chill: =>
        timer.Stop @timerName
        Post @url .. "chil", {}

export CFCHeartBeat

getUrl = ->
    url = File.Read "cfc/heartbeat_url.txt", "DATA"
    url and= Replace url, "\r", ""
    url and= Replace url, "\n", ""

CFCHeartBeat = Pump getUrl!
CFCHeartBeat.Start!


hook.Add "ShutDown", "CFC_HeartBeat_Chill", -> CFCHeartBeat.chill!
