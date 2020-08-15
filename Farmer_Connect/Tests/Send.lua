local _, addon = ...;

local GUILD_TYPE = addon.constants.MESSAGETYPES.guild;

local function test ()
  addon.send(GUILD_TYPE, 'test', 'thisisatestmessage');
end

addon.receive('test', function (message)
  print('test message:', message);
end);

addon.API.slash('send', test);
