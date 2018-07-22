local sframe = CreateFrame("FRAME");
sframe:RegisterEvent("ADDON_LOADED");
sframe:RegisterEvent("PLAYER_LOGOUT")

smm_options_defaults = {
    debug_mode = false,
    enabled = true,
    events = {"CHAT_MSG_SAY",
                "CHAT_MSG_WHISPER",
                "CHAT_MSG_PARTY",
                "CHAT_MSG_PARTY_LEADER",
                "CHAT_MSG_RAID",
                "CHAT_MSG_RAID_LEADER",
                "CHAT_MSG_RAID_WARNING",
                "CHAT_MSG_CHANNEL",
                "CHAT_MSG_GUILD",
                "CHAT_MSG_OFFICER",
                "CHAT_MSG_YELL",
                "CHAT_MSG_BATTLEGROUND",
                "CHAT_MSG_BATTLEGROUND_LEADER",
                "CHAT_MSG_BN_CONVERSATION",
                "CHAT_MSG_BN_WHISPER",
                "CHAT_MSG_TEXT_EMOTE"
                }
  }
  
local function logDebugMessage(msg)
  if (smm_options.debug_mode) then
    print(msg)
  end
end
  
local function meterFilter(self, event, arg1, ...)
  for _,f in pairs(smm_filters) do
    if arg1:find(f) then
      logDebugMessage("Filtered: " .. arg1)
      return true
    end
  end
  
  return false
end
  
local function initializeFilterEvents()
    for _,v in ipairs(smm_options.events) do
      ChatFrame_AddMessageEventFilter(v, meterFilter)
    end
end

local function initialize() 
  if MeterMasherDb == nil then
    MeterMasherDb = {}
  end
    
  if MeterMasherDb.smm_options == nil then
    MeterMasherDb.smm_options = smm_options_defaults
  end
  
  smm_options = MeterMasherDb.smm_options
  
  initializeFilterEvents()
  
  print("Sarah's Meter Masher loaded.");
end



 local function slashCmd(msg, editbox)
   local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
   
  if cmd == "debug" then
    smm_options.debug_mode = not smm_options.debug_mode
    if smm_options.debug_mode then
      print "debug mode enabled"
    else
      print "debug mode disabled"
    end
  elseif cmd == "enable" then
    smm_options.enabled = true
    print "Sarah's Meter Masher is enabled"
  elseif cmd == "disable" then
    smm_options.disabled = false
    print "Sarah's Meter Masher is disabled"
  elseif cmd == "reset" then
    smm_options = smm_options_defaults
    print "Settings reset to defaults"
  elseif cmd == "events" and args == "" then
    table.foreach(smm_options.events, print)
  elseif cmd == "eventadd" and args ~= nil then
    table.insert(smm_options.events, args)
    initializeFilterEvents()
    print("Added " .. args)
  elseif cmd == "eventremove" and tonumber(args) ~= nil  then
    local removed_event = table.remove(smm_options.events, args)
    ChatFrame_RemoveMessageEventFilter(removed_event, meterFilter)
    print("Removed " .. removed_event)
  else
    print(smm_constants.HELP_TEXT)
  end
end

function sframe:OnEvent(event, arg1, ...)
  if event == "ADDON_LOADED" and arg1 == smm_constants.ADDON_NAME then
    initialize()
  elseif event == "PLAYER_LOGOUT" then
    MeterMasherDb.smm_options = smm_options
  end
end

sframe:SetScript("OnEvent", sframe.OnEvent);
SlashCmdList["SMM"] = slashCmd
