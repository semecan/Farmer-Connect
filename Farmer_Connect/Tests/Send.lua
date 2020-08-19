local _, addon = ...;

local detectors = addon.API.detectors;
local GUILD_TYPE = addon.constants.MESSAGETYPES.guild;

local function displayItem (sender, itemLink, count)
  if (count > 1) then
    print(sender, 'got', count, 'of', itemLink);
  else
    print(sender, 'got item:', itemLink);
  end
end

addon.receive('test', function (sender, itemLink, count)
  displayItem(sender, itemLink, tonumber(count));
end);

detectors.on('NEW_ITEM', function (itemInfo, count)
  addon.send(GUILD_TYPE, 'test', itemInfo.link, count)
end);
