---==================================================================================================---
--------------------------------------------------------------------------------------------------------
-----------------------------------(Функции под постоянным обновлением)---------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---

local _M = {}

function _M.update()
   local subscribes = {
      battery = require("gamedata.scripts.sgm.battery"),
      blackday = require("gamedata.scripts.sgm.blackday"),
      hud = require("gamedata.scripts.sgm.huds"),
      loot = require("gamedata.scripts.sgm.loot_manager"),
      ammo = require("gamedata.scripts.lib.dunin_ammo"),
      ui_elements = ui_mod_elements.allspawn_editor_update,
      ui_pda = ui_mod_pda.pda_update,
      mp3 = ui_mod_elements.mp3_update,
      anomaly_cleaner = require("gamedata.scripts.sgm.cleaner").AnomalyCleaner,
      monster_cleaner = require("gamedata.scripts.sgm.cleaner").MonsterCleaner,
      distance = require("gamedata.scripts.sgm.distance"),
      effects = sgm_effects.effects_main,
      rewarder = require("gamedata.scripts.sgm.rewarder"),
      utils_part_1 = sgm_utils.utils_main_1,
      utils_part_2 = sgm_utils.utils_main_2,
      inventory = sgm_inventory.inventory_main,
      options = sgm_options.options_main,
      message = sgm_message.message_main,
      queue = require("gamedata.scripts.sgm.queue"),
      task = sgm_tasks.task_main,
      offline = sgm_offline.offline_main,
      variables = sgm_variables.variables_main,
      spawner = sgm_spawner.spawner_main,
      utilizator = sgm_utilizator.utilizator_main,
      respawn = sgm_respawn.respawn_main,
      module_actor = sgm_modules.module_actor,
      mechanics = sgm_mechanics.mechanics_main,
      timers = require("gamedata.scripts.sgm.timers")
   }

   -- Моментальные
   subscribes.battery:update()
   subscribes.ammo.on_update()
   subscribes.ui_elements()
   -- todo попробовать убрать
   subscribes.loot:update()
   subscribes.effects()
   subscribes.hud:update()
   subscribes.inventory()
   subscribes.options()
   subscribes.queue:update()
   subscribes.variables()
   subscribes.module_actor(db.actor)
   subscribes.timers.update()
   -- Вспомогательные
   _M.checkShoot()
   _M.changeWebMoneyByMagnatBonus()
   _M.manageSlots()
   _M.displayDistanceDebugMarker()

   -- Обновления по секундам
   if check_seconds(1) then
      subscribes.distance:update()
      subscribes.utils_part_1()
      subscribes.utils_part_2()
      subscribes.message()
      subscribes.task()
      _M.showRestrictor()
   end
   if check_seconds(2) then
      subscribes.mp3()
      subscribes.rewarder:update()
      _M.weatherControl()
   end
   if check_seconds(3) then
      subscribes.blackday:update()
      subscribes.anomaly_cleaner:update()
      subscribes.monster_cleaner:update()
      subscribes.offline()
      subscribes.respawn()
   end
   if check_seconds(4) then
      subscribes.ui_pda()
   end
   if check_seconds(5) then
      subscribes.spawner()
      if check_ui_worked(true) then
         pda.check_and_found_pda_areas()
      end
   end
   if check_seconds(20) then
      _M.debugToFile()
   end
   if check_seconds(30) then
      subscribes.utilizator()
      subscribes.mechanics()
   end
end

--/Контроль погоды вне выброса и затмения.
function _M.weatherControl()
   if dont_has_alife_info("blackday_is_active") and dont_has_alife_info("vibros_is_active") then
      if level_weathers.get_weather_manager().weather_fx then
         level.stop_weather_fx()
      end
   end
end

--/Определитель стрельбы ГГ. Выводит на callback.
function _M.checkShoot()
   local active_item = db.actor:active_item()
   if active_item then
      if sgm_flags.string_shot_item_name ~= active_item:section() then
         sgm_flags.string_shot_item_name = active_item:section()
         sgm_flags.value_shot_item_ammo = -1
      end
      if sgm_flags.value_shot_item_ammo ~= active_item:get_ammo_in_magazine() then
         if sgm_flags.value_shot_item_ammo ~= -1 and sgm_flags.value_shot_item_ammo > active_item:get_ammo_in_magazine() and precond_hud() then
            SendScriptCallback("weapon_shoot", active_item)
         end
         sgm_flags.value_shot_item_ammo = active_item:get_ammo_in_magazine()
      end
   end
end

--/Отображение зон в которые входит ГГ.
function _M.showRestrictor()
   if sgm_flags.bool_show_restrictors == true then
      for k, v in pairs(db.zone_by_name) do
         if k ~= nil and actor_in_restrictor(k) then
            give_quick_news(k)
         end
      end
   end
end

--/Бонус достижения "Электронный магнат".
function _M.changeWebMoneyByMagnatBonus()
   if has_alife_info("sgm_achievements_magnate") then
      change_flag_value("value_webmoney_course_from", 90)
      change_flag_value("value_webmoney_course_before", 185)
      change_flag_value("value_card_21_max_rate", 2000)
   end
end

--/Проверка слота на содержание. Выводит на callback.
function _M.manageSlots()
   if db.actor:item_in_slot(2) ~= nil then
      if sgm_flags.table_mod_callbacks["on_slot_2"] == nil then sgm_flags.table_mod_callbacks["on_slot_2"] = false end
      if sgm_flags.table_mod_callbacks["on_slot_2"] == false then
         sgm_flags.table_mod_callbacks["on_slot_2"] = true
         SendScriptCallback("slot_2")
      end
      if sgm_flags.table_mod_callbacks["on_slot_2_i"] == nil then
         sgm_flags.table_mod_callbacks["on_slot_2_i"] = db
             .actor:item_in_slot(2):section()
      end
      if sgm_flags.table_mod_callbacks["on_slot_2_i"] ~= db.actor:item_in_slot(2):section() then
         sgm_flags.table_mod_callbacks["on_slot_2_i"] = db.actor:item_in_slot(2):section()
         SendScriptCallback("slot_2")
      end
   else
      if sgm_flags.table_mod_callbacks["on_slot_2"] == nil then sgm_flags.table_mod_callbacks["on_slot_2"] = true end
      if sgm_flags.table_mod_callbacks["on_slot_2"] == true then
         sgm_flags.table_mod_callbacks["on_slot_2"] = false
         SendScriptCallback("slot_2")
      end
   end
   if db.actor:item_in_slot(3) ~= nil then
      if sgm_flags.table_mod_callbacks["on_slot_3"] == nil then sgm_flags.table_mod_callbacks["on_slot_3"] = false end
      if sgm_flags.table_mod_callbacks["on_slot_3"] == false then
         sgm_flags.table_mod_callbacks["on_slot_3"] = true
         SendScriptCallback("slot_3")
      end
      if sgm_flags.table_mod_callbacks["on_slot_3_i"] == nil then
         sgm_flags.table_mod_callbacks["on_slot_3_i"] = db
             .actor:item_in_slot(3):section()
      end
      if sgm_flags.table_mod_callbacks["on_slot_3_i"] ~= db.actor:item_in_slot(3):section() then
         sgm_flags.table_mod_callbacks["on_slot_3_i"] = db.actor:item_in_slot(3):section()
         SendScriptCallback("slot_3")
      end
   else
      if sgm_flags.table_mod_callbacks["on_slot_3"] == nil then sgm_flags.table_mod_callbacks["on_slot_3"] = true end
      if sgm_flags.table_mod_callbacks["on_slot_3"] == true then
         sgm_flags.table_mod_callbacks["on_slot_3"] = false
         SendScriptCallback("slot_3")
      end
   end
   if db.actor:item_in_slot(7) ~= nil then
      if sgm_flags.table_mod_callbacks["on_slot_7"] == nil then sgm_flags.table_mod_callbacks["on_slot_7"] = false end
      if sgm_flags.table_mod_callbacks["on_slot_7"] == false then
         sgm_flags.table_mod_callbacks["on_slot_7"] = true
         SendScriptCallback("slot_7")
      end
      if sgm_flags.table_mod_callbacks["on_slot_7_i"] == nil then
         sgm_flags.table_mod_callbacks["on_slot_7_i"] = db
             .actor:item_in_slot(7):section()
      end
      if sgm_flags.table_mod_callbacks["on_slot_7_i"] ~= db.actor:item_in_slot(7):section() then
         sgm_flags.table_mod_callbacks["on_slot_7_i"] = db.actor:item_in_slot(7):section()
         SendScriptCallback("slot_7")
      end
   else
      if sgm_flags.table_mod_callbacks["on_slot_7"] == nil then sgm_flags.table_mod_callbacks["on_slot_7"] = true end
      if sgm_flags.table_mod_callbacks["on_slot_7"] == true then
         sgm_flags.table_mod_callbacks["on_slot_7"] = false
         SendScriptCallback("slot_7")
      end
   end
   if db.actor:item_in_slot(12) ~= nil then
      if sgm_flags.table_mod_callbacks["on_slot_12"] == nil then sgm_flags.table_mod_callbacks["on_slot_12"] = false end
      if sgm_flags.table_mod_callbacks["on_slot_12"] == false then
         sgm_flags.table_mod_callbacks["on_slot_12"] = true
         SendScriptCallback("slot_12")
      end
      if sgm_flags.table_mod_callbacks["on_slot_12_i"] == nil then
         sgm_flags.table_mod_callbacks["on_slot_12_i"] = db
             .actor:item_in_slot(12):section()
      end
      if sgm_flags.table_mod_callbacks["on_slot_12_i"] ~= db.actor:item_in_slot(12):section() then
         sgm_flags.table_mod_callbacks["on_slot_12_i"] = db.actor:item_in_slot(12):section()
         SendScriptCallback("slot_12")
      end
   else
      if sgm_flags.table_mod_callbacks["on_slot_12"] == nil then sgm_flags.table_mod_callbacks["on_slot_12"] = true end
      if sgm_flags.table_mod_callbacks["on_slot_12"] == true then
         sgm_flags.table_mod_callbacks["on_slot_12"] = false
         SendScriptCallback("slot_12")
      end
   end
end

--/Отображение дистанции к отладочному маяку.
function _M.displayDistanceDebugMarker()
   if sgm_flags.bool_remote_marker == true then
      if sgm_flags.value_remote_marker ~= 0 then
         show_hud_message(distance_between_safe(db.actor, level.object_by_id(sgm_flags.value_remote_marker)) ..
            " метр(ов)")
      end
   end
end

--/Отладка игровых данных в файл.
function _M.debugToFile()
   if sgm_functions.read_variable("sigerous_top_name") ~= nil and sgm_functions.read_variable("sigerous_top_location") ~= nil and sgm_functions.read_variable("sigerous_top_name") ~= "nil" and sgm_functions.read_variable("sigerous_top_location") ~= "nil" then
      if sgm_functions.read_variable("sigerous_top_difficulty") ~= nil then
         local r_diff = sgm_functions.read_variable("sigerous_top_difficulty")
         if r_diff ~= get_difficulty() then
            if sgm_functions.read_variable("sigerous_top_allowed") == "true" then
               sgm_functions.write_variable("sigerous_top_allowed", "false")
               run_choose_box("yes", "sigerous_top", game.translate_string("st_sigerous_top_5_text"))
            end
         else
            if sgm_functions.read_variable("sigerous_top_allowed") == "false" then
               if not get_flag_value("bool_cheat_mode_activate") then
                  sgm_functions.write_variable("sigerous_top_allowed", "true")
               end
            end
         end
      end
      sigerous_top_update()
   end
end

return _M
-------------------------------------//Copyright GeJorge//-------------------------------------------------