local addonName, addon = ...;

addon.constants = {
  DEBUG = true,
  UNIT_PLAYER = 'player',
  PREFIX = 'FARM_CON';
  MESSAGETYPES = {
    say = 'SAY',
    channel = 'CHANNEL',
    whisper = 'WHISPER',
    guild = 'GUILD',
  },
  CHANNELS = {
    tests = 0,
  },
};

if (addon.constants.DEBUG == true) then
  print(addonName, 'warning: debug mode is enabled');
end
