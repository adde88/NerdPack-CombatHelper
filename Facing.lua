local _, CH = ...
local NeP = _G.NeP

function CH.Load_Face()

	-- Dont even load if not using advaned
	if not _G.IsHackEnabled then return end

	local UnitAffectingCombat = _G.UnitAffectingCombat
	local FaceDirection = _G.FaceDirection
	local ObjectPosition = _G.ObjectPosition
	local UnitChannelInfo = _G.UnitChannelInfo
	local UnitCastingInfo = _G.UnitCastingInfo
	local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
	local rad = _G.rad
	local atan2 = _G.atan2
	local C_Timer = _G.C_Timer
	local UnitExists = _G.UnitExists

	NeP.Interface:AddToggle({
			key = 'AutoFace',
			name = 'Auto Face',
			text = 'Automatically Face your target',
			icon = 'Interface\\Icons\\misc_arrowlup',
			nohide = true
	})

	function CH.Face()
		local ax, ay = ObjectPosition('player')
		local bx, by = ObjectPosition('target')
		if not ax or not bx or UnitIsDeadOrGhost('target') then return end
		local angle = rad(atan2(by - ay, bx - ax))
		if angle < 0 then
			FaceDirection(rad(atan2(by - ay, bx - ax) + 360))
		else
			FaceDirection(angle)
		end
	end

	-- Ticker
	C_Timer.NewTicker(0.1, (function()
		if UnitAffectingCombat('player')
		and UnitExists('target')
		and NeP.DSL:Get('toggle')(nil, 'mastertoggle')
		and NeP.DSL:Get('toggle')(nil, 'AutoFace')
		and not UnitChannelInfo('player')
		and not UnitCastingInfo('player')
		and not NeP.DSL:Get('Infront')('target')
		and not NeP.DSL:Get('moving')('player')
		and not CH:manualMoving() then
			CH:Face()
		end
	end), nil)

	return true
end

NeP.Protected:AddCallBack(CH.Load_Face)
