-- 'Запись глобальной переменной в таблицу, из которой эти данные потом перекочуют в файл.
_G.write_mod_param = function(variable_name, variable_value)
   sgm_flags.table_mod_data_actor[variable_name] = variable_value
end

-- 'Ликвидация глобальной переменной.
_G.clear_mod_param = function(variable_name)
   sgm_flags.table_mod_data_actor[variable_name] = nil
   sgm_flags.table_mod_data_actor_cleaner[variable_name] = true
end

-- 'Запись глобальной переменной для объекта.
_G.write_obj_mod_param = function(obj, variable_name, variable_value, is_id)
   local obj_id
   if is_id == true then
      obj_id = obj
   else
      obj_id = obj:id()
   end
   if sgm_flags.table_mod_data_object[obj_id] == nil then
      sgm_flags.table_mod_data_object[obj_id] = {}
   end
   sgm_flags.table_mod_data_object[obj_id][variable_name] = variable_value
end

-- 'Ликвидация глобальной переменной для объекта.
_G.clear_obj_mod_param = function(obj, variable_name, is_id)
   local obj_id
   if is_id == true then
      obj_id = obj
   else
      obj_id = obj:id()
   end
   if sgm_flags.table_mod_data_object[obj_id] ~= nil and sgm_flags.table_mod_data_object[obj_id][variable_name] ~= nil then
      sgm_flags.table_mod_data_object[obj_id][variable_name] = nil
   end
   if sgm_flags.table_mod_data_object_cleaner[obj_id] == nil then
      sgm_flags.table_mod_data_object_cleaner[obj_id] = {}
   end
   sgm_flags.table_mod_data_object_cleaner[obj_id][variable_name] = true
end

-- 'Установка глобальной переменной на 0 в том случае, если переменной еще не создано.
_G.mod_param_set_safe = function(variable_name, val)
   if read_mod_param(variable_name) == nil then
      if val == nil then
         write_mod_param(variable_name, 0)
      else
         write_mod_param(variable_name, val)
      end
   end
end

-- 'Поднять значение глобальной переменной на единицу.
_G.inc_mod_param = function(counter_name, add_value)
   if read_mod_param(counter_name) == nil then write_mod_param(counter_name, 0) end
   if add_value == nil then add_value = 1 end
   if read_mod_param(counter_name) ~= nil then
      local counter = read_mod_param(counter_name)
      write_mod_param(counter_name, counter + add_value)
   end
end

-- 'Скостить значение глобальной переменной на единицу.
_G.dec_mod_param = function(counter_name, add_value, safe)
   if read_mod_param(counter_name) == nil and safe == true then return end
   if read_mod_param(counter_name) == nil then write_mod_param(counter_name, 0) end
   if add_value == nil then add_value = 1 end
   if read_mod_param(counter_name) ~= nil then
      local counter = read_mod_param(counter_name)
      write_mod_param(counter_name, counter - add_value)
   end
end

-- 'Проверка быстрого сохранения.
_G.data_param_save_write = function()
   if sgm_flags.string_savegame_type == "default" then
      data_param_save_game(user_name() .. "-" .. "quicksave")
   end
   sgm_flags.string_savegame_type = "default"
end

-- 'Коллбек на любое сохранение игры.
_G.data_param_save_game = function(save_name)
   sgm_functions.write_variable("mod_params_savegame", data_param_get_save_name(save_name))
end

-- 'Нанесение повреждений обьекту.
_G.set_hit_damage_to = function(victim, h_type, h_power, h_impulse, is_actor_hit)
   if victim then
       local damage_hit = hit()
       if is_actor_hit == true then
           damage_hit.draftsman = db.actor
       else
           damage_hit.draftsman = victim
       end
       if exists(h_type) then
           damage_hit.type = h_type
       else
           damage_hit.type = hit.wound
       end
       if is_actor_hit == true then
           damage_hit.direction = db.actor:position():sub(victim:position())
           if IsStalker(victim) then
               damage_hit:bone("bip01_spine")
           end
       end
       if exists(h_power) then
           damage_hit.power = h_power
       else
           damage_hit.power = 10
       end
       if exists(h_impulse) then
           damage_hit.impulse = h_impulse
       else
           damage_hit.impulse = 15
       end
       victim:hit(damage_hit)
   end
end

-- 'Настройка фактора недосыпания.
_G.set_sleep_factor = function(type, value)
   local sleep_factor = read_mod_param("sleep_factor")
   if type == "-" then
      if sleep_factor ~= nil then
         write_mod_param("sleep_factor", sleep_factor - value)
      end
   elseif type == "+" then
      if sleep_factor ~= nil then
         write_mod_param("sleep_factor", sleep_factor + value)
      end
   end
end

-- 'Исправление значения флага.
_G.change_flag_value = function(param, value)
   if sgm_flags[param] ~= value then
      sgm_flags[param] = value
   end
end

-- 'Установка текущего предмета заказа для торговца.
_G.edit_trader_order = function(trader_name, order_item)
   local saver = require("gamedata.scripts.sgm.save")
   if saver.statistic.trader.orders[trader_name] == nil then return end
   if saver.statistic.trader.orders[trader_name] ~= order_item then
      saver.statistic.trader.orders[trader_name] = order_item
   end
end

-- 'Установка текущего времени заказа для торговца.
_G.edit_trader_order_time = function(trader_name, time_minutes)
   local saver = require("gamedata.scripts.sgm.save")
   if saver.statistic.trader.orders[trader_name .. "_t"] == nil then return end
   if saver.statistic.trader.orders[trader_name .. "_t"] ~= nil then
      if time_minutes == -1 then
         saver.statistic.trader.orders[trader_name .. "_t"] = 0
      else
         saver.statistic.trader.orders[trader_name .. "_t"] = get_general_game_time() + time_minutes
      end
   end
end

-- 'Редактирование счетчиков статистики.
_G.edit_statistic_counter = function(type, counter_name, value, action)
   local saver = require("gamedata.scripts.sgm.save")
   if value == nil then value = 1 end
   if action == nil then action = "+" end
   if type == "k_m" then
      if action == "+" then
         saver.statistic.killed.monsters[counter_name] = saver.statistic.killed.monsters[counter_name] + value
      else
         saver.statistic.killed.monsters[counter_name] = saver.statistic.killed.monsters[counter_name] - value
      end
   elseif type == "k_s" then
      if action == "+" then
         saver.statistic.killed.stalkers[counter_name] = saver.statistic.killed.stalkers[counter_name] + value
      else
         saver.statistic.killed.stalkers[counter_name] = saver.statistic.killed.stalkers[counter_name] - value
      end
   end
end
-- 'Заставить ГГ спрятать оружие во время использования предмета.
_G.set_item_activation = function(val)
   start_flague_timer("timer_item_activation", val)
end

-- 'Установка отношений одной группировки к другой.
_G.set_faction_to_faction_relation = function(from_faction, to_faction, type_relation, double_effect)
   local relation_value = 0
   if type_relation == "enemy" or type_relation == "e" then
      relation_value = -5000
   elseif type_relation == "neutral" or type_relation == "n" then
      relation_value = 0
   elseif type_relation == "friend" or type_relation == "f" then
      relation_value = 5000
   end
   relation_registry.set_community_relation(from_faction, to_faction, relation_value)
   if double_effect == true then
      relation_registry.set_community_relation(to_faction, from_faction, relation_value)
   end
end

-- 'Ухудшить отношения между группировкой и ГГ.
_G.decrease_faction_goodwill = function(community, value)
    game_relations.change_factions_community_num(community, db.actor:id(), -tonumber(value))
end

-- 'Установка/удаление метки на обьекте.
_G.set_spot_choose = function(obj_id, location_name, type, descr)
   if type == "hide" and obj_id ~= nil then
      remove_spot_on_map(obj_id, location_name)
   elseif type == "show" and obj_id ~= nil then
      add_spot_on_map(obj_id, location_name, descr)
   end
end

-- 'Установка отсутствия UI.
_G.set_ui_disabled = function()
   sgm_flags.bool_is_ui_disabled = true
end

-- 'Установка присутствия UI.
_G.set_ui_worked = function()
   sgm_flags.bool_is_ui_disabled = false
end

-- 'Установка отсутствия UI.
_G.set_ui_disable = function(val)
   sgm_flags.is_ui_disabled=val
end