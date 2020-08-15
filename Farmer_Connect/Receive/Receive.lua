local addonName, addon = ...;

local strsplit = _G.strsplit;
local strjoin = _G.strjoin;
local unpack = _G.unpack;
local UnitFullName = _G.UnitFullName;

local UNIT_PLAYER = addon.constants.UNIT_PLAYER;
local ADDON_PREFIX = addon.constants.PREFIX;
local callbackHandler = addon.API.Class.CallbackHandler:new();
local events = addon.API.events;

local playerName;

if (not _G.C_ChatInfo.RegisterAddonMessagePrefix(ADDON_PREFIX)) then
  return print(addonName, 'could not register message prefix');
end

events.on('CHAT_MSG_ADDON', function (prefix, message, channel, sender)
  if (prefix ~= ADDON_PREFIX) then return end

  if (sender == playerName) then
    local payload = {strsplit(' ', message)};

    if (payload[1] == 'test') then
      print(channel);
      callbackHandler:call(unpack(payload));
    end

    return;
  end

  -- print('Received raid command:', message, 'by', sender);
  callbackHandler:call(strsplit(' ', message));
end);

events.on('PLAYER_LOGIN', function ()
  playerName = strjoin('-', UnitFullName(UNIT_PLAYER));
end);

addon.receive = function (identifier, callback)
  callbackHandler:addCallback(identifier, callback);
end
