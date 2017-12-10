
if (myHero.charName ~= "Akali") then
  return
end

local scriptName = "AQALEEXD"

local menu = MenuElement({type = MENU, id = "mymenu", name = scriptName})

menu:MenuElement({type = MENU, name = "Combo Menu", id = "combo"})
menu.combo:MenuElement({name = "Use Q", id = "useq", value = true})
menu.combo:MenuElement({name = "Use W (beta)", id = "usew", value = true})
menu.combo:MenuElement({name = "Use E", id = "usee", value = true})
menu.combo:MenuElement({name = "Use R", id = "user", value = true})

menu:MenuElement({type = MENU, name = "Drawings", id = "drawings"})
menu.drawings:MenuElement({name = "Draw Q", id = "drawq", value = false})
menu.drawings:MenuElement({name = "Draw R", id = "drawr", value = false})


local Q = { range = myHero:GetSpellData(_Q).range, delay = myHero:GetSpellData(_Q).delay, speed = myHero:GetSpellData(_Q).speed, width = myHero:GetSpellData(_Q).width }
local W = { range = myHero:GetSpellData(_W).range, delay = myHero:GetSpellData(_W).delay, speed = myHero:GetSpellData(_W).speed, width = myHero:GetSpellData(_W).width }
local E = { range = myHero:GetSpellData(_E).range, delay = myHero:GetSpellData(_E).delay, speed = myHero:GetSpellData(_E).speed, width = myHero:GetSpellData(_E).width }
local R = { range = myHero:GetSpellData(_R).range, delay = myHero:GetSpellData(_R).delay, speed = myHero:GetSpellData(_R).speed, width = myHero:GetSpellData(_R).width }


local Combo = function()
  local target = _G.SDK.TargetSelector:GetTarget(1000, _G.SDK.DAMAGE_TYPE_MAGICAL)

    if (target ~= nil) then

            if (menu.combo.useq:Value() and Game.CanUseSpell(_Q) == READY 
                    and _G.SDK.Utilities:IsInRange(target, myHero, Q.range)) then
        Control.CastSpell(HK_Q, target)
      end
      if (menu.combo.usew:Value() and Game.CanUseSpell(_W) == READY 
                    and _G.SDK.Utilities:IsInRange(target, myHero)) then
        Control.CastSpell(HK_W)
      end
      if (menu.combo.usee:Value() and Game.CanUseSpell(_E) == READY 
                    and _G.SDK.Utilities:IsInRange(target, myHero, E.range)) then
        Control.CastSpell(HK_E)
      end
      if (menu.combo.user:Value() and Game.CanUseSpell(_R) == READY 
                    and _G.SDK.Utilities:IsInRange(target, myHero, R.range)) then
        Control.CastSpell(HK_R, target)
      end


  end
end

local OnTick = function()

  if (myHero.dead) then return end

  if (_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO]) then
    Combo()
  end

end

local OnDraw = function()

  if (myHero.dead) then return end

  if (Game.CanUseSpell(_Q) == READY and menu.drawings.drawq:Value()) then
    Draw.Circle(myHero.pos, Q.range, Draw.Color(180, 131, 131, 255))
  end

  if Game.CanUseSpell(_R) == READY) and menu.drawings.drawr:Value()) then
    Draw.Circle(myHero.pos, R.range, Draw.Color(180, 131, 131, 255))
  end
end

Callback.Add("Tick", function() OnTick() end)
Callback.Add("Draw", function() OnDraw() end)
