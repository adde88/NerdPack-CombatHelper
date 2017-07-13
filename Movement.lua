-- Dont even load if not using advaned
if not IsHackEnabled then return end

local _, CH = ...
local NeP = NeP
local GetKeyState = GetKeyState

NeP.Interface:AddToggle({
		key = 'AutoMove',
		name = 'Auto Move',
		text = 'Automatically move to your target',
		icon = 'Interface\\Icons\\ability_monk_legsweep',
		nohide = true
})

local awsd = {'65', '83', '68', '87'}
function CH:manualMoving()
  for i=1, #awsd do
		print(awsd[i])
    if GetKeyState(awsd[i]) then
      return true
    end
  end
end

function CH:Move()
	-- TODO
end
