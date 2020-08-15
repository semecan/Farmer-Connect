local _, addon = ...;

local strjoin = _G.strjoin;
local SendAddonMessage = _G.C_ChatInfo.SendAddonMessage;

local ADDON_PREFIX = addon.constants.PREFIX;
local CHANNEL_TYPE = addon.constants.MESSAGETYPES.channel;

local function sendData (type, channel, ...)
  local data = strjoin(' ', ...);

  if (not SendAddonMessage(ADDON_PREFIX, data, type, channel)) then
    -- print('Could not send data');
  end
end

addon.sendToChannel = function (channel, ...)
  sendData(CHANNEL_TYPE, channel, ...);
end

addon.send = function (type, ...)
  sendData(type, nil, ...);
end
