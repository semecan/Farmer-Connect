local addonName, addon = ...;

local strsplit = _G.strsplit;
local strjoin = _G.strjoin;
local tremove = _G.tremove;
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

  local payload = {strsplit(' ', message)};
  local identifier = payload[1];

  if (sender == playerName) then
    if (identifier == 'test') then
      callbackHandler:call(identifier, sender, select(2, unpack(payload)));
    end

    return;
  end

  -- print('Received raid command:', message, 'by', sender);
  callbackHandler:call(identifier, sender, select(2, unpack(payload)));
end);

events.on('PLAYER_LOGIN', function ()
  playerName = strjoin('-', UnitFullName(UNIT_PLAYER));
end);

addon.receive = function (identifier, callback)
  callbackHandler:addCallback(identifier, callback);
end
