local _, addon = ...;

local GetItemInfo = _G.GetItemInfo;

local detectors = addon.API.detectors;
local GUILD_TYPE = addon.constants.MESSAGETYPES.guild;

detectors.on('NEW_ITEM', function (itemInfo, count)
  addon.send(GUILD_TYPE, 'NEW_ITEM', itemInfo.link, count)
end);

addon.receive('NEW_ITEM', function (sender, itemLink, count)
  print(GetItemInfo(itemLink));
end);
