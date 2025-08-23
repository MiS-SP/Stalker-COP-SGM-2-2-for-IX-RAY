local battery_power_bar = nil
---==================================================================================================---
--------------------------------------------------------------------------------------------------------
------------------------------------------(Утилиты)-----------------------------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---
-- 'Вывод на экран полосы прогресса. Вербовка монстров.
function show_battery_power_bar(hud_name, xml_name, xml_sect, show_func, show_text)
   local hud = get_hud()
   local xml = CScriptXmlInit()
   if hud:GetCustomStatic(hud_name) == nil then
      add_hud(hud_name, show_text)
      xml:ParseFile(xml_name)
      battery_power_bar = xml:InitProgressBar(xml_sect, hud:GetCustomStatic(hud_name):wnd())
      if hud:GetCustomStatic(hud_name) ~= nil then
         add_hud(hud_name, show_text)
         bar_level = show_func
         if bar_level ~= nil then
            battery_power_bar:Show(true)
            battery_power_bar:SetProgressPos(bar_level)
         end
      end
   elseif hud:GetCustomStatic(hud_name) ~= nil then
      xml:ParseFile(xml_name)
      add_hud(hud_name, show_text)
      bar_level = show_func
      if bar_level ~= nil then
         battery_power_bar:Show(true)
         battery_power_bar:SetProgressPos(bar_level)
      end
   end
end

---==================================================================================================---
--------------------------------------------------------------------------------------------------------
-----------------------------(Аккумулятор для детектора)------------------------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---
local instance = nil
local Class = require('gamedata.scripts.lib.oop').Class
local Battery = Class()

function Battery:init()
   self.active_battery_id = 0
   self.active_battery_type = 0
   self.active_battery_power = 0
   self.send_tip_pause = 0
end

function Battery:update()
   if device().precache_frame > 0 or sgm_flags.bool_is_ui_disabled == true then return end
   if db.actor:active_detector() then
      self:detector_used(db.actor:item_in_slot(9))
   else
      self:detector_not_used()
   end
   self:restart_timers()
end

function Battery:detector_used(detector)
   local d_section = detector:section()
   local d_id = detector:id()
   if get_item_count("detector_battery", true) == 0 and get_item_count("detector_accum", true) == 0 then
      self:detector_throw()
   else
      self:battery_check()
      self:battery_spend()
   end
end

function Battery:detector_not_used()
   self:battery_power_bar_clear()
end

function Battery:detector_throw()
   throw_item_from_slot(9)
   if level.object_by_id(self.active_battery_id) == nil then
      self.active_battery_id = 0
      self.active_battery_type = 0
      self.active_battery_power = 0
   end
   if self.send_tip_pause == 0 then
      self:send_tip("st_detector_battery_discharged")
   end
end

function Battery:battery_select()
   if db.actor:object("detector_battery_1") then
      self.active_battery_type = 1
      self.active_battery_id = db.actor:object("detector_battery_1"):id()
      self.active_battery_power = sgm_functions.ReadBatteryPower("detector_battery_1")
   elseif db.actor:object("detector_battery_2") then
      self.active_battery_type = 2
      self.active_battery_id = db.actor:object("detector_battery_2"):id()
      self.active_battery_power = sgm_functions.ReadBatteryPower("detector_battery_2")
   elseif db.actor:object("detector_battery_3") then
      self.active_battery_type = 3
      self.active_battery_id = db.actor:object("detector_battery_3"):id()
      self.active_battery_power = sgm_functions.ReadBatteryPower("detector_battery_3")
   end
   give_object_to_actor("detector_accum_" .. self.active_battery_type .. "_activated")
end

function Battery:battery_choose(value)
   if db.actor:object("detector_accum_" .. value .. "_activated") and db.actor:object("detector_battery_" .. value) then
      if self.active_battery_id ~= db.actor:object("detector_accum_" .. value .. "_activated"):id() then
         remove_object_by_id(self.active_battery_id)
         self.active_battery_id = db.actor:object("detector_accum_" .. value .. "_activated"):id()
      end
   end
end

function Battery:battery_check()
   if self.active_battery_id == 0 then
      self:battery_select()
   end
   local obj_battery = level.object_by_id(self.active_battery_id)
   if obj_battery:parent() == nil or obj_battery:parent():id() ~= db.actor:id() then
      remove_object_by_id(self.active_battery_id)
      self:battery_select()
   end
end

function Battery:battery_spend()
   if check_seconds(1) then
      self.active_battery_power = self.active_battery_power - 1
   end
   self:battery_choose(self.active_battery_type)
   if self.active_battery_power <= 0 then
      remove_object_by_id(self.active_battery_id)
      self.active_battery_id = 0
      self.active_battery_type = 0
      self.active_battery_power = 0
      self:send_tip("st_detector_battery_replaced")
   end
   self:battery_power_bar_setup()
end

function Battery:battery_power_bar_setup()
   if self.active_battery_type ~= 0 then
      show_battery_power_bar("hud_battery_power_wnd", "ui_mod_progress_bars.xml",
         "battery_power_" .. self.active_battery_type .. "_bar", self.active_battery_power)
   else
      self:battery_power_bar_clear()
   end
end

function Battery:battery_power_bar_clear()
   release_hud("hud_battery_power_wnd")
end

function Battery:send_tip(text)
   news_manager.send_tip(db.actor, text, 0, "detector_battery", 3000, nil, "st_add_info_title")
   self.send_tip_pause = time_global() + 6000
end

function Battery:restart_timers()
   if self.send_tip_pause ~= 0 then if time_global() >= self.send_tip_pause then self.send_tip_pause = 0 end end
end

function Battery:save(packet)
   packet:w_u32(self.active_battery_id)
   packet:w_u32(self.active_battery_type)
   packet:w_u32(self.active_battery_power)
end

function Battery:load(packet)
   get_instance()
   self.active_battery_id = packet:r_u32()
   self.active_battery_type = packet:r_u32()
   self.active_battery_power = packet:r_u32()
end

function get_instance()
   if instance == nil then
      instance = Battery()
   end
   return instance
end

return get_instance()

-------------------------------------//Copyright GeJorge//-------------------------------------------------
