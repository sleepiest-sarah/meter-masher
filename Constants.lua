SLASH_SMM1 = "/smm"

smm_constants = {}


smm_constants.ADDON_NAME = "SarahsMeterMasher"
smm_constants.DEBUG_CHANNEL = "smmdebug"

smm_constants.HELP_TEXT = 
[[
Sarah's Meter Masher options
/smm debug -- enable/disable debug mode
/smm enable -- enable meter filtering
/smm disable -- disable meter filtering
/smm reset -- reset all settings to the defaults
/smm events -- lists all chat events that should be filtered
/smm eventadd <event to add> -- add a new chat event to filter
/smm eventremove <index of event> -- remove a chat event from the filter
]]


smm_filters = {}

smm_filters.DETAILS_HEADER = "^Details!: %w+"
smm_filters.DETAILS_ROW = "^%d\. .+ \.+"

smm_filters.SKADA_HEADER = "^Skada: .*:$"
smm_filters.SKADA_ROW = "^%s%d\. .+%s*"

smm_filters.RECOUNT_HEADER = "^Recount %- %a+"
smm_filters.RECOUNT_ROW = "^%s%d\. .+%s*"
