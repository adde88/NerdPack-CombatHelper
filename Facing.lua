-- Dont even load if not using advaned
if not IsHackEnabled then return end

local _, CH = ...
local NeP = NeP
local UnitAffectingCombat = UnitAffectingCombat
local FaceDirection = FaceDirection
local ObjectPosition = ObjectPosition
local GetUnitSpeed = GetUnitSpeed
local rad = rad
local atan2 = atan2
local C_Timer = C_Timer
local UnitExists = UnitExists
local UnitChannelInfo = UnitChannelInfo

NeP.Interface:AddToggle({
		key = 'AutoFace',
		name = 'Auto Face',
		text = 'Automatically Face your target',
		icon = 'Interface\\Icons\\ability_hunter_snipershot',
		nohide = true
})

function CH:Face()
	local unitSpeed = GetUnitSpeed('player')
	if unitSpeed == 0 and not NeP.DSL:Get('Infront')('target') then
		local ax, ay = ObjectPosition('player')
		local bx, by = ObjectPosition('target')
		local angle = rad(atan2(by - ay, bx - ax))
		if angle < 0 then
			FaceDirection(rad(atan2(by - ay, bx - ax) + 360))
		else
			FaceDirection(angle)
		end
	end
end

-- Ticker
C_Timer.NewTicker(0.1, (function()
	if UnitAffectingCombat('player')
	and UnitExists('target')
	and NeP.DSL:Get('toggle')(nil, 'mastertoggle')
	and NeP.DSL:Get('toggle')(nil, 'AutoFace')
	and not UnitChannelInfo('player')
	and not CH:manualMoving() then
		CH:Face()
	end
end), nil)
