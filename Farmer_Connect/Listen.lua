local _, addon = ...;

local GetItemInfo = _G.GetItemInfo;
local GetItemInfoInstant = _G.GetItemInfoInstant;
local DoesItemExistByID = _G.C_Item.DoesItemExistByID;
local Item = _G.Item;

local detectors = addon.API.detectors;
local GUILD_TYPE = addon.constants.MESSAGETYPES.guild;

local function displayItem (sender, itemLink, count)
  if (count > 1) then
    print(sender, 'got', count, 'of', itemLink);
  else
    print(sender, 'got item:', itemLink);
  end
end

local function fetchItem (sender, itemLink, count)
  local itemId = GetItemInfoInstant(itemLink);

  if (not DoesItemExistByID(itemId)) then
    return displayItem(itemId, itemLink, count);
  end

  local item = Item:CreateFromItemID(itemId);

  item:ContinueOnItemLoad(function()
    --[[ The original link does contain enough information for a call to
         GetItemInfo which then returns a complete itemLink ]]
    --[[ Some items like mythic keystones and caged pets don't get a new link
         by GetItemInfo ]]
    itemLink = select(2, GetItemInfo(itemLink)) or itemLink;

    displayItem(sender, itemLink, count);
  end);
end

addon.receive('NEW_ITEM', function (sender, itemLink, count)
  displayItem(sender, itemLink, tonumber(count));
end);

detectors.on('NEW_ITEM', function (itemInfo, count)
  addon.send(GUILD_TYPE, 'NEW_ITEM', itemInfo.link, count)
end);
