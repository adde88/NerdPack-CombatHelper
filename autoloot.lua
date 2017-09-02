local _, CH = ...
local icon = 'Interface\\Icons\\trade_archaeology_chestoftinyglassanimals'

function CH.Load_Loot()

	-- DOnt load if not advanced
	if not HackEnabled then return end

	NeP.Interface:AddToggle({
			key = 'AutoLoot',
			name = 'Auto Loot',
			text = 'Automatically loot units around you',
			icon = icon,
			nohide = true
	})

	function CH.Loot()
	    for i=1, GetNumLootItems() do
	        if LootSlotHasItem(i) then LootSlot(i) end
	    end
	    CloseLoot()
	end

	function CH.DoLoot()
	    for _, Obj in pairs(NeP.OM:Get('Dead')) do
	        if Obj.distance < 5 and ObjectIsVisible(Obj.key) then
	            local hl,cl = CanLootUnit(ObjectGUID(Obj.key))
	            if hl and cl then
	                ObjectInteract(Obj.key)
	                NeP.ActionLog:Add("Auto Loot", "Looted", icon, Obj.name)
	                break
	            end
	        end
	    end
	end

	-- Ticker
	C_Timer.NewTicker(0.1, (function()
		if NeP.DSL:Get('toggle')(nil, 'mastertoggle')
		and NeP.DSL:Get('toggle')(nil, 'AutoLoot')
		and not UnitChannelInfo('player')
		and not UnitCastingInfo('player')
	  and not IsMounted("player")
		and not UnitAffectingCombat("player") then
	        if LootFrame:IsShown() then
						CH:Loot()
	        else
						CH:DoLoot()
	        end
		end
	end), nil)

	return true
end

NeP.Protected:AddCallBack(CH.Load_Loot)
