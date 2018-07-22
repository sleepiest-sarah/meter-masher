local sframe = CreateFrame("FRAME");
sframe:RegisterEvent("ADDON_LOADED");

SLASH_SMM1 = "/smm";

function sframe:OnEvent(event, arg1)
  if event == "ADDON_LOADED" and arg1 == "SarahsMeterMasher" then
    print(arg1,"Sarah's Meter Masher loaded.");
  end
end


SlashCmdList["SMM"] = function(msg)
  print("Hi!");
end

sframe:SetScript("OnEvent", sframe.OnEvent);