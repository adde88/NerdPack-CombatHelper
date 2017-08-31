local _, CH = ...

function CH.Load_Move()

	-- Dont even load if not using advaned
	if not HackEnabled then return end

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

	return true
end

NeP.Protected:AddCallBack(CH.Load_Move)
