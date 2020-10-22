import Post from http
import Read from file
import Replace from string

class Pump
    new: (url) =>
        @url = url
        @interval = 2
        @timerName = "CFC_Heartbeat_Pump"

        timer.Create @timerName, @interval, 0, -> @heartbeat

    heartbeat: =>
        Post @url, {}

export CFCHeartBeat

getUrl = ->
    url = File.Read "cfc/heartbeat_url.txt", "DATA"
    url and= Replace url, "\r", ""
    url and= Replace url, "\n", ""
    url

CFCHeartBeat = Pump getUrl!
