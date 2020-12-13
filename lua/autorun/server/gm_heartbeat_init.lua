local Post
Post = http.Post
local Read
Read = file.Read
local Replace
Replace = string.Replace
local Pump
do
  local _class_0
  local _base_0 = {
    heartbeat = function(self)
      return Post(tostring(self.url) .. "/heartbeat", { })
    end,
    start = function(self)
      print("[GM Heartbeat] Started heartbeat timer")
      return timer.Create(self.timerName, self.interval, 0, function()
        return self:heartbeat()
      end)
    end,
    chill = function(self)
      timer.Stop(self.timerName)
      return Post(tostring(self.url) .. "/chill", { })
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, url)
      self.url = url
      self.interval = 5
      self.timerName = "CFC_Heartbeat_Pump"
    end,
    __base = _base_0,
    __name = "Pump"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Pump = _class_0
end
local getUrl
getUrl = function()
  local url = Read("cfc/heartbeat_url.txt", "DATA")
  url = url and Replace(url, "\r", "")
  url = url and Replace(url, "\n", "")
  return url
end
CFCHeartBeat = Pump(getUrl())
CFCHeartBeat:start()
hook.Add("ShutDown", "CFC_HeartBeat_Chill", function()
  return CFCHeartBeat:chill()
end)
return RunConsoleCommand("sv_hibernate_think", "1")
