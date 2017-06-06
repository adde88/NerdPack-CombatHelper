local n_name, CH = ...
local NeP = NeP

CH.Version = 1.3

local config = {
	key = 'NeP_CombatHelper',
	title = n_name,
	subtitle = 'Settings',
	width = 250,
	height = 200,
	config = {
		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = '|cfffd1c15Advanced|r Only:', size = 25, align = 'Center' },
			-- Nothing here yet
	}
}

local GUI = NeP.Interface:BuildGUI(config)
NeP.Interface:Add('Combat Helper V:'..CH.Version, function() GUI:Show() end)
GUI:Hide()
