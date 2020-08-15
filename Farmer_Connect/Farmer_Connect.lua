local _, addon = ...;

local API = _G.FARMER_API;

if (not API) then
  return print('Farmer API not found');
end

addon.API = API;
