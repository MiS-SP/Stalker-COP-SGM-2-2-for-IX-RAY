-- 'Чтение глобальной переменной.
_G.read_mod_param = function(variable_name, safe)
   if sgm_flags.table_mod_data_actor[variable_name] ~= nil then
      return sgm_flags.table_mod_data_actor[variable_name]
   elseif safe == true then
      return 0
   else
      return nil
   end
end

-- 'Чтение глобальной переменной для объекта.
_G.read_obj_mod_param = function(obj, variable_name, is_id, safe)
   local obj_id
   if is_id == true then
      obj_id = obj
   else
      obj_id = obj:id()
   end
   if sgm_flags.table_mod_data_object[obj_id] ~= nil and sgm_flags.table_mod_data_object[obj_id][variable_name] ~= nil then
      return sgm_flags.table_mod_data_object[obj_id][variable_name]
   elseif safe == true then
      return 0
   else
      return nil
   end
end

-- 'Фунция чтения параметров с конфигов.
_G.get_params_by_section = function(ini_name, section, val_type, target_string, default_value, use_action)
   local ini, line = ini_file(ini_name), section
   if val_type == "number" then
      if ini:line_exist(line, target_string) then
         if use_action == nil or use_action == "nil" then
            return ini:r_float(line, target_string)
         elseif use_action == "floor" then
            return ini:r_float(line, target_string) / 100
         elseif use_action == "multiply" then
            return ini:r_float(line, target_string) * 100
         end
      else
         if use_action == nil or use_action == "nil" then
            return default_value
         elseif use_action == "floor" then
            return default_value / 100
         elseif use_action == "multiply" then
            return default_value * 100
         end
      end
   elseif val_type == "string" then
      if ini:line_exist(line, target_string) then
         if use_action == nil or use_action == "nil" then
            return ini:r_string(line, target_string)
         elseif use_action == "floor" then
            return ini:r_string(line, target_string) / 100
         elseif use_action == "multiply" then
            return ini:r_string(line, target_string) * 100
         end
      else
         if use_action == nil or use_action == "nil" then
            return default_value
         elseif use_action == "floor" then
            return default_value / 100
         elseif use_action == "multiply" then
            return default_value * 100
         end
      end
   elseif val_type == "bool" then
      if ini:line_exist(line, target_string) then
         if use_action == nil or use_action == "nil" then
            return ini:r_bool(line, target_string)
         elseif use_action == "floor" then
            return ini:r_bool(line, target_string) / 100
         elseif use_action == "multiply" then
            return ini:r_bool(line, target_string) * 100
         end
      else
         if use_action == nil or use_action == "nil" then
            return default_value
         elseif use_action == "floor" then
            return default_value / 100
         elseif use_action == "multiply" then
            return default_value * 100
         end
      end
   else
      return 0
   end
end

-- 'Считывать главные опции.
_G.r_mod_params = function(val_type, target_string, default_value, use_action)
   return get_params_by_section("mod_parameters\\mod_params.ltx", "mod_params", val_type, target_string, default_value,
      use_action)
end

-- 'Считывать опции отрядов Альфы.
_G.r_alfa_params = function(val_type, target_string, default_value, use_action)
   return get_params_by_section("mod_parameters\\mod_params.ltx", "alfa_params", val_type, target_string, default_value,
      use_action)
end

-- 'Считывать опции ранговой системы.
_G.r_rank_params = function(val_type, target_string, default_value, use_action)
   return get_params_by_section("mod_parameters\\mod_params.ltx", "rank_params", val_type, target_string, default_value,
      use_action)
end

-- 'Считывать опции трофеев.
_G.r_booty_params = function(val_type, target_string, default_value, use_action)
   return get_params_by_section("mod_parameters\\mod_params.ltx", "booty_params", val_type, target_string, default_value,
      use_action)
end

-- 'Считывать опции квестов.
_G.r_quest_params = function(val_type, target_string, default_value, use_action)
   return get_params_by_section("mod_parameters\\mod_params.ltx", "quest_params", val_type, target_string, default_value,
      use_action)
end

-- Чтение ltx числа
_G.read_number = function(section, param, ini_path)
   local ltx_ini = system_ini()
   if ini_path ~= nil and ini_path ~= "nil" then
      ltx_ini = ini_file(ini_path)
   end
   if ltx_ini:line_exist(section, param) then
      return ltx_ini:r_float(section, param)
   else
      return "nil"
   end
end

-- Чтение ltx строки
_G.read_string = function(section, param, ini_path)
   local ltx_ini = system_ini()
   if ini_path ~= nil and ini_path ~= "nil" then
      ltx_ini = ini_file(ini_path)
   end
   if ltx_ini:line_exist(section, param) then
      return ltx_ini:r_string(section, param)
   else
      return "nil"
   end
end

-- 'Проверка глобального шаблона.
_G.get_global_pattern = function()
   if read_mod_param("global_pattern") == nil then return 0 end
   return read_mod_param("global_pattern")
end

-- 'Проверка по типу оружия.
_G.get_weapon_type = function(section_name)
   return sgm_functions.ReadWeaponType(section_name)
end

-- 'Проверка на крепления аддонов.
_G.get_installed_addon = function(wpn, type)
   if wpn ~= nil and type ~= nil then
      if type == "scope" then
         result = wpn:weapon_is_scope()
      elseif type == "silencer" then
         result = wpn:weapon_is_silencer()
      elseif type == "launcher" then
         result = wpn:weapon_is_grenadelauncher()
      end
   end
   return result
end
_G.get_object_squad_name = function(object)
   local squad = _G.get_object_squad(object)
   if squad == nil then
      return nil
   end
   return squad.settings_id
end

-- Получить текущую версиб мода
_G.get_mod_version = function()
   return r_mod_params("string", "mod_version", "2.2.1")
end

-- 'Проверка локации, на которой находится game vertex.
_G.get_level_by_game_vertex = function(gv)
   return alife():level_name(game_graph():vertex(gv):level_id())
end

-- 'Уникальный ID текущей игры. Генерируется когда игрок начинает новую игру.
_G.get_game_unique_id = function()
   if sgm_functions.read_variable("new_game_unique_id") ~= nil then
      return sgm_functions.read_variable("new_game_unique_id")
   end
   return nil
end
-- Получить текущий уровень сложности
_G.get_difficulty = function()
   if level.get_game_difficulty() == 0 then
      return "novice"
   elseif level.get_game_difficulty() == 1 then
      return "stalker"
   elseif level.get_game_difficulty() == 2 then
      return "veteran"
   elseif level.get_game_difficulty() == 3 then
      return "master"
   end
   return "nil"
end

-- Удалить сквад
_G.set_squad_removed = function(object)
   xr_effects.remove_squad(db.actor, nil, { squad_name })
end

-- 'Проверка содержания базы переменных.
_G.data_param_exist = function()
   local founded = false
   local file_path = get_mod_save_data_path("save_data")
   local file = io.open(file_path, "r")
   for line in file:lines() do
      if find_in_string(tostring(line), "save_data") then
         founded = true
      end
   end
   return founded
end

-- 'Чтение имени сохранения без пробелов.
_G.data_param_get_save_name = function(v_name)
   local file = io.open(get_mod_save_data_path("save_utils"), "w")
   file:write("[save_utils]", "\n")
   file:write("save_name=" .. v_name, "\n")
   file:close()
   return data_param_read_section_1("save_utils", "save_utils", "save_name")[1]
end

-- 'Чтение параметра секции из файла.
_G.data_param_read_section_1 = function(ini_name, sect, str)
   local result = nil
   local file = io.open(get_mod_save_data_path(ini_name), "r")
   for line in file:lines() do
      if find_out_string(tostring(line), "save_data") or find_out_string(tostring(line), "save_utils") then
         local ini = ini_file("mod_parameters\\save_data\\" .. ini_name .. ".sgm")
         local r_d = sgm_functions.check_section_stick(ini, sect, str, nil)
         if exists(r_d) then
            result = r_d
         end
      end
   end
   file:close()
   return result
end

-- 'Возвращение имени последнего сохранения.
_G.get_mod_params_savegame = function()
   if sgm_functions.read_variable("mod_params_savegame") ~= nil then
      return sgm_functions.read_variable("mod_params_savegame")
   else
      return "nil"
   end
end

_G.get_mod_path = function (delimeter)
   local path = getFS():update_path("$game_scripts$", "sgm//")
   print(path)
   return path
end

-- 
_G.get_lib_path = function()
   return getFS():update_path("$game_scripts$", "lib//")
end

---@return string path_to_sgm_data
-- Геттер пути сохранений мода
_G.get_mod_save_data_path = function(filename)
   return getFS():update_path("$app_data_root$", "sgm_data//" .. filename .. ".sgm")
end

-- 'Проверка на установленную взрывчатку.
_G.get_remote_charge_installed = function()
   return read_mod_param("remote_charge_1_id") ~= 0 or read_mod_param("remote_charge_2_id") ~= 0 or
       read_mod_param("remote_charge_3_id") ~= 0
end

_G.get_remote_charge_full_installed = function()
   return read_mod_param("remote_charge_1_id") ~= 0 and read_mod_param("remote_charge_2_id") ~= 0 and
       read_mod_param("remote_charge_3_id") ~= 0
end

-- 'Проверка ранга ГГ.
_G.get_actor_rank = function()
   local result = read_mod_param("actor_rank")
   if result ~= nil and result >= 0.0 and result < 1.0 then
      return 0.0
   elseif result ~= nil and result >= 1.0 then
      return math.floor(result)
   end
   return 0.0
end

-- 'Проверка количества электронных денег ГГ.
_G.get_web_money = function()
   return read_mod_param("actor_web_money")
end

-- 'Просмотр значения флага.
_G.get_flag_value = function(param)
   return sgm_flags[param]
end

-- 'Возвращение текущего предмета заказа для торговца.
_G.get_trader_order = function(trader_name)
   local saver = require("gamedata.scripts.sgm.save")
   if saver.statistic.trader.orders[trader_name] ~= nil and saver.statistic.trader.orders[trader_name] ~= "none" then
      return saver.statistic.trader.orders[trader_name]
   end
   return nil
end

-- 'Возвращение текущего времени заказа для торговца.
_G.get_trader_order_time = function(trader_name)
   local saver = require("gamedata.scripts.sgm.save")
   if saver.statistic.trader.orders[trader_name .. "_t"] ~= nil and saver.statistic.trader.orders[trader_name .. "_t"] ~= 0 and get_general_game_time() >= saver.statistic.trader.orders[trader_name .. "_t"] then
      return true
   end
   return false
end

-- 'Возвращение значения счетчика статистики.
_G.get_statistic_counter = function(type, counter_name)
   local saver = require("gamedata.scripts.sgm.save")
   if type == "k_m" then
      if saver.statistic.killed.monsters[counter_name] ~= nil then
         return saver.statistic.killed.monsters[counter_name]
      end
   elseif type == "k_s" then
      if saver.statistic.killed.stalkers[counter_name] ~= nil then
         return saver.statistic.killed.stalkers[counter_name]
      end
   end
   return nil
end

-- 'Проверка на разрешение затмений.
_G.get_blackday_frequency = function(f_o_s, e_type)
   local g_ini = ini_file("misc\\config_blackday.ltx")
   local g_settings = "settings"
   local g_frequency = sgm_functions.check_section_comma(g_ini, g_settings, "frequency_default", "840,1440", 2)
   if e_type == "start" then
      g_frequency = sgm_functions.check_section_comma(g_ini, g_settings, "frequency_start", "240,660", 2)
   elseif e_type == "night" then
      g_frequency = sgm_functions.check_section_comma(g_ini, g_settings, "frequency_night", "240,700", 2)
   end
   if f_o_s == 1 then
      return tonumber(g_frequency[1])
   else
      return tonumber(g_frequency[2])
   end
end

-- 'Значение смены месяца.
_G.GetUntilGameTime = function()
   if read_mod_param("until_game_time") ~= nil then
      return read_mod_param("until_game_time")
   else
      return 0
   end
end

-- 'Текущее игровое время.
_G.get_parsed_time = function()
   local minutes_time = level.get_time_minutes()
   local hours_time = level.get_time_hours()
   if level.get_time_minutes() >= 0 and level.get_time_minutes() <= 9 then
      data = hours_time .. ":" .. "0" .. minutes_time
   end
   if level.get_time_minutes() >= 10 and level.get_time_minutes() <= 59 then
      data = hours_time .. ":" .. minutes_time
   end
   if level.get_time_minutes() >= 0 and level.get_time_minutes() <= 9 and level.get_time_hours() >= 0 and level.get_time_hours() < 10 then
      data = "0" .. hours_time .. ":" .. "0" .. minutes_time
   end
   if level.get_time_minutes() >= 10 and level.get_time_minutes() <= 59 and level.get_time_hours() >= 0 and level.get_time_hours() < 10 then
      data = "0" .. hours_time .. ":" .. minutes_time
   end
   return data
end

-- 'Пройденное игровое время, с момента начала игры.
_G.get_general_game_time = function(n_day, n_hour, n_minute, accuracy)
   local time_result = (level.get_time_days() * 60 * 24 + level.get_time_hours() * 60 + level.get_time_minutes()) - 1440
   if n_day ~= nil and n_hour == nil and n_minute == nil then
      time_result = n_day * 60 * 24 + level.get_time_hours() * 60 +
          level.get_time_minutes()
   end
   if n_day ~= nil and n_hour ~= nil and n_minute == nil then
      time_result = n_day * 60 * 24 + n_hour * 60 +
          level.get_time_minutes()
   end
   if n_day == nil and n_hour == nil and n_minute ~= nil then
      time_result = level.get_time_days() * 60 * 24 +
          level.get_time_hours() * 60 + n_minute
   end
   if n_day == nil and n_hour ~= nil and n_minute ~= nil then
      time_result = level.get_time_days() * 60 * 24 + n_hour * 60 +
          n_minute
   end
   if n_day ~= nil and n_hour ~= nil and n_minute ~= nil then time_result = n_day * 60 * 24 + n_hour * 60 + n_minute end
   if accuracy == true then
      return time_result
   else
      return GetUntilGameTime() + time_result
   end
end

-- 'SID обьект есть, и он online.
_G.get_sid_online = function(sid_name)
   return get_story_object_id(sid_name) ~= nil and level.object_by_id(get_story_object_id(sid_name)) ~= nil
end

-- 'Проверка метки на обьекте.
_G.get_spot_on_map = function(obj_id, location_name)
   return level.map_has_object_spot(obj_id, location_name) ~= 0
end

-- 'Проверка наличия предметов с указанной частью секции, в инвентарном обьекте.
_G.get_item_section_f_inventory_box = function(obj_box, target_item)
   local result = false
   local function check_items(temp, item)
      if item ~= nil and find_in_string(item:section(), target_item) then
         result = true
         return true
      end
   end
   obj_box:iterate_inventory_box(check_items, obj_box)
   return result
end

_G.get_item_count = function(need_item, st_find)
   local item_section = need_item
   local has_count = 0
   local function calc(temp, item)
      if (st_find == nil or st_find == false) and item:section() == item_section then
         has_count = has_count + 1
      elseif st_find == true and find_in_string(item:section(), item_section) then
         has_count = has_count + 1
      end
   end
   db.actor:iterate_inventory(calc, db.actor)
   return has_count
end

-- 'Проверка наличия определенного предмета в слоте.
_G.get_actor_slot_item = function(item_name, item_type)
   local pistol_in_slot = db.actor:item_in_slot(2)
   local rifle_in_slot = db.actor:item_in_slot(3)
   local outfit_in_slot = db.actor:item_in_slot(7)
   local helm_in_slot = db.actor:item_in_slot(12)
   if item_name ~= nil and item_type == "pistol" and pistol_in_slot ~= nil and find_in_string(pistol_in_slot:section(), item_name) then
      return true
   elseif item_name ~= nil and item_type == "rifle" and rifle_in_slot ~= nil and find_in_string(rifle_in_slot:section(), item_name) then
      return true
   elseif item_name ~= nil and item_type == "outfit" and outfit_in_slot ~= nil and find_in_string(outfit_in_slot:section(), item_name) then
      return true
   elseif item_name ~= nil and item_type == "helm" and helm_in_slot ~= nil and find_in_string(helm_in_slot:section(), item_name) then
      return true
   else
      return false
   end
end

-- 'Случайное число
_G.get_rnd = function(v1, v2)
   if v1 == nil and v2 == nil then v1, v2 = 1, 2 end
   local rnd_value = math.random(v1, v2)
   return rnd_value
end

-- 'Проверка таблицы на количество {}.
_G.get_table_lines = function(tbl, debug)
   local result = 0
   for k, v in pairs(tbl) do
      result = result + 1
      if debug == true then
         if k ~= nil and v ~= nil then
            debug_to_file("debug.txt", "k=" .. tostring(k) .. "|" .. "v=" .. tostring(v))
         end
      end
   end
   return result
end

-- 'Случайный выбор строки из таблицы.
_G.get_random_string = function(tbl)
   return tbl[math.random(table.getn(tbl))]
end

-- 'Случайный выбор значения из переменной.
_G.get_random_line = function(line)
   line_table = parse_general_names(line)
   return get_random_string(line_table)
end

-- 'Количество значений в таблице.
_G.get_table_names = function(tbl)
   return #tbl
end

-- 'Чтение текста справа от указанного знака.
_G.read_string_removal_r = function(target_str, sign)
   if target_str ~= nil then
      return string.sub(target_str, string.find(target_str, sign) + 1)
   end
   return nil
end

_G.parse_codicil = function(name)
   if find_out_string(name, "silencer") then
      if find_in_string(name, "45x39_") or find_in_string(name, "56x45_") or find_in_string(name, "7x28_") then
         return "ammo_5." .. name
      elseif find_in_string(name, "62x54_") or find_in_string(name, "62x51_") then
         return "ammo_7." .. name
      elseif find_in_string(name, "43x23_") then
         return "ammo_11." .. name
      elseif find_in_string(name, "7x99_") then
         return "ammo_12." .. name
      end
   else
      if find_in_string(name, "45x39") or find_in_string(name, "56x45") then
         return "wpn_addon_silencer_5." .. name
      elseif find_in_string(name, "43x23") then
         return "wpn_addon_silencer_11." .. name
      end
   end
   if find_in_string(name, "7b") then
      return "ammo_og-" .. name
   elseif find_in_string(name, "6") and find_out_string(name, "_") then
      return "wpn_rg-" .. name
   elseif find_in_string(name, "05_lighting") then
      return "grenade_gd-" .. name
   elseif find_in_string(name, "05_double") then
      return "grenade_gd-" .. name
   elseif find_in_string(name, "05") and find_out_string(name, "_") then
      return "grenade_gd-" .. name
   elseif find_in_string(name, "25") and find_out_string(name, "_") then
      return "ammo_vog-" .. name
   end
   return name
end

-- 'Возвращение значений разделённых запятыми.
_G.parse_comma_names = function(val, count, imm_cm)
   local cm_names = parse_accuracy_names(val)
   local cm_all = #cm_names
   if imm_cm == true then
      return cm_names
   end
   if cm_all >= count and val ~= nil then
      if count == 1 then
         return cm_names[1]
      elseif count == 2 then
         return cm_names[1], cm_names[2]
      elseif count == 3 then
         return cm_names[1], cm_names[2], cm_names[3]
      elseif count == 4 then
         return cm_names[1], cm_names[2], cm_names[3], cm_names[4]
      elseif count == 5 then
         return cm_names[1], cm_names[2], cm_names[3], cm_names[4], cm_names[5]
      elseif count == 6 then
         return cm_names[1], cm_names[2], cm_names[3], cm_names[4], cm_names[5], cm_names[6]
      elseif count == 7 then
         return cm_names[1], cm_names[2], cm_names[3], cm_names[4], cm_names[5], cm_names[6], cm_names[7]
      end
   end
   return nil
end

-- 'Парсинг значений разделённых запятыми в таблицу.
_G.parse_general_names = function(s)
   local t = {}
   for name in string.gfind(s, "([%w_\\]+)%p*") do
      local w_name = parse_codicil(name)
      if avail_codicil(name) == true then table.insert(t, w_name) end
   end
   return t
end

_G.parse_accuracy_names = function(s)
   local t = {}
   for name in string.gfind(s, "([%w_%-.\\]+)%,*") do
      table.insert(t, name)
   end
   return t
end

-- 'Подсчет нескольких полученных инфопортаций за один вызов.
_G.has_chosen_info = function(info_list)
   if find_out_string(info_list, ",") then
      return has_alife_info(info_list)
   else
      local info_result = 0
      local info_table = utils.parse_spawns(info_list)
      local info_count = get_table_names(info_table)
      for k, v in pairs(info_table) do
         if has_alife_info(v.section) then
            info_result = info_result + 1
         end
      end
      return info_result >= info_count
   end
end

-- 'Подсчет нескольких неполученных инфопортаций за один вызов.
_G.dont_has_chosen_info = function(info_list)
   if find_out_string(info_list, ",") then
      return dont_has_alife_info(info_list)
   else
      local info_result = 0
      local info_table = utils.parse_spawns(info_list)
      local info_count = get_table_names(info_table)
      for k, v in pairs(info_table) do
         if dont_has_alife_info(v.section) then
            info_result = info_result + 1
         end
      end
      return info_result >= info_count
   end
end

-- 'Проверка на наличие любой из нескольких инфопортаций.
_G.has_any_info = function(info_list)
   if find_out_string(info_list, ",") then
      return has_alife_info(info_list)
   else
      local info_result = false
      local info_table = utils.parse_spawns(info_list)
      local info_count = get_table_names(info_table)
      for k, v in pairs(info_table) do
         if has_alife_info(v.section) then
            info_result = true
         end
      end
      return info_result
   end
end

-- 'Проверка на отсутствие инфопортации.
_G.dont_has_alife_info = function(info_id)
   return not has_alife_info(info_id)
end