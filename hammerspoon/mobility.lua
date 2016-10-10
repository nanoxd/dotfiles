-- Home SSID
local homeSSID = 'Mars'
local lastSSID = hs.wifi.currentNetwork()

local connectVPN = [[
tell application "Viscosity"
  connect "HomeVPN"
end tell
]]

local disconnectVPN = [[
tell application "Viscosity"
  disconnect "HomeVPN"
end tell
]]

-- Callback function for WiFi SSID change events
function ssidChangedCallback()
  newSSID = hs.wifi.currentNetwork()

  print("WiFi Changed: Old:" .. (lastSSID or "nil") .. " new:" .. (newSSID or "nil"))
  if newSSID == homeSSID and lastSSID ~= homeSSID then
  -- if has_value(homeSSID, newSSID) and not has_value(homeSSID, lastSSID) then
    -- We have gone from something that isn't my home WiFi, to something that is
    print('triggering home_arrived')
    home_arrived()
  elseif newSSID ~= homeSSID and lastSSID == homeSSID then
  -- elseif not has_value(homeSSID, newSSID) and has_value(homeSSID, lastSSID) then
    -- We have gone from something that is my home WiFi, to something that isn't
    print('triggering home_departed')
    home_departed()
  end

  lastSSID = newSSID
end

-- Perform tasks to configure the system for my home WiFi network
function home_arrived()
  -- hs.audiodevice.defaultOutputDevice():setVolume(25)

  -- Note: sudo commands will need to have been pre-configured in /etc/sudoers, for passwordless access, e.g.:
  -- cmsj ALL=(root) NOPASSWD: /usr/libexec/ApplicationFirewall/socketfilterfw --setblockall *

  -- Disconnect VPN
  hs.osascript.applescript(disconnectVPN)

  hs.notify.new({
    title='Hammerspoon',
    informativeText='Disconnected VPN'
  }):send()
end

function home_departed()
    -- Connect to VPN
    hs.timer.doAfter(5, function() hs.osascript.applescript(connectVPN) end)

    hs.notify.new({
          title='Hammerspoon',
            informativeText='Connected to VPN'
        }):send()
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

if hs.wifi.currentNetwork() == homeSSID then
    home_arrived()
else
    home_departed()
end
