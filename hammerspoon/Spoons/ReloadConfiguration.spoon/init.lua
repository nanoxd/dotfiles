--- === ReloadConfiguration ===
---
--- Adds a hotkey to reload the hammerspoon configuration, and a pathwatcher to automatically reload on changes.
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ReloadConfiguration.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ReloadConfiguration.spoon.zip)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = 'ReloadConfiguration'
obj.version = '1.1'
obj.author = 'Jon Lorusso <jonlorusso@gmail.com>, modified locally'
obj.homepage = 'https://github.com/Hammerspoon/Spoons'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

--- ReloadConfiguration.watch_paths
--- Variable
--- List of directories to watch for changes, defaults to hs.configdir
obj.watch_paths = { hs.configdir }

--- ReloadConfiguration.reload_delay
--- Variable
--- Number of seconds to debounce filesystem change events before reloading.
obj.reload_delay = 0.25

--- ReloadConfiguration.show_reload_alert
--- Variable
--- Show a short alert immediately before reloading.
obj.show_reload_alert = true

function obj:reloadNow()
  if self.reload_timer then
    self.reload_timer:stop()
    self.reload_timer = nil
  end

  if self.show_reload_alert then
    hs.alert.show 'Reloading Hammerspoon…'
  end

  hs.reload()
end

function obj:scheduleReload()
  if self.reload_timer then
    self.reload_timer:stop()
  end

  self.reload_timer = hs.timer.doAfter(self.reload_delay, function()
    self.reload_timer = nil
    self:reloadNow()
  end)

  return self
end

--- ReloadConfiguration:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for ReloadConfiguration
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for the following items:
---   * reloadConfiguration - This will cause the configuration to be reloaded
function obj:bindHotkeys(mapping)
  local def = { reloadConfiguration = function() self:reloadNow() end }
  hs.spoons.bindHotkeysToSpec(def, mapping)
end

function obj:stop()
  if self.watchers then
    for _, watcher in pairs(self.watchers) do
      watcher:stop()
    end
    self.watchers = nil
  end

  if self.reload_timer then
    self.reload_timer:stop()
    self.reload_timer = nil
  end

  return self
end

--- ReloadConfiguration:start()
--- Method
--- Start ReloadConfiguration
---
--- Parameters:
---  * None
function obj:start()
  self:stop()
  self.watchers = {}

  for _, dir in pairs(self.watch_paths) do
    self.watchers[dir] = hs.pathwatcher.new(dir, function()
      self:scheduleReload()
    end):start()
  end

  return self
end

return obj
