------------------------------------------------------------------------------
--                           Выдача чего-либо                               --
------------------------------------------------------------------------------

_G.ammo_section                        = {}
_G.ammo_section["ammo_9x18_fmj"]       = true
_G.ammo_section["ammo_9x18_pmm"]       = true
_G.ammo_section["ammo_9x19_fmj"]       = true
_G.ammo_section["ammo_9x19_pbp"]       = true
_G.ammo_section["ammo_5.45x39_fmj"]    = true
_G.ammo_section["ammo_5.45x39_ap"]     = true
_G.ammo_section["ammo_5.56x45_ss190"]  = true
_G.ammo_section["ammo_5.56x45_ap"]     = true
_G.ammo_section["ammo_5.7x28_fmj"]     = true
_G.ammo_section["ammo_5.7x28_ap"]      = true
_G.ammo_section["ammo_7.62x54_7h1"]    = true
_G.ammo_section["ammo_9x39_pab9"]      = true
_G.ammo_section["ammo_gauss"]          = true
_G.ammo_section["ammo_9x39_ap"]        = true
_G.ammo_section["ammo_11.43x23_fmj"]   = true
_G.ammo_section["ammo_11.43x23_hydro"] = true
_G.ammo_section["ammo_12x70_buck"]     = true
_G.ammo_section["ammo_12x76_zhekan"]   = true
_G.ammo_section["ammo_pkm_100"]        = true
_G.ammo_section["ammo_box_10_vog"]     = true
_G.ammo_section["ammo_box_10_m209"]    = true
_G.ammo_section["ammo_dumdum"]         = true

-- 'Выдача книги по ТВБ.
local table_skill_books_general = { "pkm", "abakan", "ak74", "ak74u", "beretta", "bm16", "colt1911", "desert_eagle",
    "fn2000", "fort", "g36", "groza", "hpsa", "l85", "lr300", "mp5", "pb", "pm", "rg-6", "rpg7", "sig220", "sig550",
    "spas12", "svd", "svu", "toz34", "usp", "val", "vintorez", "walther", "wincheaster1300", "protecta", "knife" }
local table_skill_books_escape = { "abakan", "ak74", "ak74u", "beretta", "bm16", "colt1911", "desert_eagle" }
local table_skill_books_marsh = { "abakan", "ak74", "ak74u", "beretta", "bm16", "colt1911", "desert_eagle" }
local table_skill_books_zaton = { "ak74", "ak74u", "beretta", "bm16", "colt1911", "fort", "hpsa", "lr300", "mp5", "pb",
    "pm", "toz34", "walther", "wincheaster1300", "knife", "abakan", "usp", }
local table_skill_books_jupiter = { "pkm", "desert_eagle", "g36", "groza", "l85", "rg-6", "rpg7", "sig220", "sig550",
    "spas12", "svu", "val", "vintorez", "protecta" }
local table_skill_books_pripyat = { "fn2000", "svd", "val", "vintorez", "protecta" }
local table_skill_books_darkvalley = { "sig550", "spas12", "svu", "val" }
local table_skill_books_military = { "fn2000", "svd" }
local table_skill_books_agroprom = { "rg-6", "rpg7" }
local table_skill_books_red_forest = { "pkm", "g36", "groza" }
-- 'Выдача случайного тайника оригинальной игры.
local treasure_with_zaton = { "zat_hiding_place_1", "zat_hiding_place_2", "zat_hiding_place_3", "zat_hiding_place_4",
    "zat_hiding_place_5", "zat_hiding_place_6", "zat_hiding_place_7", "zat_hiding_place_8", "zat_hiding_place_9",
    "zat_hiding_place_10", "zat_hiding_place_11", "zat_hiding_place_12", "zat_hiding_place_13", "zat_hiding_place_14",
    "zat_hiding_place_15", "zat_hiding_place_16", "zat_hiding_place_17", "zat_hiding_place_18", "zat_hiding_place_19",
    "zat_hiding_place_20", "zat_hiding_place_21", "zat_hiding_place_22", "zat_hiding_place_23", "zat_hiding_place_24",
    "zat_hiding_place_25", "zat_hiding_place_26", "zat_hiding_place_27", "zat_hiding_place_28", "zat_hiding_place_29",
    "zat_hiding_place_30", "zat_hiding_place_31", "zat_hiding_place_32", "zat_hiding_place_33", "zat_hiding_place_34",
    "zat_hiding_place_35", "zat_hiding_place_36", "zat_hiding_place_37", "zat_hiding_place_38", "zat_hiding_place_39",
    "zat_hiding_place_40", "zat_hiding_place_41", "zat_hiding_place_42", "zat_hiding_place_43", "zat_hiding_place_44",
    "zat_hiding_place_45", "zat_hiding_place_46", "zat_hiding_place_47", "zat_hiding_place_48", "zat_hiding_place_49",
    "zat_hiding_place_50", "zat_hiding_place_51", "zat_hiding_place_52", "zat_hiding_place_53", "zat_hiding_place_54",
    "zat_hiding_place_55" }
local treasure_with_jupiter = { "jup_hiding_place_1", "jup_hiding_place_2", "jup_hiding_place_3", "jup_hiding_place_4",
    "jup_hiding_place_5", "jup_hiding_place_6", "jup_hiding_place_7", "jup_hiding_place_8", "jup_hiding_place_9",
    "jup_hiding_place_10", "jup_hiding_place_11", "jup_hiding_place_12", "jup_hiding_place_13", "jup_hiding_place_14",
    "jup_hiding_place_15", "jup_hiding_place_16", "jup_hiding_place_17", "jup_hiding_place_18", "jup_hiding_place_19",
    "jup_hiding_place_20", "jup_hiding_place_21", "jup_hiding_place_22", "jup_hiding_place_23", "jup_hiding_place_24",
    "jup_hiding_place_25", "jup_hiding_place_26", "jup_hiding_place_27", "jup_hiding_place_28", "jup_hiding_place_29",
    "jup_hiding_place_30", "jup_hiding_place_31", "jup_hiding_place_32", "jup_hiding_place_33", "jup_hiding_place_34",
    "jup_hiding_place_35", "jup_hiding_place_36", "jup_hiding_place_37", "jup_hiding_place_38", "jup_hiding_place_39",
    "jup_hiding_place_40", "jup_hiding_place_41", "jup_hiding_place_42", "jup_hiding_place_43", "jup_hiding_place_44",
    "jup_hiding_place_45", "jup_hiding_place_46", "jup_hiding_place_47", "jup_hiding_place_48", "jup_hiding_place_49",
    "jup_hiding_place_50" }
local treasure_with_pripyat = { "pri_hiding_place_1", "pri_hiding_place_2", "pri_hiding_place_3", "pri_hiding_place_4",
    "pri_hiding_place_5", "pri_hiding_place_6", "pri_hiding_place_7", "pri_hiding_place_8", "pri_hiding_place_9",
    "pri_hiding_place_10", "pri_hiding_place_11", "pri_hiding_place_12", "pri_hiding_place_13", "pri_hiding_place_14",
    "pri_hiding_place_15", "pri_hiding_place_16", "pri_hiding_place_17", "pri_hiding_place_18", "pri_hiding_place_19",
    "pri_hiding_place_20", "pri_hiding_place_21", "pri_hiding_place_22", "pri_hiding_place_23", "pri_hiding_place_24",
    "pri_hiding_place_25", "pri_hiding_place_26", "pri_hiding_place_27", "pri_hiding_place_28", "pri_hiding_place_29",
    "pri_hiding_place_30", "pri_hiding_place_31" }
local treasure_with_darkvalley = { "val_hiding_place_1", "val_hiding_place_2", "val_hiding_place_3", "val_hiding_place_4",
    "val_hiding_place_5", "val_hiding_place_6", "val_hiding_place_7", "val_hiding_place_8", "val_hiding_place_9",
    "val_hiding_place_10", "val_hiding_place_11", "val_hiding_place_12", "val_hiding_place_13", "val_hiding_place_14",
    "val_hiding_place_15", "val_hiding_place_16", "val_hiding_place_17", "val_hiding_place_18", "val_hiding_place_19",
    "val_hiding_place_20", "val_hiding_place_21", "val_hiding_place_22", "val_hiding_place_23", "val_hiding_place_24",
    "val_hiding_place_25", "val_hiding_place_26", "val_hiding_place_27", "val_hiding_place_28", "val_hiding_place_29",
    "val_hiding_place_30", "val_hiding_place_31", "val_hiding_place_32", "val_hiding_place_33", "val_hiding_place_34",
    "val_hiding_place_35", "val_hiding_place_36" }
local treasure_with_military = { "mil_hiding_place_1", "mil_hiding_place_2", "mil_hiding_place_3", "mil_hiding_place_4",
    "mil_hiding_place_5", "mil_hiding_place_6", "mil_hiding_place_7", "mil_hiding_place_8", "mil_hiding_place_9",
    "mil_hiding_place_10", "mil_hiding_place_11", "mil_hiding_place_12", "mil_hiding_place_13", "mil_hiding_place_14",
    "mil_hiding_place_15", "mil_hiding_place_16", "mil_hiding_place_17", "mil_hiding_place_18", "mil_hiding_place_19",
    "mil_hiding_place_20", "mil_hiding_place_21", "mil_hiding_place_22", "mil_hiding_place_23", "mil_hiding_place_24",
    "mil_hiding_place_25" }
local treasure_with_agroprom = { "agr_hiding_place_1", "agr_hiding_place_2", "agr_hiding_place_3", "agr_hiding_place_4",
    "agr_hiding_place_5", "agr_hiding_place_6", "agr_hiding_place_7", "agr_hiding_place_8", "agr_hiding_place_9",
    "agr_hiding_place_10", "agr_hiding_place_11", "agr_hiding_place_12", "agr_hiding_place_13", "agr_hiding_place_14",
    "agr_hiding_place_15", "agr_hiding_place_16", "agr_hiding_place_17", "agr_hiding_place_18", "agr_hiding_place_19",
    "agr_hiding_place_20", "agr_hiding_place_21", "agr_hiding_place_22" }
local treasure_with_escape = { "esc_hiding_place_1", "esc_hiding_place_2", "esc_hiding_place_3", "esc_hiding_place_4",
    "esc_hiding_place_5", "esc_hiding_place_6", "esc_hiding_place_7", "esc_hiding_place_8", "esc_hiding_place_9",
    "esc_hiding_place_10", "esc_hiding_place_11", "esc_hiding_place_12", "esc_hiding_place_13", "esc_hiding_place_14",
    "esc_hiding_place_15", "esc_hiding_place_16", "esc_hiding_place_17" }
local treasure_with_marsh = { "mar_hiding_place_1", "mar_hiding_place_2", "mar_hiding_place_3", "mar_hiding_place_4",
    "mar_hiding_place_5", "mar_hiding_place_6", "mar_hiding_place_7", "mar_hiding_place_8", "mar_hiding_place_9",
    "mar_hiding_place_10" }
local treasure_with_red_forest = { "red_hiding_place_1", "red_hiding_place_2", "red_hiding_place_3", "red_hiding_place_4",
    "red_hiding_place_5", "red_hiding_place_6", "red_hiding_place_7", "red_hiding_place_8", "red_hiding_place_9",
    "red_hiding_place_10", "red_hiding_place_11", "red_hiding_place_12", "red_hiding_place_13", "red_hiding_place_14",
    "red_hiding_place_15" }

_G.give_random_treasure = function(need_level, count)
    if count == nil then count = 1 end
    local selected_treasure
    local selected_table
    local level_name = level.name()
    local its_all = true
    for i = 1, count do
        if need_level == nil then
            if level_name == "zaton" then
                selected_treasure = get_random_string(treasure_with_zaton)
                selected_table = treasure_with_zaton
            elseif level_name == "jupiter" then
                selected_treasure = get_random_string(treasure_with_jupiter)
                selected_table = treasure_with_jupiter
            elseif level_name == "pripyat" then
                selected_treasure = get_random_string(treasure_with_pripyat)
                selected_table = treasure_with_pripyat
            elseif level_name == "darkvalley" then
                selected_treasure = get_random_string(treasure_with_darkvalley)
                selected_table = treasure_with_darkvalley
            elseif level_name == "military" then
                selected_treasure = get_random_string(treasure_with_military)
                selected_table = treasure_with_military
            elseif level_name == "agroprom" then
                selected_treasure = get_random_string(treasure_with_agroprom)
                selected_table = treasure_with_agroprom
            elseif level_name == "escape" then
                selected_treasure = get_random_string(treasure_with_escape)
                selected_table = treasure_with_escape
            elseif level_name == "marsh" then
                selected_treasure = get_random_string(treasure_with_marsh)
                selected_table = treasure_with_marsh
            elseif level_name == "red_forest" then
                selected_treasure = get_random_string(treasure_with_red_forest)
                selected_table = treasure_with_red_forest
            else
                return
            end
        else
            if need_level == "zaton" then
                selected_treasure = get_random_string(treasure_with_zaton)
                selected_table = treasure_with_zaton
            elseif need_level == "jupiter" then
                selected_treasure = get_random_string(treasure_with_jupiter)
                selected_table = treasure_with_jupiter
            elseif need_level == "pripyat" then
                selected_treasure = get_random_string(treasure_with_pripyat)
                selected_table = treasure_with_pripyat
            elseif need_level == "darkvalley" then
                selected_treasure = get_random_string(treasure_with_darkvalley)
                selected_table = treasure_with_darkvalley
            elseif need_level == "military" then
                selected_treasure = get_random_string(treasure_with_military)
                selected_table = treasure_with_military
            elseif need_level == "agroprom" then
                selected_treasure = get_random_string(treasure_with_agroprom)
                selected_table = treasure_with_agroprom
            elseif need_level == "escape" then
                selected_treasure = get_random_string(treasure_with_escape)
                selected_table = treasure_with_escape
            elseif need_level == "marsh" then
                selected_treasure = get_random_string(treasure_with_marsh)
                selected_table = treasure_with_marsh
            elseif need_level == "red_forest" then
                selected_treasure = get_random_string(treasure_with_red_forest)
                selected_table = treasure_with_red_forest
            else
                return
            end
        end
        if treasure_manager.get_treasure_manager():check_treasure_given(selected_treasure) ~= true then
            treasure_manager.get_treasure_manager():give_treasure(selected_treasure)
        else
            for k, v in pairs(selected_table) do
                if v ~= nil and treasure_manager.get_treasure_manager():check_treasure_given(v) ~= true then
                    its_all = false
                end
            end
            if its_all == false then
                give_random_treasure(need_level, 1)
            end
        end
    end
end

_G.give_skill_book = function(section, news, is_general)
    local level_name = level.name()
    local selected_skill_book
    local selected_skill_table
    local full_skill_book
    local its_all = true
    its_all = true
    if news == nil then news = true end
    if section ~= nil then
        give_object_to_actor(section, 1, news)
    else
        if has_alife_info("opt_balanced_skill_books") and not is_general then
            if level_name == "zaton" then
                selected_skill_book = get_random_string(table_skill_books_zaton)
                selected_skill_table = table_skill_books_zaton
            elseif level_name == "jupiter" then
                selected_skill_book = get_random_string(table_skill_books_jupiter)
                selected_skill_table = table_skill_books_jupiter
            elseif level_name == "pripyat" then
                selected_skill_book = get_random_string(table_skill_books_pripyat)
                selected_skill_table = table_skill_books_pripyat
            elseif level_name == "darkvalley" then
                selected_skill_book = get_random_string(table_skill_books_darkvalley)
                selected_skill_table = table_skill_books_darkvalley
            elseif level_name == "military" then
                selected_skill_book = get_random_string(table_skill_books_military)
                selected_skill_table = table_skill_books_military
            elseif level_name == "agroprom" then
                selected_skill_book = get_random_string(table_skill_books_agroprom)
                selected_skill_table = table_skill_books_agroprom
            elseif level_name == "escape" then
                selected_skill_book = get_random_string(table_skill_books_escape)
                selected_skill_table = table_skill_books_escape
            elseif level_name == "marsh" then
                selected_skill_book = get_random_string(table_skill_books_marsh)
                selected_skill_table = table_skill_books_marsh
            elseif level_name == "red_forest" then
                selected_skill_book = get_random_string(table_skill_books_red_forest)
                selected_skill_table = table_skill_books_red_forest
            else
                selected_skill_book = get_random_string(table_skill_books_general)
                selected_skill_table = table_skill_books_general
            end
        else
            selected_skill_book = get_random_string(table_skill_books_general)
            selected_skill_table = table_skill_books_general
        end
        full_skill_book = "skill_book_" .. selected_skill_book
        if dont_has_alife_info(full_skill_book) and (not db.actor:object(full_skill_book)) then
            give_object_to_actor(full_skill_book, 1, news)
        else
            for k, v in pairs(selected_skill_table) do
                if v ~= nil and dont_has_alife_info("skill_book_" .. v) and (not db.actor:object("skill_book_" .. v)) then
                    its_all = false
                end
            end
            if is_general and its_all == true then
                return
            end
            if its_all == false then
                give_skill_book()
            elseif its_all == true then
                if has_alife_info("opt_balanced_skill_books") then
                    give_skill_book(nil, nil, true)
                end
            end
        end
    end
end
-- 'Выдача МП-3 бонуса.
_G.give_mp3_bonus = function(num)
    local round = math.random(1, 40)
    local its_all = true
    if num ~= nil then
        ui_mod_elements.add_mp3_bonus("mp3_bonus_" .. num)
    else
        if dont_has_alife_info("mp3_bonus_" .. round) then
            ui_mod_elements.add_mp3_bonus("mp3_bonus_" .. round)
        else
            for k = 1, 40 do
                if dont_has_alife_info("mp3_bonus_" .. k) then
                    its_all = false
                end
            end
            if its_all == false then
                give_mp3_bonus()
            end
        end
    end
end

-- 'Выдача SGM тайника.
_G.give_secret = function(count)
    local issued = 0
    if sgm_flags.table_mod_secrets ~= nil and dont_has_alife_info("sgm_achievements_pathfinder") then
        for k, v in pairs(sgm_flags.table_mod_secrets) do
            if issued < count and v ~= nil and level.object_by_id(v) ~= nil and level.map_has_object_spot(v, sgm_flags.spot_secret_v2) == 0 and sgm_functions.ReadInventoryUseInfo(level.object_by_id(v):section()) ~= "none" and dont_has_alife_info(sgm_functions.ReadInventoryUseInfo(level.object_by_id(v):section())) and level.object_by_id(v):is_inv_box_empty() == false then
                news_manager.send_tip(db.actor, "", 0, "taynik", 6000, nil, "st_entry_mod_secret")
                add_spot_on_map(v, sgm_flags.spot_secret_v2, "st_taynik_name")
                issued = issued + 1
            end
        end
    end
end

_G.give_info = function(info, i2, i3, i4, i5)
    if db.actor ~= nil then
        if find_out_string(info, ",") then
            if dont_has_alife_info(info) then
                db.actor:give_info_portion(info)
            end
            if i2 ~= nil and dont_has_alife_info(i2) then db.actor:give_info_portion(i2) end
            if i3 ~= nil and dont_has_alife_info(i3) then db.actor:give_info_portion(i3) end
            if i4 ~= nil and dont_has_alife_info(i4) then db.actor:give_info_portion(i4) end
            if i5 ~= nil and dont_has_alife_info(i5) then db.actor:give_info_portion(i5) end
        else
            info_table = utils.parse_spawns(info)
            for k, v in pairs(info_table) do
                if dont_has_alife_info(v.section) then
                    db.actor:give_info_portion(v.section)
                end
            end
        end
    end
end

_G.disable_info = function(info, i2, i3, i4, i5)
    if db.actor ~= nil then
        if find_out_string(info, ",") then
            if has_alife_info(info) then
                db.actor:disable_info_portion(info)
            end
            if i2 ~= nil and has_alife_info(i2) then db.actor:disable_info_portion(i2) end
            if i3 ~= nil and has_alife_info(i3) then db.actor:disable_info_portion(i3) end
            if i4 ~= nil and has_alife_info(i4) then db.actor:disable_info_portion(i4) end
            if i5 ~= nil and has_alife_info(i5) then db.actor:disable_info_portion(i5) end
        else
            info_table = utils.parse_spawns(info)
            for k, v in pairs(info_table) do
                if has_alife_info(v.section) then
                    db.actor:disable_info_portion(v.section)
                end
            end
        end
    end
end

-- 'Обновление данных Sigerous Top.
_G.sigerous_top_update = function()
    local filename = "gamedata/textures/ui/ui_pda_menu_anims_16.dds"
    local function sigerous_top_split_minutes(r_time)
        local s_h = r_time / 60
        local s_m = r_time - (math.floor(s_h) * 60)
        if math.floor(s_h) < 10 and math.floor(s_m) < 10 then
            return "0" .. math.floor(s_h) .. ":0" .. math.floor(s_m)
        elseif math.floor(s_h) < 10 and math.floor(s_m) >= 10 then
            return "0" .. math.floor(s_h) .. ":" .. math.floor(s_m)
        elseif math.floor(s_m) < 10 then
            return math.floor(s_h) .. ":0" .. math.floor(s_m)
        end
        return math.floor(s_h) .. ":" .. math.floor(s_m)
    end
    os.remove(filename)
    file_write_param(filename, nil, "[global]")
    file_write_param(filename, "username", sgm_functions.read_variable("sigerous_top_name"))
    file_write_param(filename, "location", sgm_functions.read_variable("sigerous_top_location"))
    file_write_param(filename, "cond", sgm_functions.read_variable("sigerous_top_allowed"))
    file_write_param(filename, "key", get_game_unique_id())
    file_write_param(filename, "game_difficulty", sgm_functions.read_variable("sigerous_top_difficulty"))
    file_write_param(filename, "player_money", db.actor:money())
    file_write_param(filename, "player_rank", math.floor(read_mod_param("actor_rank")))
    file_write_param(filename, "player_headshots", read_mod_param("stat_headshots"))
    file_write_param(filename, "player_done_quests", xr_statistic.actor_statistic.completed_quests)
    file_write_param(filename, "player_done_sgm_quests", read_mod_param("stat_kvestov"))
    file_write_param(filename, "player_hiding_founded", xr_statistic.actor_statistic.founded_secrets)
    file_write_param(filename, "player_secret_founded", read_mod_param("stat_taynikov"))
    file_write_param(filename, "player_killed_stalkers", xr_statistic.actor_statistic.killed_stalkers)
    file_write_param(filename, "player_killed_monsters", xr_statistic.actor_statistic.killed_monsters)
    local get_play = sigerous_top_split_minutes((get_general_game_time() - sgm_functions.read_variable("start_game_timer")))
    file_write_param(filename, "player_time_in_play", get_play)
    file_write_param(filename, "mod_version", get_mod_version())
end
-- 'Удаление глобальных переменных для НПС.
_G.clear_mod_params_for_npc = function(npc_id)
    if npc_id ~= nil then
        clear_obj_mod_param(npc_id, "currert_path", true)
        clear_obj_mod_param(npc_id, "currert_dest", true)
        clear_obj_mod_param(npc_id, "currert_path_wait", true)
        clear_obj_mod_param(npc_id, "shooter_clip_counter", true)
        clear_obj_mod_param(npc_id, "issued_medkit", true)
        clear_obj_mod_param(npc_id, "issued_pistol_weapon", true)
        clear_obj_mod_param(npc_id, "issued_rifle_weapon", true)
    end
end

-- 'Проверка предмета на доступность.
_G.check_death_item = function(item_section)
    local ini = ini_file("misc\\death_items_control.ltx")
    if ini:line_exist("death_items_control", item_section) then
        local checker = to_string(sgm_functions.check_section_condlist(ini, "death_items_control", item_section, "true"))
        if checker == "true" then
            return true
        else
            return false
        end
    end
    return true
end
-- 'Проверка старых локаций.
_G.check_default_location = function()
    local level_name = level.name()
    if level_name == "zaton" or level_name == "jupiter" or level_name == "pripyat" or level_name == "jupiter_underground" or level_name == "labx8" then
        return true
    end
    return false
end

-- 'Переброска всех глобальных переменных в файл.
_G.data_param_save_all = function()
    local counter = 1
    local file = io.open(get_mod_save_data_path("save_data"), "w")
    file:write("[save_data]", "\n")
    data_param_save_write()
    data_param_extend()
    for k, v in pairs(sgm_flags.table_mod_data_all) do
        if k ~= nil and sgm_flags.table_mod_data_all[k] ~= nil then
            for s, m in pairs(sgm_flags.table_mod_data_all[k]) do
                for a, b in pairs(sgm_flags.table_mod_data_all[k][s]) do
                    for c, d in pairs(sgm_flags.table_mod_data_all[k][s][a]) do
                        if get_mod_params_savegame() then
                            local type_d = type(d)
                            local safe_d = d
                            if type_d == "boolean" then
                                if d == true then
                                    safe_d = "true"
                                elseif d == false then
                                    safe_d = "false"
                                end
                            end
                            if (tostring(k) == tostring(get_mod_params_savegame()) and tostring(s) == tostring(get_game_unique_id())) or tostring(k) ~= tostring(get_mod_params_savegame()) then
                                --/if (tostring(k)==tostring(get_mod_params_savegame()) and tostring(s)==tostring(get_game_unique_id())) or (tostring(k)~=tostring(get_mod_params_savegame()) and (data_param_save_is_repeated(tostring(k))==false or (data_param_save_is_repeated(tostring(k))==true and tostring(s)==tostring(get_game_unique_id())))) then
                                file:write("param" .. counter .. "=" .. k .. "|" .. s .. "|" ..
                                    a .. "|" .. c .. "|" .. safe_d .. "|" .. type_d, "\n")
                                counter = counter + 1
                            end
                        end
                    end
                end
            end
        end
    end
    file:close()
end

-- Сохранение глобальных переменных
_G.save_params = function()
    if get_game_unique_id() then
       data_param_save_all()
    end
 end

-- 'Выгрузка всех глобальных переменных из файла в две таблицы.
_G.data_param_load_all = function()
    local file = io.open(get_mod_save_data_path("save_data"), "r")
    for line in file:lines() do
        if tostring(line) ~= "[save_data]" then
            local r_d = sgm_functions.check_section_stick(nil, read_string_removal_r(line, "="))
            if exists(r_d) then
                local p1, p2, p3, p4, p5, p6 = r_d[1], r_d[2], r_d[3], r_d[4], r_d[5], r_d[6]
                if sgm_flags.table_mod_data_all[p1] == nil then
                    sgm_flags.table_mod_data_all[p1] = {}
                end
                if sgm_flags.table_mod_data_all[p1][p2] == nil then
                    sgm_flags.table_mod_data_all[p1][p2] = {}
                end
                if sgm_flags.table_mod_data_all[p1][p2][p3] == nil then
                    sgm_flags.table_mod_data_all[p1][p2][p3] = {}
                end
                if tostring(p6) == "boolean" then
                    if tostring(p5) == "true" then
                        p5 = true
                    elseif tostring(p5) == "false" then
                        p5 = false
                    end
                elseif tostring(p6) == "number" then
                    p5 = tonumber(p5)
                else
                    p5 = tostring(p5)
                end
                sgm_flags.table_mod_data_all[p1][p2][p3][p4] = p5
                data_param_load_currert(p1, p2, p3, p4, p5)
            end
        end
    end
    file:close()
end

-- 'Выгрузка глобальных переменных для актуальной таблицы.
_G.data_param_load_currert = function(p1, p2, p3, p4, p5)
    local type = "actor"
    if tonumber(p3) ~= db.actor:id() then
        type = "object"
    end
    if p1 == get_mod_params_savegame() and p2 == tostring(get_game_unique_id()) then
        if type == "actor" then
            write_mod_param(p4, p5)
        elseif type == "object" then
            write_obj_mod_param(tonumber(p3), p4, p5, true)
            if p4 == "offline_mode" then
                sgm_offline.queue_on_offline(tonumber(p3), p5)
            end
        end
    end
end

-- 'Переброска текущих глобальных переменных в общий список.
_G.data_param_extend = function()
    for k, v in pairs(sgm_flags.table_mod_data_actor) do
        if k ~= nil and v ~= nil then
            local svn = get_mod_params_savegame()
            local un_id = tostring(get_game_unique_id())
            local fid = tostring(db.actor:id())
            local param_n = k
            local param_v = v
            if sgm_flags.table_mod_data_all[svn] == nil then
                sgm_flags.table_mod_data_all[svn] = {}
            end
            if sgm_flags.table_mod_data_all[svn][un_id] == nil then
                sgm_flags.table_mod_data_all[svn][un_id] = {}
            end
            if sgm_flags.table_mod_data_all[svn][un_id][fid] == nil then
                sgm_flags.table_mod_data_all[svn][un_id][fid] = {}
            end
            sgm_flags.table_mod_data_all[svn][un_id][fid][param_n] = param_v
        end
    end
    for k, v in pairs(sgm_flags.table_mod_data_actor_cleaner) do
        if k ~= nil and v == true then
            local svn = get_mod_params_savegame()
            local un_id = tostring(get_game_unique_id())
            local fid = tostring(db.actor:id())
            local param_n = k
            if sgm_flags.table_mod_data_all[svn] == nil then
                sgm_flags.table_mod_data_all[svn] = {}
            end
            if sgm_flags.table_mod_data_all[svn][un_id] == nil then
                sgm_flags.table_mod_data_all[svn][un_id] = {}
            end
            if sgm_flags.table_mod_data_all[svn][un_id][fid] == nil then
                sgm_flags.table_mod_data_all[svn][un_id][fid] = {}
            end
            sgm_flags.table_mod_data_all[svn][un_id][fid][param_n] = nil
        end
    end
    for k, v in pairs(sgm_flags.table_mod_data_object) do
        if k ~= nil and sgm_flags.table_mod_data_object[k] ~= nil then
            for m, n in pairs(sgm_flags.table_mod_data_object[k]) do
                local svn = get_mod_params_savegame()
                local un_id = tostring(get_game_unique_id())
                local fid = tostring(k)
                local param_n = m
                local param_v = n
                if sgm_flags.table_mod_data_all[svn] == nil then
                    sgm_flags.table_mod_data_all[svn] = {}
                end
                if sgm_flags.table_mod_data_all[svn][un_id] == nil then
                    sgm_flags.table_mod_data_all[svn][un_id] = {}
                end
                if sgm_flags.table_mod_data_all[svn][un_id][fid] == nil then
                    sgm_flags.table_mod_data_all[svn][un_id][fid] = {}
                end
                sgm_flags.table_mod_data_all[svn][un_id][fid][param_n] = param_v
            end
        end
    end
    for k, v in pairs(sgm_flags.table_mod_data_object_cleaner) do
        if k ~= nil then
            for m, n in pairs(sgm_flags.table_mod_data_object_cleaner[k]) do
                local svn = get_mod_params_savegame()
                local un_id = tostring(get_game_unique_id())
                local fid = tostring(k)
                local param_n = m
                local param_v = n
                if sgm_flags.table_mod_data_all[svn] == nil then
                    sgm_flags.table_mod_data_all[svn] = {}
                end
                if sgm_flags.table_mod_data_all[svn][un_id] == nil then
                    sgm_flags.table_mod_data_all[svn][un_id] = {}
                end
                if sgm_flags.table_mod_data_all[svn][un_id][fid] == nil then
                    sgm_flags.table_mod_data_all[svn][un_id][fid] = {}
                end
                sgm_flags.table_mod_data_all[svn][un_id][fid][param_n] = nil
            end
        end
    end
    sgm_flags.table_mod_data_actor_cleaner = {}
    sgm_flags.table_mod_data_object_cleaner = {}
end

_G.data_param_delete_game = function(save_n)
    local p_list = {}
    local counter = 1
    local file = io.open(get_mod_save_data_path("save_data"), "r")
    for line in file:lines() do
        if find_out_string(tostring(line), "save_data") then
            p_list["param" .. counter] = tostring(read_string_removal_r(line, "="))
            counter = counter + 1
        end
    end
    file:close()
    local file = io.open(get_mod_save_data_path("save_data"), "w")
    file:write("[save_data]", "\n")
    for k, v in pairs(p_list) do
        if k ~= nil then
            local get_v = data_param_get_save_name(v)
            if find_out_string(get_v, save_n) then
                file:write(k .. "=" .. v, "\n")
            end
        end
    end
    file:close()
end

------------------------------------------------------------------------------
--          Система сохранения глобальных переменных в файл                 --
------------------------------------------------------------------------------
-- 'Проверка на валидность уникального серийного номера игры.
_G.check_game_unique_id = function(value)
    local result = true
    local file = io.open(get_mod_save_data_path("save_data"), "r")
    for line in file:lines() do
        if find_in_string(tostring(line), "|" .. value .. "|0|") then
            result = false
        end
    end
    file:close()
    return result
end

-- 'Генерация уникального серийного номера игры, если его нет, и загрузка глобальных переменных.
_G.data_param_connect = function()
    if not get_game_unique_id() then
        local generate_id = math.random(1, 9999)
        if check_game_unique_id(generate_id) then
            sgm_functions.write_variable("new_game_unique_id", generate_id)
        else
            data_param_connect()
            return
        end
    end
    if sgm_flags.bool_data_loaded == false then
        sgm_flags.bool_data_loaded = true
        if data_param_exist() then
            data_param_load_all()
        end
    end
end
------------------------------------------------------------------------------
--                          Работа со сквадами                              --
------------------------------------------------------------------------------

-- 'Проверка возможности спауна сквада.
_G.squad_outside_of_limiter = function(squad_name, squad_level)
    local get_result = true
    local par_config = {}
    if squad_name == nil or squad_level == nil then return true end
    local config_section = "limiter_" .. squad_level
    local ini = ini_file("misc\\config_squads.ltx")
    if ini:section_exist(config_section) then
        local items_count = ini:line_count(config_section)
        local item_section = ""
        for i = 0, items_count - 1 do
            result, item_section, str = ini:r_line(config_section, i, "", "")
            if item_section ~= "cond" then
                par_config[item_section] = str
            end
        end
        for k, v in pairs(par_config) do
            if k ~= nil then
                local r_cond = to_string(sgm_functions.check_section_condlist(ini, config_section, "cond", "true"))
                local r_param = sgm_functions.check_section_stick(nil, v)
                local r_max_count = tonumber(r_param[1])
                local r_rival = r_param[2]
                if r_cond == "true" then
                    if find_in_string(squad_name, k .. "_sim_squad") and sgm_functions.ReadFaction(squad_name) ~= nil and not sgm_functions.ReadStoryId(squad_name) then
                        if k == sgm_functions.ReadFaction(squad_name) and read_mod_param(sgm_functions.ReadFaction(squad_name) .. "_squad_" .. squad_level .. "_count", true) then
                            local currert_count = tonumber(read_mod_param(
                                sgm_functions.ReadFaction(squad_name) .. "_squad_" .. squad_level .. "_count", true))
                            local max_count = tonumber(r_max_count)
                            if exists(r_rival) then
                                local rival_count = tonumber(read_mod_param(
                                    r_rival .. "_squad_" .. squad_level .. "_count", true))
                                if currert_count >= max_count or currert_count > rival_count then
                                    get_result = false
                                end
                            else
                                if currert_count >= max_count then
                                    get_result = false
                                end
                            end
                        end
                    end
                end
            end
        end
        par_config = {}
    end
    return get_result
end

------------------------------------------------------------------------------
--                       Активация зон и эффектов                           --
------------------------------------------------------------------------------
-- 'Установка cam и ppe эффектов.
_G.setup_effector_chain = function(param, type, unique_id, val_less, val_more, with_invert, effector_duration,
                                   with_repeat,
                                   intensity_control, intensity_timer, critical_threshold, damage_intensity, damage_power,
                                   ppe_folder, cam_folder, sound_folder)
    if param == nil then return end
    if effector_duration == nil or effector_duration == 0 then effector_duration = 4000 end
    if damage_intensity == nil then damage_intensity = 2000 end
    if damage_power == nil then damage_power = 0.50 end
    if with_repeat == nil then with_repeat = false end
    local intensity_factor = 1.0
    if sgm_flags.table_mod_timers["class_ppe_" .. unique_id] == nil then
        sgm_flags.table_mod_timers["class_ppe_" .. unique_id] = 0
    end
    if sgm_flags.table_mod_timers["class_ppe_" .. unique_id] ~= 0 and time_global() >= sgm_flags.table_mod_timers["class_ppe_" .. unique_id] then
        sgm_flags.table_mod_timers["class_ppe_" .. unique_id] = 0
    end
    if (with_invert == false and param < val_less and (val_more == nil or param >= val_more)) or (with_invert == true and param > val_less and (val_more == nil or param <= val_more)) then
        if sgm_flags.table_mod_timers["class_ppe_" .. unique_id] == 0 then
            if type == "cam" then
                level.add_cam_effector(cam_folder, unique_id, with_repeat, "")
            elseif type == "mixed" then
                level.add_pp_effector(ppe_folder, unique_id, with_repeat)
                level.add_cam_effector(cam_folder, unique_id + 1, with_repeat, "")
            else
                level.add_pp_effector(ppe_folder, unique_id, with_repeat)
            end
            if sound_folder ~= nil then
                play_snd_at_actor(sound_folder)
            end
            if with_invert == true then
                intensity_factor = val_less + param
            else
                intensity_factor = val_less - param
            end
            if intensity_control == true then
                level.set_pp_effector_factor(unique_id, intensity_factor)
            end
            if intensity_timer == true then
                sgm_flags.table_mod_timers["class_ppe_" .. unique_id] = time_global() + effector_duration +
                    (effector_duration - (effector_duration * intensity_factor))
            else
                sgm_flags.table_mod_timers["class_ppe_" .. unique_id] = time_global() + effector_duration
            end
        else
            if with_invert == true then
                intensity_factor = val_less + param
            else
                intensity_factor = val_less - param
            end
            if intensity_control == true then
                level.set_pp_effector_factor(unique_id, intensity_factor)
            end
        end
    elseif (with_invert == false and (param > val_less or param < val_more)) or (with_invert == true and (param < val_less or param > val_more)) then
        if sgm_flags.table_mod_timers["class_ppe_" .. unique_id] ~= nil and sgm_flags.table_mod_timers["class_ppe_" .. unique_id] ~= 0 then
            level.remove_pp_effector(unique_id)
            sgm_flags.table_mod_timers["class_ppe_" .. unique_id] = 0
        end
    end
    if critical_threshold ~= nil then
        if sgm_flags.table_mod_timers["effector_chain_shot_" .. unique_id] == nil then
            sgm_flags.table_mod_timers["effector_chain_shot_" .. unique_id] = 0
        end
        if sgm_flags.table_mod_timers["effector_chain_shot_" .. unique_id] ~= 0 and time_global() >= sgm_flags.table_mod_timers["effector_chain_shot_" .. unique_id] then
            sgm_flags.table_mod_timers["effector_chain_shot_" .. unique_id] = 0
        end
        if sgm_flags.table_mod_timers["effector_chain_shot_" .. unique_id] == 0 and ((with_invert == false and param <= critical_threshold) or (with_invert == true and param >= critical_threshold)) then
            sgm_flags.table_mod_timers["effector_chain_shot_" .. unique_id] = time_global() + damage_intensity
            set_hit_damage_to(db.actor, hit.wound, damage_power, 0.0)
        end
    end
end

-- 'Активация ауры бездействия.
_G.setup_inactivity_aura = function(radius, name, weakness_value, effector, x, y, z, lv, gv)
    local aura_factor = read_mod_param("aura_inactivity_factor")
    local actor_pos = db.actor:position()
    local currert_zone = false
    local weakness_result = 1000
    if weakness_value == nil then
        weakness_value = 1000
    end
    if db.actor:object("emulator_brain_waves") then
        weakness_result = weakness_value + 500
    else
        weakness_result = weakness_value
    end
    if x ~= nil and y ~= nil and z ~= nil and lv ~= nil and gv ~= nil then
        currert_zone = actor_pos:distance_to(vector():set(x, y, z), lv, gv) < radius
    elseif x ~= nil and y == nil and z == nil and lv == nil and gv == nil then
        currert_zone = actor_pos:distance_to(x:position()) < radius
    end
    sgm_flags.string_aura_inactivity_name = name
    if currert_zone then
        sgm_flags.bool_aura_inactivity_inc = true
        if sgm_flags.timer_aura_inactivity_inc == 0 and aura_factor ~= nil then
            write_mod_param("aura_inactivity_factor", aura_factor + 1)
            start_flague_timer("timer_aura_inactivity_inc", weakness_result)
        end
        if sgm_flags.timer_aura_inactivity_inc ~= 0 and time_global() >= sgm_flags.timer_aura_inactivity_inc then
            sgm_flags.timer_aura_inactivity_inc = 0
        end
        if (effector ~= nil and effector == true) and sgm_flags.timer_aura_inactivity_cam == 0 and aura_factor >= 10 then
            level.add_cam_effector("camera_effects\\earthquake_2.anm", 7682, false, "")
            start_flague_timer("timer_aura_inactivity_cam", 7000)
        end
        if (effector ~= nil and effector == true) and sgm_flags.timer_aura_inactivity_ppe == 0 then
            level.add_pp_effector("psy_antenna.ppe", 7681, false)
            start_flague_timer("timer_aura_inactivity_ppe", 7000)
        end
    else
        if (effector ~= nil and effector == true) and sgm_flags.timer_aura_inactivity_cam == 0 and aura_factor >= 10 then
            level.add_cam_effector("camera_effects\\earthquake_2.anm", 7682, false, "")
            start_flague_timer("timer_aura_inactivity_cam", 7000)
        end
        if (effector ~= nil and effector == true) then
            level.remove_pp_effector(7681)
            sgm_flags.timer_aura_inactivity_ppe = 0
        end
        sgm_flags.bool_aura_inactivity_inc = false
    end
end

-- 'Установка зоны безопасности в определенном радиусе.
_G.setup_no_weapon_zone = function(radius, name, allow_icon, x, y, z, lv, gv)
    local actor_pos = db.actor:position()
    local currert_zone = false
    if x ~= nil and y ~= nil and z ~= nil and lv ~= nil and gv ~= nil then
        currert_zone = actor_pos:distance_to(vector():set(x, y, z), lv, gv) < radius
    elseif x ~= nil and y == nil and z == nil and lv == nil and gv == nil then
        currert_zone = actor_pos:distance_to(x:position()) < radius
    end
    if currert_zone then
        if allow_icon == true or allow_icon == "true" then
            add_hud("hud_no_weapon_zone", nil, true, true)
        end
        bind_stalker.hide_weapon(name)
    else
        release_hud("hud_no_weapon_zone")
        bind_stalker.restore_weapon(name)
    end
end

-- 'Установка зоны безопасности в определенном радиусе. С возможностью отключения.
_G.setup_no_weapon_zone_disabled = function(radius, name, info, allow_icon, x, y, z, lv, gv)
    local actor_pos = db.actor:position()
    local currert_zone = false
    if x ~= nil and y ~= nil and z ~= nil and lv ~= nil and gv ~= nil then
        currert_zone = actor_pos:distance_to(vector():set(x, y, z), lv, gv) < radius
    elseif x ~= nil and y == nil and z == nil and lv == nil and gv == nil then
        currert_zone = actor_pos:distance_to(x:position()) < radius
    end
    if currert_zone and dont_has_alife_info(info) then
        if allow_icon == true or allow_icon == "true" then
            add_hud("hud_no_weapon_zone", nil, true, true)
        end
        bind_stalker.hide_weapon(name)
    else
        release_hud("hud_no_weapon_zone")
        bind_stalker.restore_weapon(name)
    end
end

-- 'Создание обьекта.
_G.create = function(who, x, y, z, lv, gv, spot_name, spot_descr)
    local who_table = parse_general_names(who)
    if z == nil and lv == nil and gv == nil then
        obj = alife():create(get_random_string(who_table), level.vertex_position(x), x, y)
    else
        obj = alife():create(get_random_string(who_table), vector():set(x, y, z), lv, gv)
    end
    if obj then
        sgm_modules.submodule_on_create(who, obj.id)
        if exists(spot_name) and exists(spot_descr) then
            add_spot_on_map(obj.id, spot_name, spot_descr)
        end
    end
    return obj
end

-- 'Создание бомбы возле обьекта.
_G.activate_detonate_charge = function(target, timer, visible, x, y, z, lv, gv)
    local obj
    if timer == nil then time = 2000 end
    if visible == "visible_big" then
        if x == nil then
            obj = create("detonation_charge_visible_big", target:position().x, target:position().y, target:position().z,
                target:level_vertex_id(), target:game_vertex_id())
        else
            obj = create("detonation_charge_visible_big", x, y, z, lv, gv)
        end
    elseif visible == "invisible_big" then
        obj = create("detonation_charge_invisible_big", target:position().x, target:position().y, target:position().z,
            target:level_vertex_id(), target:game_vertex_id())
    elseif visible == "visible_small" then
        if x == nil then
            obj = create("detonation_charge_visible_small", target:position().x, target:position().y, target:position()
                .z,
                target:level_vertex_id(), target:game_vertex_id())
        else
            obj = create("detonation_charge_visible_small", x, y, z, lv, gv)
        end
    elseif visible == "invisible_small" then
        obj = create("detonation_charge_invisible_small", target:position().x, target:position().y, target:position().z,
            target:level_vertex_id(), target:game_vertex_id())
    end
    write_mod_param("detonation_charge_id", obj.id)
    write_mod_param("detonation_charge_timer", time_global() + timer)
end

-- 'Детонация взрывоопасного объекта по ID.
_G.detonate_explosive_charge = function(charge_id, detonation_charge)
    if charge_id ~= nil and level.object_by_id(charge_id) ~= nil then
        level.object_by_id(charge_id):explode(0)
        if detonation_charge == true then
            clear_mod_param("detonation_charge_id")
            clear_mod_param("detonation_charge_timer")
        end
    end
end

_G.detonate_remote_charge = function(charge_id, charge_seq, is_remote_control)
    if is_remote_control == true then
        if read_mod_param("remote_charge_" .. charge_seq .. "_allow") == false then
            write_mod_param("remote_charge_" .. charge_seq .. "_timer",
                time_global() + read_mod_param("remote_charge_" .. charge_seq .. "_timer"))
            write_mod_param("remote_charge_" .. charge_seq .. "_allow", true)
        end
        return
    end
    if charge_id ~= 0 then
        detonate_explosive_charge(charge_id)
    end
    remove_spot_on_map(read_mod_param("remote_charge_" .. charge_seq .. "_id"), sgm_flags.spot_remote_charge)
    write_mod_param("remote_charge_" .. charge_seq .. "_id", 0)
    write_mod_param("remote_charge_" .. charge_seq .. "_timer", 0)
    write_mod_param("remote_charge_" .. charge_seq .. "_allow", false)
end

-- 'Проверка взрывчатки РС-15.
_G.check_remote_charge = function(charge_num)
    if read_mod_param("remote_charge_" .. charge_num .. "_allow") == true then
        if read_mod_param("remote_charge_" .. charge_num .. "_timer") <= time_global() then
            detonate_remote_charge(read_mod_param("remote_charge_" .. charge_num .. "_id"), charge_num)
        end
    end
    if read_mod_param("remote_charge_" .. charge_num .. "_id") ~= nil and read_mod_param("remote_charge_" .. charge_num .. "_id") ~= 0 then
        if not alife():object(read_mod_param("remote_charge_" .. charge_num .. "_id")) then
            remove_spot_on_map(read_mod_param("remote_charge_" .. charge_num .. "_id"), sgm_flags.spot_remote_charge)
            write_mod_param("remote_charge_" .. charge_num .. "_id", 0)
            write_mod_param("remote_charge_" .. charge_num .. "_timer", 0)
            write_mod_param("remote_charge_" .. charge_num .. "_allow", false)
        end
    end
end

-- 'Замена внешнего вида ГГ, его визуала.
_G.replace_actor_visual = function(if_v, then_v, v_find, v_invert)
    if v_invert == nil or v_invert == false then
        if (v_find == nil or v_find == false) and db.actor:get_visual_name() == if_v then
            db.actor:set_visual_name(then_v)
        elseif v_find == true and find_in_string(db.actor:get_visual_name(), if_v) then
            db.actor:set_visual_name(then_v)
        end
    else
        if (v_find == nil or v_find == false) and db.actor:get_visual_name() == then_v then
            db.actor:set_visual_name(if_v)
        elseif v_find == true and find_in_string(db.actor:get_visual_name(), then_v) then
            db.actor:set_visual_name(if_v)
        end
    end
end

-- 'Закрыть инвентарь/КПК.
_G.game_hide_menu = function(type)
    if type == 1 then
        get_hud():HideActorMenu()
    elseif type == 2 then
        get_hud():HidePdaMenu()
    else
        get_hud():HideActorMenu()
        get_hud():HidePdaMenu()
    end
end

-- 'Лимит сна
_G.check_is_dream_limited = function()
    return read_mod_param("dream_limited") ~= nil and read_mod_param("dream_limited") ~= "none"
end

-- 'Проверка на разрешение затмений.
_G.check_blackday_precond = function()
    local g_ini = ini_file("misc\\config_blackday.ltx")
    local g_settings = "settings"
    local g_condlist = to_string(sgm_functions.check_section_condlist(g_ini, g_settings, "condlist", "false"))
    if g_condlist == "true" then
        return true
    end
    return false
end
-- 'Активация дневного затмения.
_G.blackday_activate = function()
    if level.get_time_hours() >= 7 and level.get_time_hours() <= 21 then
        disable_info("opt_deactivate_blackday")
        write_mod_param("blackday_stage", "step_end")
        start_game_timer("blackday_main_timer", 0)
    end
end


-- 'Стандартный тайм фактор.
_G.DefaultTimeFactor = function()
    local ltx = system_ini()
    if ltx:line_exist("alife", "time_factor") then
        return ltx:r_float("alife", "time_factor")
    else
        return 8
    end
end

-- 'Проверка ночного времени суток.
_G.present_night = function()
    if level.get_time_hours() < 6 or level.get_time_hours() >= 22 then
        return true
    else
        return false
    end
end

-- 'Проверка дневного времени суток.
_G.present_day = function()
    if level.get_time_hours() < 6 or level.get_time_hours() >= 22 then
        return false
    else
        return true
    end
end

_G.start_game_timer = function(name, value, format)
    if format == "d" or format == "days" then
        write_mod_param(name, get_general_game_time() + ((60 * 24) * value))
    elseif format == "h" or format == "hours" then
        write_mod_param(name, get_general_game_time() + (value * 60))
    else
        write_mod_param(name, get_general_game_time() + value)
    end
end

-- 'Проверка таймера в игровом времени.
_G.check_game_timer = function(name, ret_val)
    if ret_val == true then
        if read_mod_param(name) ~= nil then
            return read_mod_param(name)
        end
    end
    if read_mod_param(name) ~= nil and read_mod_param(name) <= get_general_game_time() then
        return true
    elseif read_mod_param(name) == nil then
        return nil
    end
    return false
end

-- 'Очистка таймера в игровом времени.
_G.abort_game_timer = function(name)
    if read_mod_param(name) ~= nil then
        clear_mod_param(name)
    end
end

-- 'Запуск флагового таймера. В реальном времени.
_G.start_flague_timer = function(flag_name, ms_val)
    sgm_flags[flag_name] = time_global() + ms_val
end

-- 'Обнуление флагового таймера.
_G.abort_flague_timer = function(flag_name)
    sgm_flags[flag_name] = 0
end

-- 'Проверка флагового таймера.
_G.check_flague_timer = function(flag_name)
    if sgm_flags[flag_name] ~= nil and sgm_flags[flag_name] ~= 0 and time_global() >= sgm_flags[flag_name] then
        return true
    elseif sgm_flags[flag_name] == nil then
        return nil
    end
    return false
end

-- 'Контроль над флаговым таймером.
_G.run_flague_timer = function(flag_name, type, extra_val)
    if type == 2 then
        if sgm_flags[flag_name] ~= 0 and sgm_flags[flag_name] ~= 1 then
            if time_global() >= sgm_flags[flag_name] then
                sgm_flags[flag_name] = 1
            end
        end
    elseif type == 3 then
        if sgm_flags[flag_name] == 0 then
            if extra_val == nil then extra_val = 1000 end
            sgm_flags[flag_name] = time_global() + extra_val
        end
    else
        if sgm_flags[flag_name] ~= 0 then
            if time_global() >= sgm_flags[flag_name] then
                sgm_flags[flag_name] = 0
            end
        end
    end
end

-- 'Перемотка времени.
_G.refresh_game_time = function(hours, minutes)
    if hours == nil then hours = 0 end
    if minutes == nil then minutes = 0 end
    SendScriptCallback("level_before_change_game_time", hours, minutes)
    level.change_game_time(0, hours, minutes)
    level_weathers.get_weather_manager():forced_weather_change()
    surge_manager.get_surge_manager().time_forwarded = true
end

-- 'Использование пропущенного интервала времени. Для специальных условий.
_G.use_difference_missed_time = function(variable_name)
    if sgm_flags.table_mod_utils["on_forward_game_time_saved"] ~= nil and sgm_flags.table_mod_utils["on_forward_game_time_loaded"] ~= nil then
        sgm_flags.table_mod_utils["forward_game_closed" .. variable_name] = "true"
    end
end

-- 'Проверка секундного таймера с коллбеком.
_G.check_seconds = function(name)
    if name == 1 then
        name = "one"
    elseif name == 2 then
        name = "two"
    elseif name == 3 then
        name = "three"
    elseif name == 4 then
        name = "four"
    elseif name == 5 then
        name = "fifth"
    elseif name == 10 then
        name = "ten"
    elseif name == 20 then
        name = "twenty"
    elseif name == 30 then
        name = "thirty"
    elseif name == 40 then
        name = "fourty"
    elseif name == 50 then
        name = "fifty"
    end
    return sgm_flags["timer_" .. name .. "_seconds"] == 0
end

-- 'Проверка пропущенного интервала времени. Для специальных условий.
_G.check_difference_missed_time = function(need_time_h, need_time_m, variable_name)
    if sgm_flags.table_mod_utils["on_forward_game_time_saved"] ~= nil and sgm_flags.table_mod_utils["on_forward_game_time_loaded"] ~= nil then
        if sgm_flags.table_mod_utils["forward_game_closed" .. variable_name] == nil then
            sgm_flags.table_mod_utils["forward_game_closed" .. variable_name] = "false"
        end
        if sgm_flags.table_mod_utils["forward_game_closed" .. variable_name] == "false" then
            local dif_time = get_general_game_time(nil, need_time_h, need_time_m) >
                sgm_flags.table_mod_utils["on_forward_game_time_saved"] and
                get_general_game_time(nil, need_time_h, need_time_m) <
                sgm_flags.table_mod_utils["on_forward_game_time_loaded"]
            if dif_time then
                return true
            end
        end
    else
        if sgm_flags.table_mod_utils["forward_game_closed" .. variable_name] ~= nil then
            sgm_flags.table_mod_utils["forward_game_closed" .. variable_name] = nil
        end
    end
    return false
end

-- 'Обьект живой.
_G.object_alive = function(victim)
    if victim:alive() == true then
        return true
    end
    return false
end

-- 'Обьект живой.
_G.object_exists = function(obj, is_live)
    return level.present() and obj ~= nil and
        (is_live == false or ((is_live == nil or is_live == true) and obj:alive() == true))
end

-- 'SID обьект является врагом для ГГ.
_G.sid_thinks_that_actor_is_enemy = function(npc_sid)
    local soid = get_story_object_id(npc_sid)
    return soid ~= nil and level.object_by_id(soid) ~= nil and
        check_relation_between(level.object_by_id(soid), db.actor) == "enemy"
end

-- 'Существует ли обьект с SID.
_G.story_id_exists = function(sid_name)
    return get_story_object_id(sid_name) ~= nil
end

-- 'Обьекта с SID нет.
_G.story_id_not_found = function(sid_name)
    return not get_story_object_id(sid_name)
end

-- 'Перевести объект в онлайн.
_G.object_switch_online = function(npc_id)
    local sim = alife()
    if sim == nil then return true end
    sim:set_switch_online(npc_id, true)
    sim:set_switch_offline(npc_id, false)
end

-- 'Перевести объект в оффлайн.
_G.object_switch_offline = function(npc_id)
    local sim = alife()
    if sim == nil then return true end
    sim:set_switch_online(npc_id, false)
    sim:set_switch_offline(npc_id, true)
end

-- 'Автоматическое использование предмета, с выдачей сообщения о причине расходования.
_G.automatic_use = function(item_name, effect_type)
    local effect_descr
    db.actor:eat(db.actor:object(item_name))
    if effect_type == "is_bleeding" then
        effect_descr = game.translate_string("st_automatic_vs_bleeding")
    elseif effect_type == "is_health" then
        effect_descr = game.translate_string("st_automatic_vs_health")
    elseif effect_type == "is_psy_health" then
        effect_descr = game.translate_string("st_automatic_vs_psy_health")
    elseif effect_type == "is_radiation" then
        effect_descr = game.translate_string("st_automatic_vs_radiation")
    end
    news_manager.send_tip(db.actor,
        effect_descr ..
        " " ..
        game.translate_string("st_used_item_descr") .. " " .. game.translate_string(sgm_functions.ReadCaption(item_name)),
        0, "can_resupply", 2000, nil, "st_automatic_use_title", false)
end

-- 'Чтение отношений одного обьекта к другому.
_G.check_relation_between = function(obj1, obj2)
    local relation = "neutral"
    if IsStalker(obj1) then
        if obj1:relation(obj2) == game_object.friend then
            relation = "friend"
        elseif obj1:relation(obj2) == game_object.neutral then
            relation = "neutral"
        elseif obj1:relation(obj2) == game_object.enemy then
            relation = "enemy"
        else
            relation = "enemy"
        end
    elseif IsMonster(obj1) then
        if obj2:relation(obj1) == game_object.friend then
            relation = "friend"
        elseif obj2:relation(obj1) == game_object.neutral then
            relation = "neutral"
        elseif obj2:relation(obj1) == game_object.enemy then
            relation = "enemy"
        else
            relation = "enemy"
        end
    end
    return relation
end

_G.CUI_show_item_icon = function(icon_source, item_section)
    if icon_source ~= nil and item_section ~= nil then
        local rx = read_number(item_section, "inv_grid_x") * 50
        local ry = read_number(item_section, "inv_grid_y") * 50
        local rw = read_number(item_section, "inv_grid_width") * 50
        local rh = read_number(item_section, "inv_grid_height") * 50
        icon_source:Show(true)
        icon_source:InitTexture("ui\\ui_icon_equipment")
        icon_source:SetTextureRect(Frect():set(rx, ry, rx + rw, ry + rh))
    end
end

-- 'Дистанция до обьекта.
_G.distance_to_object = function(obj, type, dist_value, absence_parent)
    local currert_distance = db.actor:position():distance_to(obj:position())
    if ((type == "<=" and currert_distance <= dist_value) or (type == "<" and currert_distance < dist_value) or (type == ">=" and currert_distance >= dist_value) or (type == ">" and currert_distance > dist_value) or (type == "==" and currert_distance < dist_value)) and ((absence_parent == nil) or (absence_parent ~= nil and absence_parent == false and obj:parent() ~= nil) or (absence_parent ~= nil and absence_parent == true and obj:parent() == nil)) then
        return true
    end
    return false
end

-- 'Контрольная зона телепорта.
_G.make_teleport_control_zone = function(nx, ny, nz, nlv, ngv, ndist, tx, ty, tz, dir_h, g_info)
    if sgm_flags.bool_travel_level_change ~= true and db.actor:position():distance_to(vector():set(nx, ny, nz), nlv, ngv) <= ndist then
        db.actor:set_actor_position(vector():set(tx, ty, tz))
        if dir_h ~= nil then db.actor:set_actor_direction(-dir_h) end
        if g_info ~= nil then give_info(g_info) end
    end
end

-- 'ГГ в зоне рестриктора.
_G.actor_in_restrictor = function(zone_name)
    local zone = db.zone_by_name[zone_name]
    return utils.npc_in_zone(db.actor, zone)
end

-- 'Скрыть все обьекты с указанной секцией.
_G.hide_spot_by_section = function(find_string, location_name)
    for a = 1, 65534 do
        local obj = alife():object(a)
        if obj then
            if obj:section_name() ~= nil and string.find(obj:section_name(), find_string) then
                set_spot_choose(obj.id, location_name, "hide")
            end
        end
    end
end

-- 'Скрыть все обьекты с указанным именем.
_G.hide_radius_spot_by_section = function(find_string, location_name, radius_value)
    for a = 1, 65534 do
        local obj = alife():object(a)
        if obj then
            if obj:section_name() ~= nil and string.find(obj:section_name(), find_string) and distance_between_safe(db.actor, level.object_by_id(obj.id)) <= radius_value then
                set_spot_choose(obj.id, location_name, "hide")
            end
        end
    end
end

-- 'Удалить все обьекты с указанной секцией.
_G.release_objects_by_section = function(find_string)
    for a = 1, 65534 do
        local obj = alife():object(a)
        if obj then
            if obj:section_name() ~= nil and string.find(obj:section_name(), find_string) then
                local sect = obj:section_name()
                remove_object_by_id(obj.id)
            end
        end
    end
end

-- 'Удалить все обьекты с указанным именем.
_G.release_objects_by_name = function(find_string)
    for a = 1, 65534 do
        local obj = alife():object(a)
        if obj then
            if obj:name() ~= nil and string.find(obj:name(), find_string) then
                local sect = obj:name()
                remove_object_by_id(obj.id)
            end
        end
    end
end

-- 'Установка метки на обьект.
_G.add_spot_on_map = function(obj_id, location_name, descr)
    if obj_id ~= nil and level.map_has_object_spot(obj_id, location_name) == 0 then
        if descr == nil then descr = "" end
        level.map_add_object_spot_ser(obj_id, location_name, descr)
    end
end

-- 'Удаление метки с обьекта.
_G.remove_spot_on_map = function(obj_id, location_name)
    if obj_id ~= nil and level.map_has_object_spot(obj_id, location_name) ~= 0 then
        level.map_remove_object_spot(obj_id, location_name)
    end
end

-- 'Установка метки на SID.
_G.add_spot_on_map_for_sid = function(sid, location, descr)
    if get_story_object_id(sid) ~= nil then
        add_spot_on_map(get_story_object_id(sid), location, descr)
    end
end

-- 'Выдача квеста.
_G.add_task = function(task_id)
    task_manager.get_task_manager():give_task(task_id)
end


-- 'Чистка предметов в инвентаре ГГ после фриплея.
_G.freeplay_inventory_clean = function(victim)
    local function calc(temp, item)
        if item ~= nil then
            if get_object_story_id(item:id()) == nil and find_out_string(item:section(), "device_torch") and find_out_string(item:section(), "knife") and find_out_string(item:section(), "addon") and find_out_string(item:section(), "binoc") and find_out_string(item:section(), "knife") and find_out_string(item:section(), "_box") and (find_in_string(item:section(), "wpn_") or find_in_string(item:section(), "_outfit") or find_in_string(item:section(), "helm_") or find_in_string(item:section(), "ammo_") or find_in_string(item:section(), "medkit") or find_in_string(item:section(), "psy_complex") or find_in_string(item:section(), "antirad") or find_in_string(item:section(), "bandage")) then
                if alife():object(item:id()) then
                    alife():release(alife():object(item:id()), true)
                end
            end
        end
    end
    victim:iterate_inventory(calc, victim)
end

-- 'Перезагрузка артефактов ГГ. Используется для переброски артефактов из пояса в рюкзак.
_G.transfer_artefacts_with_belt_to_inv = function()
    local function transfers(temp, item)
        if item ~= nil then
            if find_in_string(item:section(), "af_") or find_in_string(item:section(), "cev_plastin") then
                if alife():object(item:id()) then
                    alife():release(alife():object(item:id()), true)
                    give_object_to_actor(item:section())
                end
            end
        end
    end
    db.actor:iterate_inventory(transfers, db.actor)
end

-- 'Проверка по количеству предметов нескольких типов.
_G.check_item_count = function(need_items, type_count, glass)
    local has_count = 0
    local need_count = tonumber(type_count)
    if need_count == nil then need_count = 1 end
    local item_table = utils.parse_spawns(need_items)
    for k, v in pairs(item_table) do
        for i = 1, v.prob do
            local function calc(temp, item)
                if glass == nil or glass == false then
                    if item:section() == v.section then has_count = has_count + 1 end
                else
                    if find_in_string(item:section(), v.section) then has_count = has_count + 1 end
                end
            end
            db.actor:iterate_inventory(calc, db.actor)
        end
    end
    return has_count >= need_count
end

-- 'Удаление предметов из инвентаря.
_G.release_inventory = function(victim, from_what)
    local function get_release_inventory(victim, item)
        local section = item:section()
        if item ~= nil and (from_what == nil or from_what == "all" or (from_what == "weapon" and (find_in_string(section, "wpn_") or find_in_string(section, "grenade"))) or (from_what == "outfit" and (find_in_string(section, "outfit") or find_in_string(section, "helm")))) then
            remove_object_by_id(item:id())
        end
    end
    victim:iterate_inventory(get_release_inventory, victim)
end

-- 'Проверка на занятость слота.
_G.check_slot_filled = function(need_slot)
    local currert_slot = db.actor:item_in_slot(need_slot)
    if currert_slot ~= nil and currert_slot:section() ~= nil then
        return true
    end
    return false
end

-- 'Проверка по количеству предметов одного типа.
_G.have_item_count = function(need_item, num, st_find)
    local item_section = need_item
    local need_count = tonumber(num)
    local has_count = 0
    local function calc(temp, item)
        if (st_find == nil or st_find == false) and item:section() == item_section then
            has_count = has_count + 1
        elseif st_find == true and find_in_string(item:section(), item_section) then
            has_count = has_count + 1
        end
    end
    db.actor:iterate_inventory(calc, db.actor)
    return has_count >= need_count
end

-- 'Проверка на наличие предмета в слоте и при необходимости, на соответствие к compare_section.
_G.check_actor_item_in_slot = function(need_slot, compare_section, need_active)
    local currert_slot = db.actor:item_in_slot(need_slot)
    local active_item = db.actor:active_item()
    if currert_slot ~= nil and currert_slot:section() ~= nil then
        if compare_section ~= nil and compare_section == "self" then
            compare_section = currert_slot:section()
        end
        if compare_section ~= nil and currert_slot:section() == compare_section then
            if need_active ~= true then
                return true
            else
                if active_item and active_item:section() == compare_section then
                    return true
                end
            end
        elseif compare_section == nil then
            return true
        end
    end
    return false
end

-- 'Удаление предмета из инвентаря обьекта.
_G.remove_inv_item = function(victim, item)
    if victim ~= nil and item ~= nil and victim:object(item) and alife():object(victim:object(item):id()) then
        alife():release(alife():object(victim:object(item):id()), true)
    end
end

-- 'Удаление обьекта по его ID.
_G.remove_object_by_id = function(item_id)
    if item_id ~= nil and alife():object(item_id) then
        alife():release(alife():object(item_id), true)
    end
end

-- 'Удалить предмет обьекта, из слота.
_G.remove_item_from_slot = function(victim, slot_number)
    if victim:item_in_slot(tonumber(slot_number)) ~= nil then
        remove_object_by_id(victim:item_in_slot(tonumber(slot_number)):id())
    end
end

-- 'Проверка на отсутствие предмета, и спаун предмета.
_G.check_actor_item_to_add = function(target_item, count)
    if not db.actor:object(target_item) then
        give_object_to_npc(target_item, db.actor, count)
    end
end

-- 'Проверка на наличие, и затем удаление предмета из инвентаря ГГ.
_G.check_actor_item_to_remove = function(target_item)
    if db.actor:object(target_item) then
        remove_inv_item(db.actor, target_item)
    end
end

-- 'Проверка на наличие любого предмета из перечня.
_G.has_any_items = function(items)
    if find_out_string(items, ",") then
        return db.actor:object(items)
    else
        local items_result = false
        local items_table = utils.parse_spawns(items)
        local items_count = get_table_names(items_table)
        for k, v in pairs(items_table) do
            if db.actor:object(v.section) then
                items_result = true
            end
        end
        return items_result
    end
end

-- 'Снятие предмета с рабочего слота.
_G.throw_item_from_slot = function(slot)
    if slot == "pistol" then
        slot = 2
    elseif slot == "rifle" then
        slot = 3
    elseif slot == "outfit" then
        slot = 7
    elseif slot == "helm" then
        slot = 12
    end
    local check_slot = db.actor:item_in_slot(slot)
    if check_slot ~= nil and check_slot:section() ~= nil and alife():object(check_slot:id()) then
        local section = check_slot:section()
        sgm_flags.value_throw_item_cond = check_slot:condition()
        alife():release(alife():object(check_slot:id()), true)
        th_itm = alife():create(section, db.actor:position(), db.actor:level_vertex_id(), db.actor:game_vertex_id(),
            db.actor:id())
        sgm_flags.value_throw_item_id = th_itm.id
    end
end

-- 'Респаун предмета при соблюдении специального условия.
_G.respawn_item_if_comparison = function(need_value_and_item, comparison_value, item_count)
    local check_item = need_value_and_item
    if find_in_string(comparison_value, check_item) then
        check_actor_item_to_add(check_item, item_count)
    end
end

-- 'Отправка сообщения в консоль.
_G.fill_log = function(string_txt)
    get_console():execute(string_txt)
end

-- 'Создание файл с текстом внутри.
_G.debug_to_file = function(filename, text)
    local file = io.open(filename, "a+")
    file:write(tostring(text), "\n")
    file:close(file)
end

-- 'Отладка координат предмета.
_G.debug_rect_item = function(filename, itmname, x, y, w, h)
    local data = "     <texture id=" .. itmname .. " x=" .. x .. " y=" .. y .. " width=" .. w .. " height=" .. h .. "/>"
    local file = io.open(filename, "a+")
    file:write(data, "\n")
    file:close(file)
end

-- 'Работа с файлом.
_G.file_write_param = function(filename, param, value)
    local file = io.open(filename, "a+")
    if param == nil then
        file:write(tostring(value), "\n")
    else
        file:write(tostring(param) .. "=" .. tostring(value), "\n")
    end
    file:close(file)
end

-- 'Возвращение строки
_G.to_string = function(val)
    if val == nil then
        return val
    end
    return tostring(val)
end

-- 'Возвращение цифры
_G.to_number = function(val)
    if val == nil then
        return val
    end
    return tonumber(val)
end

-- 'Проверка на адекватность значения.
_G.exists = function(val)
    return val ~= nil and val ~= "nil"
end

-- 'Присутствие в названии строки.
_G.find_in_string = function(where, what)
    if where ~= nil and what ~= nil and string.find(where, what) then
        return true
    elseif where == nil or what == nil then
        return nil
    end
    return false
end

-- 'Отсутствие в названии строки.
_G.find_out_string = function(where, what)
    if where ~= nil and what ~= nil and string.find(where, what) then
        return false
    elseif where == nil or what == nil then
        return nil
    end
    return true
end

-- 'Сохранение списка секций из .ltx в табличную переменную.
_G.save_and_transform_ini_table = function(ini_path, ini_table, script_path, script_table, need_exist)
    local ini = ini_file(ini_path)
    local list_name_1 = ini_table
    local list_name_2 = script_table
    local n = ini:line_count(list_name_1)
    for i = 0, n - 1 do
        local result, id, value = ini:r_line(list_name_1, i, "", "")
        if (need_exist == nil or need_exist == false) or (need_exist == true and ini:section_exist(id)) then
            if sgm_flags[script_path][list_name_2] == nil then
                sgm_flags[script_path][list_name_2] = {}
            end
            table.insert(sgm_flags[script_path][list_name_2], id)
        end
    end
end

-- 'Воспроизвести звук(возможно зацыкленный) в голове ГГ.
_G.play_folder_snd = function(sound, looped)
    local snd_souce
    if looped == nil then
        snd_souce = sound_object(sound)
        snd_souce:play(db.actor, 0, sound_object.s2d)
    else
        snd_souce = sound_object(sound)
        if snd_souce:playing() == false then
            snd_souce:play(db.actor, 0, sound_object.s2d + sound_object.looped)
        end
    end
end

-- 'Воспроизвести звук от НПС.
_G.play_snd_at_pos = function(npc, sound, count1, count2)
    local snd_souce
    if count1 == nil or count2 == nil then
        snd_souce = sound_object(sound)
        snd_souce:play_at_pos(npc, npc:position(), 0, sound_object.s3d)
    elseif count1 ~= nil and count2 ~= nil then
        local rnd_snd = math.random(count1, count2)
        snd_souce = sound_object(sound .. rnd_snd)
        snd_souce:play_at_pos(npc, npc:position(), 0, sound_object.s3d)
    end
end

-- 'Воспроизвести звук в голове ГГ.
_G.play_snd_at_actor = function(sound, count1, count2)
    local snd_souce
    if count1 == nil or count2 == nil then
        snd_souce = sound_object(sound)
        snd_souce:play(db.actor, 0, sound_object.s2d)
    elseif count1 ~= nil and count2 ~= nil then
        local rnd_snd = math.random(count1, count2)
        snd_souce = sound_object(sound .. rnd_snd)
        snd_souce:play(db.actor, 0, sound_object.s2d)
    end
end

-- 'Воспроизвести звуковую схему.
_G.play_theme_snd = function(npc, snd)
    if npc == nil then npc = db.actor end
    xr_sound.set_sound_play(npc:id(), snd)
end

_G.autosave_precond = function()
    if object_exists(db.actor) and device().precache_frame == 0 and (not db.actor:is_talking()) and dont_has_alife_info("actor_in_sleep") then
        return true
    elseif object_exists(db.actor) and device().precache_frame ~= 0 and (not db.actor:is_talking()) and dont_has_alife_info("actor_in_sleep") then
        return false
    else
        return false
    end
end

-- 'Запись автосохранения.
_G.game_autosave = function(save_name, type)
    if type == nil then type = 1 end
    if type == 1 then
        if autosave_precond() then
            if save_name ~= nil and dont_has_alife_info(save_name) then
                give_info(save_name)
                if IsImportantSave() then
                    local save_param = user_name() .. " - " .. game.translate_string("st_" .. save_name)
                    sgm_flags.string_savegame_type = "autosave"
                    data_param_save_game(save_param)
                    get_console():execute("save " .. save_param)
                end
            end
        else
            if sgm_flags.table_mod_autosaves[save_name] == nil and IsImportantSave() then
                sgm_flags.table_mod_autosaves[save_name] = true
            end
        end
    elseif type == 2 then
        if (autosave_precond() or find_in_string(save_name, "st_save_travel_")) and IsImportantSave() then
            local save_param = user_name() .. " - " .. game.translate_string(save_name)
            sgm_flags.string_savegame_type = "autosave"
            data_param_save_game(save_param)
            get_console():execute("save " .. save_param)
        else
            if sgm_flags.table_mod_autosaves[save_name] == nil and IsImportantSave() then
                sgm_flags.table_mod_autosaves[save_name] = true
            end
        end
    end
end

_G.game_autosave_assign = function(save_name)
    if sgm_flags.table_mod_autosaves[save_name] == nil and IsImportantSave() then
        sgm_flags.table_mod_autosaves[save_name] = true
    end
end

-- 'Вывод информации о заработанном ранге.
_G.congratulate_with_rank_event = function(type, delay, to_value, sound_bool, add_text, check_talking)
    if type == "add" and dont_has_alife_info("opt_disable_statistic_event") then
        sgm_flags.value_rank_counter = sgm_flags.value_rank_counter + to_value
        local descriptor = game.translate_string("st_rank_event_present") ..
            " " .. "(+" .. math.floor(sgm_flags.value_rank_counter) .. ")"
        local end_text = ""
        if add_text ~= nil then
            end_text = add_text
        end
        if math.floor(sgm_flags.value_rank_counter) >= 1.0 then
            descriptor = game.translate_string("st_rank_event_present") ..
                " " .. "(+" .. math.floor(sgm_flags.value_rank_counter) .. ")" .. " " .. end_text
        else
            descriptor = game.translate_string("st_rank_event_present") .. " " .. end_text
        end
        if (check_talking == nil or check_talking == false) or (check_talking == true and (not db.actor:is_talking())) then
            add_hud("hud_message_event", descriptor)
        end
        start_flague_timer("timer_hud_message", delay)
        if sound_bool ~= nil and sound_bool == true then
            play_snd_at_actor([[device\pda\pda_news]])
        end
    elseif type == "clear" and dont_has_alife_info("opt_disable_statistic_event") then
        sgm_flags.timer_hud_message = 0
        release_hud("hud_message_event")
    end
end

-- 'Вывод информации о заработанном хедшоте.
_G.congratulate_with_headshot_event = function(type, delay, to_value, sound_bool, check_talking)
    if type == "add" and dont_has_alife_info("opt_disable_statistic_event") then
        sgm_flags.value_headshot_counter = sgm_flags.value_headshot_counter + to_value
        local descriptor = game.translate_string("st_event_headshot") ..
            " " .. "(+" .. math.floor(sgm_flags.value_headshot_counter) .. ")"
        if (check_talking == nil or check_talking == false) or (check_talking == true and (not db.actor:is_talking())) then
            add_hud("hud_message_event", descriptor)
        end
        start_flague_timer("timer_hud_message", delay)
        if sound_bool ~= nil and sound_bool == true then
            play_snd_at_actor([[device\pda\pda_news]])
        end
    elseif type == "clear" and dont_has_alife_info("opt_disable_statistic_event") then
        sgm_flags.timer_hud_message = 0
        release_hud("hud_message_event")
    end
end

-- 'Вывод информации о найденном SGM тайнике.
_G.congratulate_with_secret_event = function(type, delay, sound_bool, check_talking)
    if type == "add" and dont_has_alife_info("opt_disable_statistic_event") then
        local descriptor = game.translate_string("st_event_iam_find") ..
            " " .. read_mod_param("stat_taynikov") .. game.translate_string("st_event_find_secret")
        if (check_talking == nil or check_talking == false) or (check_talking == true and (not db.actor:is_talking())) then
            add_hud("hud_message_event", descriptor)
        end
        start_flague_timer("timer_hud_message", delay)
        if sound_bool ~= nil and sound_bool == true then
            play_snd_at_actor([[device\pda\pda_news]])
        end
    elseif type == "clear" and dont_has_alife_info("opt_disable_statistic_event") then
        sgm_flags.timer_hud_message = 0
        release_hud("hud_message_event")
    end
end

-- 'Вывод информации о найденном персональном тайнике.
_G.congratulate_with_deserve_event = function(type, delay, sound_bool, check_talking)
    if type == "add" and dont_has_alife_info("opt_disable_statistic_event") then
        local descriptor = game.translate_string("st_event_iam_find") ..
            " " .. read_mod_param("stat_deserves") .. game.translate_string("st_event_find_deserve")
        if (check_talking == nil or check_talking == false) or (check_talking == true and (not db.actor:is_talking())) then
            add_hud("hud_message_event", descriptor)
        end
        start_flague_timer("timer_hud_message", delay)
        if sound_bool ~= nil and sound_bool == true then
            play_snd_at_actor([[device\pda\pda_news]])
        end
    elseif type == "clear" and dont_has_alife_info("opt_disable_statistic_event") then
        sgm_flags.timer_hud_message = 0
        release_hud("hud_message_event")
    end
end

-- 'Вывод длинной строки на HUD.
_G.congratulate_with_event = function(delay, descr, sound_bool, check_talking)
    if dont_has_alife_info("opt_disable_statistic_event") then
        if (check_talking == nil or check_talking == false) or (check_talking == true and (not db.actor:is_talking())) then
            add_hud("hud_message_event_long", descr)
        end
        start_flague_timer("timer_hud_message", delay)
        if sound_bool ~= nil and sound_bool == true then
            play_snd_at_actor([[device\pda\pda_news]])
        end
    end
end

-- 'Запуск динамического окна.
_G.run_dynamic_element = function(folder, close_inv, ui_disable)
    if close_inv == false then
        folder:ShowDialog(true)
    elseif close_inv == true then
        folder:ShowDialog(true)
        game_hide_menu()
        level.show_weapon(false)
    else
        folder:ShowDialog(true)
    end
    if ui_disable == true then
        set_ui_disabled()
    elseif ui_disable == false then
        set_ui_worked()
    end
end

-- 'Запуск окошка, в котором нужно нажимать кнопки Да:Нет:Ок.
_G.run_choose_box = function(type, reason, text, extra_value)
    if object_exists(db.actor) and device().precache_frame == 0 and (not db.actor:is_talking()) then
        ui_mod_elements.information_block_show(type, reason, text, extra_value)
    end
end

-- 'Добавление HUD элемента.
_G.add_hud = function(hud_name, hud_text, hud_precond, hud_clever)
    if (hud_precond == nil or hud_precond == false) or (hud_precond ~= nil and hud_precond == true and precond_hud()) then
        get_hud():AddCustomStatic(hud_name, true)
        if hud_text ~= nil then
            get_hud():GetCustomStatic(hud_name):wnd():TextControl():SetTextST(hud_text)
        end
    elseif hud_precond ~= nil and hud_precond == true and hud_clever ~= nil and hud_clever == true and (not precond_hud()) then
        if get_hud():GetCustomStatic(hud_name) ~= nil then
            get_hud():RemoveCustomStatic(hud_name)
        end
    end
end

-- 'Удаление HUD элемента.
_G.release_hud = function(hud_name)
    if get_hud():GetCustomStatic(hud_name) ~= nil then
        get_hud():RemoveCustomStatic(hud_name)
    end
end

-- 'Условие для использования HUD элементов.
_G.precond_hud = function(type)
    if type == nil or type == 1 then
        return (not db.actor:is_talking()) and object_alive(db.actor) and check_ui_worked(true) and
            dont_has_alife_info("inventory_wnd_opened") and dont_has_alife_info("sleep_active") and
            dont_has_alife_info("actor_in_sleep") and dont_has_alife_info("screenshot_mode")
    elseif type == 2 then
        return object_alive(db.actor) and check_ui_worked(true) and dont_has_alife_info("actor_in_sleep") and
            dont_has_alife_info("sleep_active")
    elseif type == 3 then
        return (not db.actor:is_talking()) and object_alive(db.actor) and check_ui_worked(true) and
            dont_has_alife_info("screenshot_mode") and dont_has_alife_info("inventory_wnd_opened") and
            dont_has_alife_info("actor_in_sleep")
    end
end

-- 'Проверка на присутствие UI.
_G.check_ui_worked = function(check_frame)
    if check_frame == true then
        return sgm_flags.bool_is_ui_disabled == false and device().precache_frame == 0
    else
        return sgm_flags.bool_is_ui_disabled == false
    end
end

-- 'Быстрый вывод на экран информации. Используется для тестов.
_G.give_quick_news = function(text)
    if db.actor ~= nil then
        if text == true then
            news_manager.send_tip(db.actor, "true", 0, "diplomat", 2000, nil, "Быстрое сообщение:")
        elseif text == false then
            news_manager.send_tip(db.actor, "false", 0, "diplomat", 2000, nil, "Быстрое сообщение:")
        elseif text == "true" then
            news_manager.send_tip(db.actor, "true в кавычках", 0, "diplomat", 2000, nil, "Быстрое сообщение:")
        elseif text == "false" then
            news_manager.send_tip(db.actor, "false в кавычках", 0, "diplomat", 2000, nil, "Быстрое сообщение:")
        elseif text == nil then
            news_manager.send_tip(db.actor, "nil", 0, "diplomat", 2000, nil, "Быстрое сообщение:")
        elseif text == "nil" then
            news_manager.send_tip(db.actor, "nil в кавычках", 0, "diplomat", 2000, nil, "Быстрое сообщение:")
        else
            news_manager.send_tip(db.actor, text, 0, "diplomat", 2000, nil, "Быстрое сообщение:")
        end
    end
end

_G.show_hud_message = function(text)
    if db.actor ~= nil then
        if text == true then
            add_hud("hud_event", "true")
        elseif text == "true" then
            add_hud("hud_event", "true в кавычках")
        elseif text == false then
            add_hud("hud_event", "false")
        elseif text == "false" then
            add_hud("hud_event", "false в кавычках")
        elseif text == nil then
            add_hud("hud_event", "nil")
        elseif text == "nil" then
            add_hud("hud_event", "nil в кавычках")
        else
            add_hud("hud_event", text)
        end
    end
end

-- 'Пропуск функции parse_general_names через фильтр, потому как эта функция считывает точку как запятую.
_G.avail_codicil = function(name)
    if (find_in_string(name, "ammo_5") or find_in_string(name, "ammo_7") or find_in_string(name, "ammo_11") or find_in_string(name, "ammo_12") or find_in_string(name, "grenade_gd") or find_in_string(name, "ammo_og") or find_in_string(name, "ammo_vog") or (find_in_string(name, "wpn_rg") and find_out_string(name, "rgd"))) and find_out_string(name, "12x7") then
        return false
    end
    return true
end

-- 'Удаление нескольких инфопортаций по возрастающим номерам.
_G.disable_several_info = function(l_part, r_part, count_a, count_b)
    if count_b == nil then
        count_b = count_a
        count_a = 1
    end
    for i = count_a, count_b do
        disable_info(l_part .. i .. r_part)
    end
end

-- 'Подсчет нескольких полученных инфопортаций по возрастающим номерам.
_G.has_several_info = function(l_part, r_part, count_a, count_b)
    if count_b == nil then
        count_b = count_a
        count_a = 1
    end
    local info_cnt = 0
    for i = count_a, count_b do
        if has_alife_info(l_part .. i .. r_part) then
            info_cnt = info_cnt + 1
        end
    end
    return info_cnt >= count_b
end

-- 'Использовать режим бессмертия.
_G.use_immortal_mode = function(val_first, val_second)
    if db.actor.health < val_first then
        db.actor.health = val_second
    end
end

-- 'Использовать режим восстановления энергии.
_G.use_power_mode = function(val_first, val_second)
    if db.actor.power < val_first then
        db.actor.power = val_second
    end
end

-- 'Создание контейнера со случайными боеприпасами.
local ammo_container_config = {
    var_1 = "ammo_9x18_pmm, 3",
    var_2 = "ammo_9x19_pbp, 3",
    var_3 = "ammo_11.43x23_hydro, 5",
    var_4 = "ammo_12x70_buck, 2, ammo_12x76_zhekan, 2",
    var_5 = "ammo_5.45x39_fmj, 2, ammo_5.45x39_ap",
    var_6 = "ammo_9x39_ap, 3",
    var_7 = "ammo_5.56x45_ss190, 2, ammo_5.56x45_ap",
    var_8 = "ammo_7.62x54_7h1, 2",
    var_9 = "grenade_f1, 2, grenade_rgd5, 2, grenade_gd-05, grenade_gd-05_lighting"
}

_G.give_ammo_with_container = function(news)
    local var_selected = math.random(1, 9)
    local var_source = "var_" .. var_selected
    if ammo_container_config[var_source] ~= nil then
        local get_contain = ammo_container_config[var_source]
        if news ~= nil and news == true then
            give_objects_to_actor(get_contain, true)
        else
            give_objects_to_actor(get_contain, false)
        end
    end
end

-- 'Создание отряда(сквада).
_G.create_force = function(squad_sect, x, y, z, lv, gv)
    local squads_list = utils.parse_spawns(squad_sect)
    for k, v in pairs(squads_list) do
        for i = 1, v.prob do
            if y ~= nil then
                local board = sim_board.get_sim_board()
                local squad = board:create_force(v.section, x, y, z, lv, gv)
                for k in squad:squad_members() do
                    board:setup_squad_and_group(k.object)
                end
                squad:update()
            else
                local board = sim_board.get_sim_board()
                local smart = board.smarts_by_names[x]
                local squad = board:create_squad(smart, v.section)
                board:enter_smart(squad, smart.id)
                for k in squad:squad_members() do
                    board:setup_squad_and_group(k.object)
                end
                squad:update()
            end
        end
    end
end

-- 'Создание предмета в рюкзаке ГГ.
_G.give_object_to_actor = function(section, count, news)
    if count == nil then count = 1 end
    for i = 1, count do
        alife():create(section, db.actor:position(), db.actor:level_vertex_id(), db.actor:game_vertex_id(), db.actor:id())
    end
    if news == true then
        news_manager.relocate_item(db.actor, "in", section, count)
    end
end

-- 'Создание предметов в рюкзаке ГГ.
_G.give_objects_to_actor = function(items_list, news)
    local parse_items_list = utils.parse_spawns(items_list)
    for k, v in pairs(parse_items_list) do
        for i = 1, v.prob do
            alife():create(v.section, db.actor:position(), db.actor:level_vertex_id(), db.actor:game_vertex_id(),
                db.actor:id())
            if news == true then news_manager.relocate_item(db.actor, "in", v.section) end
        end
    end
end

-- 'Создание предмета в рюкзаке НПС.
_G.give_object_to_npc = function(section, npc, count)
    if count == nil then count = 1 end
    for i = 1, count do
        alife():create(section, npc:position(), npc:level_vertex_id(), npc:game_vertex_id(), npc:id())
    end
end

-- 'Создание предметов, для обьекта с выбранным SID.
_G.give_item_to_sid = function(items, sid)
    local parse_items = utils.parse_spawns(items)
    if get_story_object_id(sid) ~= nil then
        for k, v in pairs(parse_items) do
            for i = 1, v.prob do
                alife():create(v.section, vector(), 0, 0, get_story_object_id(sid))
            end
        end
    end
end

-- 'Создание предмета в рюкзаке ГГ. Наградная функция.
_G.give_reward = function(items, count)
    local items_table = parse_general_names(items)
    local choose_item = get_random_string(items_table)
    if count == nil then count = 1 end
    for i = 1, count do
        alife():create(choose_item, db.actor:position(), db.actor:level_vertex_id(), db.actor:game_vertex_id(),
            db.actor:id())
    end
    news_manager.relocate_item(db.actor, "in", choose_item, count)
end

-- 'Создание инвентарного обьекта, с заполнением.
_G.create_inventory_item = function(items_tbl, model, x, y, z, lv, gv, extra_fill)
    local secret_case = db.actor
    local set_model
    if model == 1 then
        set_model = "secret_rukzak"
    elseif model == 2 then
        set_model = "secret_instrument"
    elseif model == 3 then
        set_model = "secret_dinamit"
    else
        set_model = model
    end
    if z == nil and lv == nil and gv == nil then
        secret_case = alife():create(set_model, level.vertex_position(x), x, y)
    else
        secret_case = alife():create(set_model, vector():set(x, y, z), lv, gv)
    end
    if exists(items_tbl) then
        local parse_first_table = utils.parse_spawns(items_tbl)
        for k, v in pairs(parse_first_table) do
            for i = 1, v.prob do
                alife():create(v.section, vector(), 0, 0, secret_case.id)
            end
        end
    end
    if extra_fill ~= nil and extra_fill == true then
        sgm_place.flip_secret_items(secret_case.id)
    end
    return secret_case.id
end

-- 'Создание мертвого НПС, с выбранными вещами.
_G.create_dead_body = function(dead_name, item_table, x, y, z, lv, gv)
    if z == nil and lv == nil and gv == nil then
        body_case = alife():create(dead_name, level.vertex_position(x), x, y)
    else
        body_case = alife():create(dead_name, vector():set(x, y, z), lv, gv)
    end
    if exists(item_table) then
        local parse_table = utils.parse_spawns(item_table)
        for k, v in pairs(parse_table) do
            for i = 1, v.prob do
                alife():create(v.section, vector(), 0, 0, body_case.id)
            end
        end
    end
end

-- 'Создание инвентаря с ценным хабаром. Сокровища группировки.
_G.create_base_treasure = function(model, x, y, z, lv, gv)
    local param_sid = sgm_functions.ReadStoryId(model)
    local param_ts = sgm_functions.ReadBaseTreasureSpot(model)
    local param_sc = sgm_functions.ReadSelfCommunity(model)
    local param_nc = sgm_functions.ReadNeedCommunity(model)
    local param_bi = sgm_functions.ReadBaseItems(model)
    local param_ii = sgm_functions.ReadTakeItemsInfo(model)
    local parse_table = utils.parse_spawns(param_bi)
    if z == nil and lv == nil and gv == nil then
        base_treasure = alife():create(model, level.vertex_position(x), x, y)
    else
        base_treasure = alife():create(model, vector():set(x, y, z), lv, gv)
    end
    add_story_object(base_treasure.id, param_sid)
    if exists(param_ts) then
        add_spot_on_map(base_treasure.id, param_ts,
            game.translate_string("st_base_treasure_name") .. " " .. game.translate_string(param_sc))
    end
    for k, v in pairs(parse_table) do
        for i = 1, v.prob do
            alife():create(v.section, vector(), 0, 0, base_treasure.id)
        end
    end
end

-- 'Создание GPS проводника.
_G.create_gps_guide = function(x, y, z, lv, gv)
    local gps_guide = db.actor
    if z == nil and lv == nil and gv == nil then
        gps_guide = alife():create("guidebook_mono", level.vertex_position(x), x, y)
    else
        gps_guide = alife():create("guidebook_mono", vector():set(x, y, z), lv, gv)
    end
    return gps_guide.id
end

-- 'Замена исчезнувшего квестового трупа на рюкзак с нужным предметом.
_G.replace_quest_corpse = function(spot_name, quest_item, x, y, z, lv, gv)
    create(spot_name, x, y, z, lv, gv)
    create_inventory_item(quest_item, "default_rukzak", x, y, z, lv, gv)
end

-- 'Создание нескольких объектов.
_G.create_objects = function(who_list, x, y, z, lv, gv, spot_name, spot_descr)
    local parse_who_list = utils.parse_spawns(who_list)
    for k, v in pairs(parse_who_list) do
        for i = 1, v.prob do
            obj = alife():create(v.section, vector():set(x, y, z), lv, gv)
            if exists(spot_name) and exists(spot_descr) then
                add_spot_on_map(obj.id, spot_name, spot_descr)
            end
        end
    end
end

-- 'Создание обьекта с рандомной позицией.
_G.create_random = function(who, count_pos, pos_1, pos_2, pos_3, pos_4, pos_5, pos_6, pos_7, pos_8, pos_9, pos_10)
    local who_table = parse_general_names(who)
    local selected_pos = get_rnd(1, count_pos)
    local pos_value = pos_1
    if selected_pos == 1 then
        pos_value = pos_1
    elseif selected_pos == 2 then
        pos_value = pos_2
    elseif selected_pos == 3 then
        pos_value = pos_3
    elseif selected_pos == 4 then
        pos_value = pos_4
    elseif selected_pos == 5 then
        pos_value = pos_5
    elseif selected_pos == 6 then
        pos_value = pos_6
    elseif selected_pos == 7 then
        pos_value = pos_7
    elseif selected_pos == 8 then
        pos_value = pos_8
    elseif selected_pos == 9 then
        pos_value = pos_9
    elseif selected_pos == 10 then
        pos_value = pos_10
    end
    local get_coord = parse_comma_names(pos_value, count_pos, true)
    obj = alife():create(get_random_string(who_table),
        vector():set(tonumber(get_coord[1]), tonumber(get_coord[2]), tonumber(get_coord[3])), tonumber(get_coord[4]),
        tonumber(get_coord[5]))
    if obj then
        sgm_modules.submodule_on_create(who, obj.id)
    end
    return obj
end

local system = require("gamedata.scripts.sgm.system")

_G.SGM_init = function()
    if sgm_flags.bool_mod_update == nil or sgm_flags.bool_mod_update == true then
        system:update()
    end
end

_G.SGM_save = function(packet)
    system:save(packet)
end
_G.SGM_load = function(reader)
    system:load(reader)
end

callbacks = require('gamedata.scripts.sgm.callbacks')

-- todo сделать функцию возвращающий метатаблицу которая при вызове регистрирует объявленные коллбеки
RegisterScriptCallback("actor_update", SGM_init)
RegisterScriptCallback("surge_after_save", SGM_save)
RegisterScriptCallback("surge_after_load", SGM_load)

RegisterScriptCallback("new_game_load", callbacks.on_new_game_load)

RegisterScriptCallback("actor_start_anabiotic", set_ui_disable)
RegisterScriptCallback("actor_start_save", save_params)
RegisterScriptCallback("actor_net_spawn", callbacks.on_game_load)
RegisterScriptCallback("actor_sleep", callbacks.on_actor_sleep)
RegisterScriptCallback("actor_use_inventory_item", callbacks.on_use_deserve)
RegisterScriptCallback("actor_use_inventory_item", callbacks.on_use_skill_book)
RegisterScriptCallback("actor_use_inventory_item", callbacks.on_use_sleeping_bag)
RegisterScriptCallback("actor_use", callbacks.on_first_use_box)
RegisterScriptCallback("actor_use", callbacks.on_search_secret)
RegisterScriptCallback("actor_use", callbacks.on_search_deserve)
RegisterScriptCallback("actor_take_item_from_box", callbacks.on_take_item_from_box)
RegisterScriptCallback("actor_item_take", callbacks.on_item_take)
RegisterScriptCallback("actor_use_inventory_item", callbacks.on_use_item)
RegisterScriptCallback("actor_info", callbacks.on_enterring_info)
RegisterScriptCallback("actor_trade", callbacks.on_trade)
RegisterScriptCallback("actor_item_drop", callbacks.on_item_drop)
RegisterScriptCallback("actor_use", callbacks.on_use_box)
RegisterScriptCallback("actor_use_corpse", callbacks.on_use_corpse)

RegisterScriptCallback("black_day_began", callbacks.on_black_day_began)
RegisterScriptCallback("black_day_end", callbacks.on_black_day_end)

RegisterScriptCallback("combat_check_enemy", callbacks.on_check_npc_enemy)

RegisterScriptCallback("update_inventory_box", callbacks.on_update_inventory_box)

RegisterScriptCallback("squad_create", callbacks.on_squad_create)
RegisterScriptCallback("squad_respawn", callbacks.on_squad_respawn)
RegisterScriptCallback("after_remove_death_squad", callbacks.on_squad_death)

RegisterScriptCallback("level_before_change_game_time", callbacks.on_forward_game_time)

RegisterScriptCallback("give_task", callbacks.on_give_task)
RegisterScriptCallback("run_tutorial", callbacks.on_run_tutorial)

RegisterScriptCallback("monster_hit", callbacks.on_stalker_hit)

RegisterScriptCallback("stalker_hit", callbacks.on_stalker_hit)
RegisterScriptCallback("start_stalker_death", callbacks.on_stalker_death)

RegisterScriptCallback("slot_2", callbacks.on_slot_2)
RegisterScriptCallback("slot_3", callbacks.on_slot_3)
RegisterScriptCallback("slot_7", callbacks.on_slot_7)
RegisterScriptCallback("slot_12", callbacks.on_slot_12)

RegisterScriptCallback("monster_death", callbacks.on_monster_death)

RegisterScriptCallback("weapon_shoot", callbacks.on_weapon_shot)