if myHero.charName ~= "Talon" then return end
require "DamageLib"
local Q = { range = myHero:GetSpellData(_Q).range, delay = myHero:GetSpellData(_Q).delay, speed = myHero:GetSpellData(_Q).speed, width = myHero:GetSpellData(_Q).width }
local W = { range = myHero:GetSpellData(_W).range, delay = myHero:GetSpellData(_W).delay, speed = myHero:GetSpellData(_W).speed, width = myHero:GetSpellData(_W).width }
local E = { range = myHero:GetSpellData(_E).range, delay = myHero:GetSpellData(_E).delay, speed = myHero:GetSpellData(_E).speed, width = myHero:GetSpellData(_E).width }
local R = { range = myHero:GetSpellData(_R).range, delay = myHero:GetSpellData(_R).delay, speed = myHero:GetSpellData(_R).speed, width = myHero:GetSpellData(_R).width }
local TalonMenu = MenuElement({type = MENU, id = "Talon De Aquiles", name = "Talon"})
TalonMenu:MenuElement({type = MENU, id = "Key", name = "Key Settings"})
TalonMenu.Key:MenuElement({id = "ComboKey", name = "Combo Key",key = 32 })
TalonMenu.Key:MenuElement({id = "HarassKey", name = "Harass Key",key = string.byte("C") })
TalonMenu:MenuElement({type = MENU, id = "Combo", name = "Combo Settings"})
TalonMenu.Combo:MenuElement({id = "UseQ", name = "Use Q", value = true})
TalonMenu.Combo:MenuElement({id = "UseW", name = "Use W", value = true})
TalonMenu.Combo:MenuElement({id = "UseR", name = "Use R", value = false})
TalonMenu:MenuElement({type = MENU, id = "Harass", name = "Harass Settings"})
TalonMenu.Harass:MenuElement({id = "UseHW", name = "Use W", value = true})
function GetTargetxd(range)
	local result = nil
	local N = math.huge
	for i = 1,Game.HeroCount()  do
		local hero = Game.Hero(i)	
		if isValidTarget(hero,range) and hero.isEnemy then
			local dmgtohero = getdmg("AA",hero,myHero) or 1
			local tokill = hero.health/dmgtohero
			if tokill < N or result == nil then
				N = tokill
				result = hero
			end
		end
	end
	return result
end
function OnTick() 
	if TalonMenu.Key.ComboKey:Value()	then

    if TalonMenu.Combo.UseR:Value()  and isReady(_R) then
    	local target = GetTargetxd(R.range)
    	if target then
        	Control.CastSpell("R")
        end 
    end
		if isReady(_Q) and TalonMenu.Combo.UseQ:Value() then
			local target = GetTargetxd(Q.range)
			if target   then
				local pos 

					pos = Vector(target.pos)

				if Vector(pos):DistanceTo() < Q.range then
					Control.CastSpell("Q",pos)
				end	
			end
		end
			if isReady(_W) and TalonMenu.Combo.UseW:Value() then
			local target = GetTargetxd(W.range)
			if target   then
				local pos 

					pos = Vector(target.pos)

				if Vector(pos):DistanceTo() < W.range then
					Control.CastSpell("W",pos)
				end	
			end
		end
	end

	if TalonMenu.Key.HarassKey:Value()	then

    if TalonMenu.Harass.UseHW:Value()  and isReady(_W) then
    	local target = GetTargetxd(W.range)
    	if target then
        	Control.CastSpell("W", target)
        end 
    end

end
end
function isReady(slot)
	return Game.CanUseSpell(slot) == READY
end
function isValidTarget(obj,range)
	range = range or math.huge
	return obj ~= nil and obj.valid and obj.visible and not obj.dead and obj.isTargetable and obj.distance <= range
end
function IsImmobileTarget(unit)
	assert(unit, "IsImmobileTarget: invalid argument: unit expected got "..type(unit))
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff and (buff.type == 5 or buff.type == 11 or buff.type == 29 or buff.type == 24 ) and buff.count > 0 then
			return true
		end
	end
	return false	
end
