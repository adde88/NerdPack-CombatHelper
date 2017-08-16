-- Dont even load if not using advaned
if not IsHackEnabled then return end

local _, CH = ...
local NeP = NeP
local UnitClass = UnitClass
local GetSpecializationInfo = GetSpecializationInfo
local GetSpecialization = GetSpecialization
local GetUnitSpeed = GetUnitSpeed
local UnitAffectingCombat = UnitAffectingCombat
local UnitExists = ObjectExists or UnitExists
local C_Timer = C_Timer

local GetKeyState = GetKeyState
local ObjectPosition = ObjectPosition
local MoveTo = MoveTo

NeP.Interface:AddToggle({
		key = 'AutoMove',
		name = 'Auto Move',
		text = 'Automatically move to your target',
		icon = 'Interface\\Icons\\ability_monk_legsweep',
		nohide = true
})

local awsd = {65, 83, 68, 87}
function CH.manualMoving()
  for i=1, #awsd do
    if GetKeyState(awsd[i]) then
      return true
    end
  end
end

function CH.Move()
	local specIndex = GetSpecializationInfo(GetSpecialization())
	local tRange = NeP.ClassTable:GetRange(specIndex)
	local Range = NeP.DSL:Get("range")("player", "target")
	local unitSpeed = GetUnitSpeed('player')
	-- Stop Moving
	if Range > tRange and unitSpeed ~= 0 then
		local pX, pY, pZ = ObjectPosition('player')
		MoveTo(pX, pY, pZ)
	-- Start Moving
	elseif Range < tRange then
		local oX, oY, oZ = ObjectPosition('target')
		MoveTo(oX, oY, oZ)
	end
end

-- Ticker
C_Timer.NewTicker(0.5, (function()
	if UnitAffectingCombat('player')
	and UnitExists('target')
	and NeP.DSL:Get('toggle')(nil, 'mastertoggle')
	and NeP.DSL:Get('toggle')(nil, 'AutoMove')
	and not NeP.DSL:Get('casting')('player')
	and not CH:manualMoving() then
		CH:Move()
	end
end), nil)
