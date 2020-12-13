import Post from http
import Read from file
import Replace from string

class Pump
    new: (url) =>
        @url = url
        @interval = 5
        @timerName = "CFC_Heartbeat_Pump"

    heartbeat: =>
        Post "#{@url}/heartbeat", {}

    start: =>
        print("[GM Heartbeat] Started heartbeat timer")
        timer.Create @timerName, @interval, 0, -> @heartbeat!

    chill: =>
        timer.Stop @timerName
        Post "#{@url}/chill", {}

getUrl = ->
    url = Read "cfc/heartbeat_url.txt", "DATA"
    url and= Replace url, "\r", ""
    url and= Replace url, "\n", ""
    url

export CFCHeartBeat
CFCHeartBeat = Pump getUrl!
CFCHeartBeat\start!

hook.Add "ShutDown", "CFC_HeartBeat_Chill", -> CFCHeartBeat\chill!

RunConsoleCommand "sv_hibernate_think", "1"
