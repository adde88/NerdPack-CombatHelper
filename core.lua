local n_name, CH = ...

CH.Version = 1.4

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
NeP.Interface:Add('Combat Helper V:'..CH.Version, function() GUI.parent:Show() end)
GUI.parent:Hide()
