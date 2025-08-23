---==================================================================================================---
--------------------------------------------------------------------------------------------------------
------------------------------------------(Химчистка)---------------------------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---
local Class = require('gamedata.scripts.lib.oop').Class

local _M = {}

local Cleaner = Class()
Cleaner.alife_limit = 65534

function Cleaner:clean()
end

function Cleaner:clean_all()
end

function Cleaner:update()
   self:clean_all()
end

local MonsterCleaner = Class(Cleaner)
local StalkerCleaner = Class(Cleaner)
local AnomalyCleaner = Class(Cleaner)
AnomalyCleaner.is_not_new_level = (level.name() ~= "darkvalley" and level.name() ~= "military" and level.name() ~= "agroprom" and level.name() ~= "escape" and level.name() ~= "marsh" and level.name() ~= "red_forest")
local WeaponCleaner = Class(Cleaner)
local MineCleaner = Class(Cleaner)

function MonsterCleaner:clean_all(range_min, range_max)
   for a = 1, self.alife_limit do
      local obj = alife():object(a)
      if obj and IsMonster(obj) and (not obj:alive()) and get_object_story_id(obj.id) == nil then
         if range_min == nil and range_max == nil then
            remove_object_by_id(obj.id)
         elseif range_min ~= nil and range_max == nil then
            if db.actor:position():distance_to(obj.position) >= range_min then
               remove_object_by_id(obj.id)
            end
         elseif range_min == nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         elseif range_min ~= nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) >= range_min and db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         end
      end
   end
end

function MonsterCleaner:update()
   if r_mod_params("number", "monsters_cleaner_interval", 0) > 0 then
      if check_game_timer("m_cleaner_timer") == nil then
         start_game_timer("m_cleaner_timer", r_mod_params("number", "monsters_cleaner_interval", 0))
      end
   else
      abort_game_timer("m_cleaner_timer")
   end
   if check_game_timer("m_cleaner_timer") then
      self:clean_all(15)
      start_game_timer("m_cleaner_timer", r_mod_params("number", "monsters_cleaner_interval", 0))
   end
end

function StalkerCleaner:clean_all(range_min, range_max)
   for a = 1, self.alife_limit do
      local obj = alife():object(a)
      if obj and IsStalker(obj) and (not obj:alive()) and get_object_story_id(obj.id) == nil then
         if range_min == nil and range_max == nil then
            remove_object_by_id(obj.id)
         elseif range_min ~= nil and range_max == nil then
            if db.actor:position():distance_to(obj.position) >= range_min then
               remove_object_by_id(obj.id)
            end
         elseif range_min == nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         elseif range_min ~= nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) >= range_min and db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         end
      end
   end
end

function AnomalyCleaner:clean_all(range_min, range_max)
   for a = 1, self.alife_limit do
      local obj = alife():object(a)
      if obj and obj:section_name() ~= nil and self.is_not_new_level and get_object_story_id(obj.id) == nil and ((string.find(obj:section_name(), "sgm_") and (not string.find(obj:name(), "quest_anomaly")) and (string.find(obj:section_name(), "field") or string.find(obj:section_name(), "streem"))) or string.find(obj:name(), "throw_zone") or string.find(obj:name(), "artefact_spawner_mod")) then
         if range_min == nil and range_max == nil then
            remove_object_by_id(obj.id)
         elseif range_min ~= nil and range_max == nil then
            if db.actor:position():distance_to(obj.position) >= range_min then
               remove_object_by_id(obj.id)
            end
         elseif range_min == nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         elseif range_min ~= nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) >= range_min and db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         end
      end
   end
end

function AnomalyCleaner:update()
   if r_mod_params("bool", "create_anomaly_permition", true) == false and dont_has_alife_info("anomaly_permition_activate") then
      self:clean_all()
      give_info("anomaly_permition_activate")
   elseif r_mod_params("bool", "create_anomaly_permition", true) == true and has_alife_info("anomaly_permition_activate") then
      disable_info("anomaly_permition_activate")
   end
end

function WeaponCleaner:clean_all(range_min, range_max)
   for a = 1, self.alife_limit do
      local obj = alife():object(a)
      local obj_logic = obj:spawn_ini()
      if obj and obj:section_name() ~= nil and (find_in_string(obj:section_name(), "wpn_") or find_in_string(obj:section_name(), "grenade")) and ((obj_logic == nil) or (obj_logic ~= nil and not spawn_ini:section_exist("secret"))) and get_object_story_id(obj.id) == nil and (level.object_by_id(obj.id) == nil or level.object_by_id(obj.id):parent() == nil) and (get_weapon_type(obj:section_name()) == "grenade" or get_weapon_type(obj:section_name()) == "rifle" or get_weapon_type(obj:section_name()) == "pistol" or get_weapon_type(obj:section_name()) == "shotgun") then
         if range_min == nil and range_max == nil then
            remove_object_by_id(obj.id)
         elseif range_min ~= nil and range_max == nil then
            if db.actor:position():distance_to(obj.position) >= range_min then
               remove_object_by_id(obj.id)
            end
         elseif range_min == nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         elseif range_min ~= nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) >= range_min and db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         end
      end
   end
end

function MineCleaner:clean_all(range_min, range_max)
   for a = 1, self.alife_limit do
      local obj = alife():object(a)
      if obj and obj:section_name() ~= nil and string.find(obj:section_name(), "_mine_trap_") then
         if range_min == nil and range_max == nil then
            remove_object_by_id(obj.id)
         elseif range_min ~= nil and range_max == nil then
            if db.actor:position():distance_to(obj.position) >= range_min then
               remove_object_by_id(obj.id)
            end
         elseif range_min == nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         elseif range_min ~= nil and range_max ~= nil then
            if db.actor:position():distance_to(obj.position) >= range_min and db.actor:position():distance_to(obj.position) <= range_max then
               remove_object_by_id(obj.id)
            end
         end
      end
   end
end

_M.MonsterCleaner = MonsterCleaner
_M.StalkerCleaner = StalkerCleaner
_M.AnomalyCleaner = AnomalyCleaner
_M.WeaponCleaner = WeaponCleaner
_M.MineCleaner = MineCleaner

return _M

-------------------------------------//Copyright GeJorge//-------------------------------------------------
