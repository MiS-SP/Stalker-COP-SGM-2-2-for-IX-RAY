---==================================================================================================---
--------------------------------------------------------------------------------------------------------
----------------------------------------(Динамические окна)---------------------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---

------------------------------------------------------------------------------
--                            Воспроизводитель эффектов                     --
------------------------------------------------------------------------------
local effect_player_section = 1
local ppe_table = {
   "acidic.ppe",
   "acidic_mine.ppe",
   "alcohol.ppe",
   "black.ppe",
   "blink.ppe",
   "brighten.ppe",
   "contrast.ppe",
   "controller_hit.ppe",
   "deimos1.ppe",
   "deimos.ppe",
   "electra.ppe",
   "electra_mine.ppe",
   "fade_in.ppe",
   "fade_in_out.ppe",
   "fade_to_black_9_sec.ppe",
   "fire_hit.ppe",
   "flame.ppe",
   "fuzz.ppe",
   "gravi.ppe",
   "gravi_mine.ppe",
   "mosquito_bald.ppe",
   "nightvision_1.ppe",
   "nightvision_2.ppe",
   "nightvision_3.ppe",
   "pas_b400_acidic.ppe",
   "poltergeist_scan.ppe",
   "psi.ppe",
   "psy_antenna.ppe",
   "psychic.ppe",
   "radiation.ppe",
   "sleep_fade.ppe",
   "snd_shock.ppe",
   "steam_mine.ppe",
   "surge_fade.ppe",
   "surge_shock.ppe",
   "surge_shock_old.ppe",
   "teleport.ppe",
   "thermal.ppe",
   "thermal_mine.ppe"
}
local cam_table = {
   "camera_effects\\dream.anm",
   "camera_effects\\drunk.anm",
   "camera_effects\\earthquake.anm",
   "camera_effects\\earthquake_00.anm",
   "camera_effects\\earthquake_1.anm",
   "camera_effects\\earthquake_2.anm",
   "camera_effects\\empty.anm",
   "camera_effects\\fatigue.anm",
   "camera_effects\\fireball.anm",
   "camera_effects\\fusker.anm",
   "camera_effects\\head_shot.anm",
   "camera_effects\\hit_back.anm",
   "camera_effects\\hit_back_left.anm",
   "camera_effects\\hit_back_right.anm",
   "camera_effects\\hit_front.anm",
   "camera_effects\\hit_front_left.anm",
   "camera_effects\\hit_front_right.anm",
   "camera_effects\\hit_left.anm",
   "camera_effects\\hit_right.anm",
   "camera_effects\\pripyat_horror1.anm",
   "camera_effects\\pripyat_horror.anm",
   "camera_effects\\shell_shock.anm",
   "camera_effects\\sleep.anm",
   "camera_effects\\surge_01.anm",
   "camera_effects\\surge_02.anm",
   "camera_effects\\actor_move\\down.anm",
   "camera_effects\\actor_move\\go_back.anm",
   "camera_effects\\actor_move\\go_front.anm",
   "camera_effects\\actor_move\\jump.anm",
   "camera_effects\\actor_move\\strafe_left.anm",
   "camera_effects\\actor_move\\strafe_right.anm"
}
class "effect_object" (CUIListBoxItem)
function effect_object:__init(height)
   super(height)
   self.text = self:GetTextItem()
   self:SetTextColor(GetARGB(255, 210, 210, 210))
   self.text:SetFont(GetFontLetterica18Russian())
   self.text:SetWndSize(vector2():set(278, height))
   self.text:SetEllipsis(true)
end

class "effect_player" (CUIScriptWnd)
function effect_player:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
   self:FillList(ppe_table)
end

function effect_player:__finalize()
end

function effect_player:FillList(tbl)
   self.effectors_list:Clear()
   for i = 1, #tbl do
      self:AddItemToList(tbl[i])
   end
end

function effect_player:AddItemToList(item_name)
   local _itm = effect_object(22)
   _itm.text:SetText(item_name)
   self.effectors_list:AddExistingItem(_itm)
end

function effect_player:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.effect_player_form = xml:InitStatic("effect_player_form", self)
   self:Register(xml:Init3tButton("effect_player_form:btn_ppe_effectors", self.effect_player_form), "btn_ppe_effectors")
   self:Register(xml:Init3tButton("effect_player_form:btn_cam_effectors", self.effect_player_form), "btn_cam_effectors")
   self:Register(xml:Init3tButton("effect_player_form:btn_play", self.effect_player_form), "btn_play")
   self:Register(xml:Init3tButton("effect_player_form:btn_close", self.effect_player_form), "btn_close")
   self:Register(xml:Init3tButton("effect_player_form:btn_stop", self.effect_player_form), "btn_stop")
   self.effectors_list = xml:InitListBox("effect_player_form:effectors_list", self)
   self.effectors_list:ShowSelectedItem(true)
   self:Register(self.effectors_list, "effectors_list_window")
end

function effect_player:InitCallBacks()
   self:AddCallback("btn_ppe_effectors", ui_events.BUTTON_CLICKED, self.btn_ppe_effectors, self)
   self:AddCallback("btn_cam_effectors", ui_events.BUTTON_CLICKED, self.btn_cam_effectors, self)
   self:AddCallback("btn_play", ui_events.BUTTON_CLICKED, self.btn_play, self)
   self:AddCallback("btn_stop", ui_events.BUTTON_CLICKED, self.btn_stop, self)
   self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
   self:AddCallback("effectors_list_window", ui_events.WINDOW_LBUTTON_DB_CLICK, self.btn_play, self)
end

function effect_player:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   end
end

function effect_player:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_close()
      end
   end
   return true
end

function effect_player:btn_ppe_effectors()
   self:FillList(ppe_table)
   effect_player_section = 1
end

function effect_player:btn_cam_effectors()
   self:FillList(cam_table)
   effect_player_section = 2
end

function effect_player:btn_play()
   if self.effectors_list:GetSize() == 0 then
      return
   end
   local item = self.effectors_list:GetSelectedItem()
   if not item then return end
   local itmname = item.text:GetText()
   if effect_player_section == 1 then
      level.add_pp_effector(itmname, 9991, false)
   elseif effect_player_section == 2 then
      level.add_cam_effector(itmname, 9992, false, "")
   end
end

function effect_player:btn_stop()
   level.remove_pp_effector(9991)
   level.remove_cam_effector(9992)
end

function effect_player:btn_close()
   self:HideDialog()
end

------------------------------------------------------------------------------
--                         Редактор точек путей                             --
------------------------------------------------------------------------------
waypoint_name = ""
waypoint_name_saved = ""
waypoint_def_name = "auto"
waypoint_points_counter = -1
waypoint_autochange_add = "look"
waypoint_assembly, waypoint_data = "", ""
waypoint_line_main, waypoint_line_attacher = "", ""
waypoint_line_1, waypoint_line_2, waypoint_line_3 = "", "", ""
waypoint_line_4, waypoint_line_5, waypoint_line_6 = "", "", ""
class "waypoint_editor" (CUIScriptWnd)
function waypoint_editor:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function waypoint_editor:__finalize()
end

function waypoint_editor:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.waypoint_editor_form = xml:InitStatic("waypoint_editor_form", self)
   self:Register(xml:Init3tButton("waypoint_editor_form:btn_print_waypoint", self.waypoint_editor_form),
      "btn_print_waypoint")
   self:Register(xml:Init3tButton("waypoint_editor_form:btn_mark_point", self.waypoint_editor_form), "btn_mark_point")
   self:Register(xml:Init3tButton("waypoint_editor_form:btn_close", self.waypoint_editor_form), "btn_close")
   self.check_way_closed = xml:InitCheck("waypoint_editor_form:check_way_closed", self.waypoint_editor_form)
   self.check_way_closed:SetCheck(sgm_functions.info_get_boolean("waypoint_editor_check_way_closed", true))
   self.check_empty_flags = xml:InitCheck("waypoint_editor_form:check_empty_flags", self.waypoint_editor_form)
   self.check_empty_flags:SetCheck(sgm_functions.info_get_boolean("waypoint_editor_check_empty_flags"))
   self.check_autochange = xml:InitCheck("waypoint_editor_form:check_autochange", self.waypoint_editor_form)
   self.check_autochange:SetCheck(sgm_functions.info_get_boolean("waypoint_editor_check_autochange"))
   self.waypoint_info = xml:InitStatic("waypoint_editor_form:waypoint_info", self.waypoint_editor_form)
   self.waypoint_name_field = xml:InitEditBox("waypoint_editor_form:waypoint_name_field", self.waypoint_editor_form)
   self.point_animation_field = xml:InitEditBox("waypoint_editor_form:point_animation_field", self.waypoint_editor_form)
   self.point_signal_field = xml:InitEditBox("waypoint_editor_form:point_signal_field", self.waypoint_editor_form)
   self:Register(self.waypoint_name_field, "waypoint_name_field")
   self:Register(xml:Init3tButton("waypoint_editor_form:btn_show_waypoint", self.waypoint_editor_form),
      "btn_show_waypoint")
   if self.waypoint_name_field:GetText() == nil or self.waypoint_name_field:GetText() == "" then
      if waypoint_name_saved == "" then
         self.waypoint_name_field:SetText(waypoint_name)
      else
         if self.check_autochange:GetCheck() then
            self.waypoint_name_field:SetText(waypoint_name_saved)
         else
            self.waypoint_name_field:SetText(waypoint_name)
         end
      end
      if waypoint_def_name ~= "" then
         if waypoint_def_name == "auto" then
            self.waypoint_name_field:SetText(string.sub(level.name(), 1, 3) .. "_")
         else
            self.waypoint_name_field:SetText(waypoint_def_name)
         end
         waypoint_def_name = ""
      end
   end
end

function waypoint_editor:InitCallBacks()
   self:AddCallback("btn_show_waypoint", ui_events.BUTTON_CLICKED, self.btn_show_waypoint, self)
   self:AddCallback("btn_print_waypoint", ui_events.BUTTON_CLICKED, self.btn_print_waypoint, self)
   self:AddCallback("btn_mark_point", ui_events.BUTTON_CLICKED, self.btn_mark_point, self)
   self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
end

function waypoint_editor:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   else
      self.waypoint_info:TextControl():SetText(waypoint_line_main)
   end
   sgm_functions.info_give_on_boolean(self.check_way_closed:GetCheck(), "waypoint_editor_check_way_closed", true)
   sgm_functions.info_give_on_boolean(self.check_empty_flags:GetCheck(), "waypoint_editor_check_empty_flags")
   sgm_functions.info_give_on_boolean(self.check_autochange:GetCheck(), "waypoint_editor_check_autochange")
end

function waypoint_editor:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_close()
      elseif dik == DIK_keys.DIK_SPACE then
         self:btn_mark_point(true)
      elseif dik == DIK_keys.DIK_RETURN then
         self:btn_print_waypoint()
      elseif dik == DIK_keys.DIK_SUBTRACT then
         self.waypoint_name_field:SetText(tostring(self.waypoint_name_field:GetText()) .. "_spawn_point")
      elseif dik == DIK_keys.DIK_ADD then
         self.waypoint_name_field:SetText(tostring(self.waypoint_name_field:GetText()) .. "_traveller_actor")
      end
   end
   return true
end

function waypoint_editor:btn_mark_point(close_activate)
   if close_activate == nil or close_activate == true then
      self:btn_close()
   end
   if waypoint_line_main == "" then
      waypoint_line_main = "points = p0"
      waypoint_points_counter = waypoint_points_counter + 1
   else
      waypoint_points_counter = waypoint_points_counter + 1
      if waypoint_points_counter >= 1 then
         waypoint_data = waypoint_data .. waypoint_line_attacher
      end
      waypoint_line_main = waypoint_line_main .. ",p" .. waypoint_points_counter
   end
   if waypoint_points_counter ~= -1 then
      local next_point = waypoint_points_counter + 1
      if (self.point_animation_field:GetText() == nil or self.point_animation_field:GetText() == "") and (self.point_signal_field:GetText() == nil or self.point_signal_field:GetText() == "") then
         waypoint_line_1 = "p" ..
             waypoint_points_counter .. ":name = wp0" .. waypoint_points_counter .. game.translate_string("\n")
         if find_in_string(tostring(waypoint_name), "_walker_") then
            waypoint_line_1 = "p" ..
                waypoint_points_counter .. ":name = wp0" .. waypoint_points_counter ..
                "|a=patrol" .. game.translate_string("\n")
         elseif find_in_string(tostring(waypoint_name), "_sniper_") and find_in_string(tostring(waypoint_name), "_look") then
            waypoint_line_1 = "p" ..
                waypoint_points_counter .. ":name = wp0" ..
                waypoint_points_counter .. "|a=guard_na" .. game.translate_string("\n")
         elseif find_in_string(tostring(waypoint_name), "_surge_") and find_in_string(tostring(waypoint_name), "_look") then
            waypoint_line_1 = "p" ..
                waypoint_points_counter .. ":name = wp0" .. waypoint_points_counter .. "|a=sit" ..
                game.translate_string("\n")
         elseif find_in_string(tostring(waypoint_name), "_guard_") and find_in_string(tostring(waypoint_name), "_look") then
            waypoint_line_1 = "p" ..
                waypoint_points_counter .. ":name = wp0" .. waypoint_points_counter ..
                "|a=guard" .. game.translate_string("\n")
         end
      elseif (self.point_animation_field:GetText() ~= nil and self.point_animation_field:GetText() ~= "") and (self.point_signal_field:GetText() == nil or self.point_signal_field:GetText() == "") then
         waypoint_line_1 = "p" ..
             waypoint_points_counter ..
             ":name = wp0" ..
             waypoint_points_counter .. "|a=" .. tostring(self.point_animation_field:GetText()) ..
             game.translate_string("\n")
      elseif (self.point_signal_field:GetText() ~= nil and self.point_signal_field:GetText() ~= "") and (self.point_animation_field:GetText() == nil or self.point_animation_field:GetText() == "") then
         waypoint_line_1 = "p" ..
             waypoint_points_counter ..
             ":name = wp0" ..
             waypoint_points_counter ..
             "|sig=" .. tostring(self.point_signal_field:GetText()) .. game.translate_string("\n")
      elseif (self.point_animation_field:GetText() ~= nil and self.point_animation_field:GetText() ~= "") and (self.point_signal_field:GetText() ~= nil and self.point_signal_field:GetText() ~= "") then
         waypoint_line_1 = "p" ..
             waypoint_points_counter ..
             ":name = wp0" ..
             waypoint_points_counter ..
             "|a=" ..
             tostring(self.point_animation_field:GetText()) ..
             "|sig=" .. tostring(self.point_signal_field:GetText()) .. game.translate_string("\n")
      end
      if self.check_empty_flags:GetCheck() or find_in_string(tostring(waypoint_name), "_spawn_point") or find_in_string(tostring(waypoint_name), "_home") or find_in_string(tostring(waypoint_name), "_traveller_") or find_in_string(tostring(waypoint_name), "_af_way_") then
         waypoint_line_2 = ""
      else
         waypoint_line_2 = "p" .. waypoint_points_counter .. ":flags = 0x1" .. game.translate_string("\n")
         if find_in_string(tostring(waypoint_name), "_sleep_") and waypoint_points_counter == 1 then
            waypoint_line_2 = ""
         end
      end
      waypoint_line_3 = "p" ..
          waypoint_points_counter ..
          ":position = " ..
          db.actor:position().x .. "," .. db.actor:position().y .. "," .. db.actor:position().z ..
          game.translate_string("\n")
      waypoint_line_4 = "p" ..
          waypoint_points_counter .. ":game_vertex_id = " .. db.actor:game_vertex_id() .. game.translate_string("\n")
      waypoint_line_5 = "p" ..
          waypoint_points_counter .. ":level_vertex_id = " .. db.actor:level_vertex_id() .. game.translate_string("\n")
      if waypoint_points_counter >= 1 and self.check_way_closed:GetCheck() then
         waypoint_line_6 = "p" .. waypoint_points_counter .. ":links = p0(1)" .. game.translate_string("\n")
      else
         waypoint_line_6 = ""
      end
      if find_in_string(tostring(waypoint_name), "_traveller_") then
         waypoint_line_6 = ""
      end
      waypoint_line_attacher = "p" ..
          waypoint_points_counter .. ":links = " .. "p" .. next_point .. "(1)" .. game.translate_string("\n")
      waypoint_data = waypoint_data ..
          game.translate_string("\n") .. waypoint_line_1 ..
          waypoint_line_2 .. waypoint_line_3 .. waypoint_line_4 .. waypoint_line_5
   end
   waypoint_line_1, waypoint_line_2, waypoint_line_3, waypoint_line_4, waypoint_line_5 = "", "", "", "", ""
end

function waypoint_editor:btn_print_waypoint()
   if waypoint_line_main == "" and not self.check_autochange:GetCheck() then
      self:btn_mark_point(true)
   else
      self:btn_close()
   end
   if self.check_autochange:GetCheck() then
      if waypoint_autochange_add == "walk" then
         waypoint_autochange_add = "look"
      elseif waypoint_autochange_add == "look" then
         waypoint_autochange_add = "walk"
      end
      if waypoint_name_saved == "" then
         waypoint_name = tostring(waypoint_name) .. "_" .. waypoint_autochange_add
      else
         if tostring(self.waypoint_name_field:GetText()) ~= waypoint_name_saved then
            waypoint_name_saved = tostring(self.waypoint_name_field:GetText())
         end
         waypoint_name = waypoint_name_saved .. "_" .. waypoint_autochange_add
      end
      waypoint_name_saved = tostring(self.waypoint_name_field:GetText())
      self:btn_mark_point(false)
   end
   waypoint_assembly = game.translate_string("\n") ..
       "[" .. tostring(waypoint_name) .. "]" ..
       game.translate_string("\n") .. waypoint_line_main .. waypoint_data .. waypoint_line_6
   debug_to_file("waypoints.txt", waypoint_assembly)
   give_quick_news("Путь " .. waypoint_name .. " успешно создан.")
   waypoint_line_main = ""
   waypoint_points_counter = -1
   waypoint_assembly, waypoint_data = "", ""
end

function waypoint_editor:btn_show_waypoint()
   run_choose_box("yes", "waypoint_editor",
      game.translate_string("\n") ..
      "[" .. tostring(waypoint_name) .. "]" .. game.translate_string("\n") .. waypoint_line_main .. waypoint_data)
end

function waypoint_editor:btn_close()
   waypoint_name = self.waypoint_name_field:GetText()
   self:HideDialog()
   set_ui_worked()
end

------------------------------------------------------------------------------
--                          Обработка файла "all.spawn"                     --
------------------------------------------------------------------------------
local allspawn_cfg_radius = 1
local allspawn_cfg_counting = 1 --/ Начальный отсчет секции
local allspawn_cfg_magazine = 30
local allspawn_cfg_prefix = "nil"
local allspawn_cfg_suffix = "nil"
local allspawn_cfg_logic_path = "nil"
local allspawn_cfg_hiding_place = "nil"
local allspawn_editor_section = 1
local allspawn_last_name = "nil"
local allspawn_last_type = "nil"
local allspawn_last_id = "nil"
local allspawn_auto_print_mode = false
local allspawn_auto_print_delay = 4000 --/ Частота авто-отладки
local allspawn_def_name_1 = "auto"
local allspawn_def_name_2 = "smart_terrain"
local allspawn_def_logic_path = ""
local allspawn_button_active = false
local allspawn_button_action = false
local allspawn_sections_panel_1 = {
   { name = "space_restrictor", type = "space_restrictor", id = 1 },
   { name = "smart_terrain",    type = "smart_terrain",    id = 2 },
   { name = "anomal_zone",      type = "anomal_zone",      id = 3 },
   { name = "inventory_box",    type = "inventory_box",    id = 4 }
}
local allspawn_sections_panel_2 = {
   { name = "sgm_acidic_field_weak",           type = "anomaly", id = 1 },
   { name = "sgm_acidic_field_average",        type = "anomaly", id = 2 },
   { name = "sgm_acidic_field_strong",         type = "anomaly", id = 3 },
   { name = "sgm_psychic_field_weak",          type = "anomaly", id = 4 },
   { name = "sgm_psychic_field_average",       type = "anomaly", id = 5 },
   { name = "sgm_psychic_field_strong",        type = "anomaly", id = 6 },
   { name = "sgm_radioactive_field_weak",      type = "anomaly", id = 7 },
   { name = "sgm_radioactive_field_average",   type = "anomaly", id = 8 },
   { name = "sgm_radioactive_field_strong",    type = "anomaly", id = 9 },
   { name = "sgm_thermal_field_weak",          type = "anomaly", id = 10 },
   { name = "sgm_thermal_field_average",       type = "anomaly", id = 11 },
   { name = "sgm_thermal_field_strong",        type = "anomaly", id = 12 },
   { name = "sgm_thermal_streem_weak",         type = "anomaly", id = 13 },
   { name = "sgm_thermal_streem_average",      type = "anomaly", id = 14 },
   { name = "sgm_thermal_streem_strong",       type = "anomaly", id = 15 },
   { name = "sgm_blue_thermal_streem_weak",    type = "anomaly", id = 16 },
   { name = "sgm_blue_thermal_streem_average", type = "anomaly", id = 17 },
   { name = "sgm_blue_thermal_streem_strong",  type = "anomaly", id = 18 },
   { name = "sgm_red_thermal_streem_weak",     type = "anomaly", id = 19 },
   { name = "sgm_red_thermal_streem_average",  type = "anomaly", id = 20 },
   { name = "sgm_red_thermal_streem_strong",   type = "anomaly", id = 21 },
   { name = "sgm_gravitational_field_weak",    type = "anomaly", id = 22 },
   { name = "sgm_gravitational_field_average", type = "anomaly", id = 23 },
   { name = "sgm_gravitational_field_strong",  type = "anomaly", id = 24 },
   { name = "sgm_electric_field_weak",         type = "anomaly", id = 25 },
   { name = "sgm_electric_field_average",      type = "anomaly", id = 26 },
   { name = "sgm_electric_field_strong",       type = "anomaly", id = 27 },
   { name = "sgm_throw_field",                 type = "anomaly", id = 28 },
   { name = "zone_mine_field",                 type = "anomaly", id = 29 },
}
local allspawn_sections_panel_3 = {
   { name = "af_cristall",          type = "other", id = 1 },
   { name = "af_fireball",          type = "other", id = 2 },
   { name = "af_dummy_glassbeads",  type = "other", id = 3 },
   { name = "af_eye",               type = "other", id = 4 },
   { name = "af_fire",              type = "other", id = 5 },
   { name = "af_medusa",            type = "other", id = 6 },
   { name = "af_cristall_flower",   type = "other", id = 7 },
   { name = "af_night_star",        type = "other", id = 8 },
   { name = "af_vyvert",            type = "other", id = 9 },
   { name = "af_gravi",             type = "other", id = 10 },
   { name = "af_gold_fish",         type = "other", id = 11 },
   { name = "af_blood",             type = "other", id = 12 },
   { name = "af_mincer_meat",       type = "other", id = 13 },
   { name = "af_soul",              type = "other", id = 14 },
   { name = "af_fuzz_kolobok",      type = "other", id = 15 },
   { name = "af_baloon",            type = "other", id = 16 },
   { name = "af_glass",             type = "other", id = 17 },
   { name = "af_electra_sparkler",  type = "other", id = 18 },
   { name = "af_electra_flash",     type = "other", id = 19 },
   { name = "af_electra_moonlight", type = "other", id = 20 },
   { name = "af_dummy_battery",     type = "other", id = 21 },
   { name = "af_dummy_dummy",       type = "other", id = 22 },
   { name = "af_ice",               type = "other", id = 23 },
   { name = "af_monolit",           type = "other", id = 24 },
   { name = "af_geliy",             type = "other", id = 25 },
   { name = "af_vaselisk",          type = "other", id = 26 },
   { name = "af_dragon_eye",        type = "other", id = 27 },
   { name = "cev_plastin_1",        type = "other", id = 28 },
   { name = "cev_plastin_2",        type = "other", id = 29 },
   { name = "cev_plastin_3",        type = "other", id = 30 },
   { name = "cev_plastin_4",        type = "other", id = 31 },
   { name = "cev_plastin_5",        type = "other", id = 32 }
}
local allspawn_sections_panel_4 = {
   { name = "helm_spectacles",           type = "outfit", id = 1 },
   { name = "helm_mercenary",            type = "outfit", id = 2 },
   { name = "helm_piranhas",             type = "outfit", id = 3 },
   { name = "helm_respirator",           type = "outfit", id = 4 },
   { name = "helm_hardhat",              type = "outfit", id = 5 },
   { name = "helm_protective",           type = "outfit", id = 6 },
   { name = "helm_tactic",               type = "outfit", id = 7 },
   { name = "helm_battle",               type = "outfit", id = 8 },
   { name = "novice_outfit",             type = "outfit", id = 9 },
   { name = "stalker_outfit",            type = "outfit", id = 10 },
   { name = "scientific_outfit",         type = "outfit", id = 11 },
   { name = "svoboda_light_outfit",      type = "outfit", id = 12 },
   { name = "svoboda_heavy_outfit",      type = "outfit", id = 13 },
   { name = "cs_heavy_outfit",           type = "outfit", id = 14 },
   { name = "dolg_outfit",               type = "outfit", id = 15 },
   { name = "dolg_heavy_outfit",         type = "outfit", id = 16 },
   { name = "exo_outfit",                type = "outfit", id = 17 },
   { name = "specops_outfit",            type = "outfit", id = 18 },
   { name = "military_outfit",           type = "outfit", id = 19 },
   { name = "ecolog_regular_outfit",     type = "outfit", id = 20 },
   { name = "ecolog_military_outfit",    type = "outfit", id = 21 },
   { name = "killer_outfit",             type = "outfit", id = 22 },
   { name = "monolith_outfit",           type = "outfit", id = 23 },
   { name = "cs_specnaz_outfit",         type = "outfit", id = 24 },
   { name = "csky_exo_outfit",           type = "outfit", id = 25 },
   { name = "freedom_exo_outfit",        type = "outfit", id = 26 },
   { name = "dolg_exo_outfit",           type = "outfit", id = 27 },
   { name = "monolit_exo_outfit",        type = "outfit", id = 28 },
   { name = "heavy_stalker_outfit",      type = "outfit", id = 29 },
   { name = "bandit_raid_outfit",        type = "outfit", id = 30 },
   { name = "svoboda_army_outfit",       type = "outfit", id = 31 },
   { name = "bandit_prikid_outfit",      type = "outfit", id = 32 },
   { name = "novice_stalker_outfit",     type = "outfit", id = 33 },
   { name = "novice_bandit_outfit",      type = "outfit", id = 34 },
   { name = "bandit_exo_outfit",         type = "outfit", id = 35 },
   { name = "army_exo_outfit",           type = "outfit", id = 36 },
   { name = "killer_exo_outfit",         type = "outfit", id = 37 },
   { name = "stalker_reinforced_outfit", type = "outfit", id = 38 },
   { name = "army_nauchniy_outfit",      type = "outfit", id = 39 }
}
local allspawn_sections_panel_5 = {
   { name = "wpn_pm",                 type = "weapon", id = 1 },
   { name = "wpn_pb",                 type = "weapon", id = 2 },
   { name = "wpn_fort",               type = "weapon", id = 3 },
   { name = "wpn_hpsa",               type = "weapon", id = 4 },
   { name = "wpn_beretta",            type = "weapon", id = 5 },
   { name = "wpn_walther",            type = "weapon", id = 6 },
   { name = "wpn_sig220",             type = "weapon", id = 7 },
   { name = "wpn_colt1911",           type = "weapon", id = 8 },
   { name = "wpn_usp",                type = "weapon", id = 9 },
   { name = "wpn_desert_eagle",       type = "weapon", id = 10 },
   { name = "wpn_bm16",               type = "weapon", id = 11 },
   { name = "wpn_toz34",              type = "weapon", id = 12 },
   { name = "wpn_wincheaster1300",    type = "weapon", id = 13 },
   { name = "wpn_spas12",             type = "weapon", id = 14 },
   { name = "wpn_protecta",           type = "weapon", id = 15 },
   { name = "wpn_ak74u",              type = "weapon", id = 16 },
   { name = "wpn_mp5",                type = "weapon", id = 17 },
   { name = "wpn_ak74",               type = "weapon", id = 18 },
   { name = "wpn_abakan",             type = "weapon", id = 19 },
   { name = "wpn_l85",                type = "weapon", id = 20 },
   { name = "wpn_gauss",              type = "weapon", id = 21 },
   { name = "wpn_lr300",              type = "weapon", id = 22 },
   { name = "wpn_sig550",             type = "weapon", id = 23 },
   { name = "wpn_groza",              type = "weapon", id = 24 },
   { name = "wpn_val",                type = "weapon", id = 25 },
   { name = "wpn_vintorez",           type = "weapon", id = 26 },
   { name = "wpn_svu",                type = "weapon", id = 27 },
   { name = "wpn_svd",                type = "weapon", id = 28 },
   { name = "wpn_rg-6",               type = "weapon", id = 29 },
   { name = "wpn_rpg7",               type = "weapon", id = 30 },
   { name = "wpn_g36",                type = "weapon", id = 31 },
   { name = "wpn_fn2000",             type = "weapon", id = 32 },
   { name = "wpn_pkm",                type = "weapon", id = 33 },
   { name = "wpn_abakan_m1",          type = "weapon", id = 34 },
   { name = "wpn_abakan_m2",          type = "weapon", id = 35 },
   { name = "wpn_abakan_m3",          type = "weapon", id = 36 },
   { name = "wpn_ak74u_m1",           type = "weapon", id = 37 },
   { name = "wpn_ak74u_m2",           type = "weapon", id = 38 },
   { name = "wpn_ak74u_m3",           type = "weapon", id = 39 },
   { name = "wpn_ak74_m1",            type = "weapon", id = 40 },
   { name = "wpn_ak74_m2",            type = "weapon", id = 41 },
   { name = "wpn_ak74_m3",            type = "weapon", id = 42 },
   { name = "wpn_beretta_m1",         type = "weapon", id = 43 },
   { name = "wpn_beretta_m2",         type = "weapon", id = 44 },
   { name = "wpn_beretta_m3",         type = "weapon", id = 45 },
   { name = "wpn_bm16_m1",            type = "weapon", id = 46 },
   { name = "wpn_bm16_m2",            type = "weapon", id = 47 },
   { name = "wpn_bm16_m3",            type = "weapon", id = 48 },
   { name = "wpn_fort_m1",            type = "weapon", id = 49 },
   { name = "wpn_fort_m2",            type = "weapon", id = 50 },
   { name = "wpn_fort_m3",            type = "weapon", id = 51 },
   { name = "wpn_groza_m1",           type = "weapon", id = 52 },
   { name = "wpn_groza_m2",           type = "weapon", id = 53 },
   { name = "wpn_groza_m3",           type = "weapon", id = 54 },
   { name = "wpn_lr300_m1",           type = "weapon", id = 55 },
   { name = "wpn_lr300_m2",           type = "weapon", id = 56 },
   { name = "wpn_lr300_m3",           type = "weapon", id = 57 },
   { name = "wpn_mp5_m1",             type = "weapon", id = 58 },
   { name = "wpn_mp5_m2",             type = "weapon", id = 59 },
   { name = "wpn_mp5_m3",             type = "weapon", id = 60 },
   { name = "wpn_pm_m1",              type = "weapon", id = 61 },
   { name = "wpn_pm_m2",              type = "weapon", id = 62 },
   { name = "wpn_pm_m3",              type = "weapon", id = 63 },
   { name = "wpn_sig220_m1",          type = "weapon", id = 64 },
   { name = "wpn_sig220_m2",          type = "weapon", id = 65 },
   { name = "wpn_sig220_m3",          type = "weapon", id = 66 },
   { name = "wpn_sig550_m1",          type = "weapon", id = 67 },
   { name = "wpn_sig550_m2",          type = "weapon", id = 68 },
   { name = "wpn_sig550_m3",          type = "weapon", id = 69 },
   { name = "wpn_spas12_m1",          type = "weapon", id = 70 },
   { name = "wpn_spas12_m2",          type = "weapon", id = 71 },
   { name = "wpn_spas12_m3",          type = "weapon", id = 72 },
   { name = "wpn_toz34_m1",           type = "weapon", id = 73 },
   { name = "wpn_toz34_m2",           type = "weapon", id = 74 },
   { name = "wpn_toz34_m3",           type = "weapon", id = 75 },
   { name = "wpn_vintorez_m1",        type = "weapon", id = 76 },
   { name = "wpn_vintorez_m2",        type = "weapon", id = 77 },
   { name = "wpn_vintorez_m3",        type = "weapon", id = 78 },
   { name = "wpn_wincheaster1300_m1", type = "weapon", id = 79 },
   { name = "wpn_wincheaster1300_m2", type = "weapon", id = 80 },
   { name = "wpn_wincheaster1300_m3", type = "weapon", id = 81 }
}
local allspawn_sections_panel_6 = {
   { name = "ammo_9x18_fmj",                   type = "ammo",    id = 1 },
   { name = "ammo_9x18_pmm",                   type = "ammo",    id = 2 },
   { name = "ammo_9x19_fmj",                   type = "ammo",    id = 4 },
   { name = "ammo_9x19_pbp",                   type = "ammo",    id = 5 },
   { name = "ammo_11.43x23_hydro",             type = "ammo",    id = 7 },
   { name = "ammo_11.43x23_fmj",               type = "ammo",    id = 8 },
   { name = "ammo_12x70_buck",                 type = "ammo",    id = 9 },
   { name = "ammo_12x76_zhekan",               type = "ammo",    id = 10 },
   { name = "ammo_5.45x39_fmj",                type = "ammo",    id = 13 },
   { name = "ammo_5.45x39_ap",                 type = "ammo",    id = 14 },
   { name = "ammo_9x39_pab9",                  type = "ammo",    id = 17 },
   { name = "ammo_9x39_ap",                    type = "ammo",    id = 18 },
   { name = "ammo_5.56x45_ss190",              type = "ammo",    id = 20 },
   { name = "ammo_5.56x45_ap",                 type = "ammo",    id = 21 },
   { name = "ammo_7.62x54_7h1",                type = "ammo",    id = 23 },
   { name = "ammo_pkm_100",                    type = "ammo",    id = 29 },
   { name = "ammo_dumdum",                     type = "ammo",    id = 30 },
   { name = "ammo_gauss",                      type = "ammo",    id = 32 },
   { name = "ammo_gauss_cardan",               type = "ammo",    id = 33 },
   { name = "ammo_og-7b",                      type = "ammo",    id = 34 },
   { name = "ammo_vog-25",                     type = "ammo",    id = 35 },
   { name = "ammo_m209",                       type = "ammo",    id = 36 },
   { name = "ammo_box_10_vog",                 type = "ammo",    id = 37 },
   { name = "ammo_box_10_m209",                type = "ammo",    id = 38 },
   { name = "grenade_rgd5",                    type = "grenade", id = 39 },
   { name = "grenade_f1",                      type = "grenade", id = 40 },
   { name = "grenade_gd-05",                   type = "grenade", id = 41 },
   { name = "grenade_rgd5_double",             type = "grenade", id = 42 },
   { name = "grenade_f1_double",               type = "grenade", id = 43 },
   { name = "grenade_gd-05_double",            type = "grenade", id = 44 },
   { name = "wpn_addon_scope",                 type = "other",   id = 45 },
   { name = "wpn_addon_scope_x2.7",            type = "other",   id = 46 },
   { name = "wpn_addon_scope_detector",        type = "other",   id = 47 },
   { name = "wpn_addon_scope_night",           type = "other",   id = 48 },
   { name = "wpn_addon_scope_susat",           type = "other",   id = 49 },
   { name = "wpn_addon_scope_susat_x1.6",      type = "other",   id = 50 },
   { name = "wpn_addon_scope_susat_custom",    type = "other",   id = 51 },
   { name = "wpn_addon_scope_susat_dusk",      type = "other",   id = 52 },
   { name = "wpn_addon_scope_susat_night",     type = "other",   id = 53 },
   { name = "wpn_addon_silencer",              type = "other",   id = 54 },
   { name = "wpn_addon_grenade_launcher",      type = "other",   id = 55 },
   { name = "wpn_addon_grenade_launcher_m203", type = "other",   id = 56 },
   { name = "wpn_addon_silencer_9x19",         type = "other",   id = 57 },
   { name = "wpn_addon_silencer_11.43x23",     type = "other",   id = 58 },
   { name = "wpn_addon_silencer_5.56x45",      type = "other",   id = 59 },
   { name = "wpn_addon_silencer_5.45x39",      type = "other",   id = 60 },
   { name = "wpn_addon_silencer_9x39",         type = "other",   id = 61 }
}
local allspawn_sections_panel_7 = {
   { name = "bandage",                     type = "other",     id = 1 },
   { name = "bio_bandage",                 type = "other",     id = 2 },
   { name = "medkit",                      type = "other",     id = 3 },
   { name = "medkit_army",                 type = "other",     id = 4 },
   { name = "medkit_scientic",             type = "other",     id = 5 },
   { name = "medkit_elite",                type = "other",     id = 6 },
   { name = "psy_complex",                 type = "other",     id = 7 },
   { name = "antirad",                     type = "other",     id = 8 },
   { name = "medkit_used",                 type = "other",     id = 9 },
   { name = "medkit_army_used",            type = "other",     id = 10 },
   { name = "medkit_scientic_used",        type = "other",     id = 11 },
   { name = "medkit_elite_used",           type = "other",     id = 12 },
   { name = "drug_booster",                type = "other",     id = 13 },
   { name = "drug_coagulant",              type = "other",     id = 14 },
   { name = "drug_psy_blockade",           type = "other",     id = 15 },
   { name = "drug_antidot",                type = "other",     id = 16 },
   { name = "drug_radioprotector",         type = "other",     id = 17 },
   { name = "drug_anabiotic",              type = "other",     id = 18 },
   { name = "drug_engine",                 type = "other",     id = 19 },
   { name = "bread",                       type = "other",     id = 20 },
   { name = "kolbasa",                     type = "other",     id = 21 },
   { name = "conserva",                    type = "other",     id = 22 },
   { name = "vodka",                       type = "other",     id = 23 },
   { name = "energy_drink",                type = "other",     id = 24 },
   { name = "wild_drink",                  type = "other",     id = 25 },
   { name = "nuts",                        type = "other",     id = 26 },
   { name = "sardina",                     type = "other",     id = 27 },
   { name = "olivki",                      type = "other",     id = 28 },
   { name = "cheese",                      type = "other",     id = 29 },
   { name = "galet",                       type = "other",     id = 30 },
   { name = "shokolad",                    type = "other",     id = 31 },
   { name = "batonchik",                   type = "other",     id = 32 },
   { name = "beer",                        type = "other",     id = 33 },
   { name = "juice",                       type = "other",     id = 34 },
   { name = "personal_marker",             type = "other",     id = 35 },
   { name = "geiger_counter",              type = "other",     id = 36 },
   { name = "minetrap_detector",           type = "other",     id = 37 },
   { name = "minetrap_elite_detector",     type = "other",     id = 38 },
   { name = "remote_explosive_charge",     type = "other",     id = 39 },
   { name = "demolution_ballon",           type = "other",     id = 40 },
   { name = "demolution_kanistra",         type = "other",     id = 41 },
   { name = "demolution_barrel",           type = "other",     id = 42 },
   { name = "guidebook_mono",              type = "other",     id = 43 },
   { name = "conventer_grenade_box",       type = "other",     id = 44 },
   { name = "army_timer",                  type = "other",     id = 45 },
   { name = "repair_outfit_box",           type = "other",     id = 46 },
   { name = "repair_outfit_box_used",      type = "other",     id = 47 },
   { name = "repair_arms_box",             type = "other",     id = 48 },
   { name = "repair_arms_box_used",        type = "other",     id = 49 },
   { name = "emulator_brain_waves",        type = "other",     id = 50 },
   { name = "mp3_player",                  type = "other",     id = 51 },
   { name = "personal_rukzak",             type = "other",     id = 52 },
   { name = "device_torch",                type = "other",     id = 53 },
   { name = "detector_simple",             type = "other",     id = 54 },
   { name = "detector_advanced",           type = "other",     id = 55 },
   { name = "detector_elite",              type = "other",     id = 56 },
   { name = "detector_scientific",         type = "other",     id = 57 },
   { name = "detector_omega",              type = "other",     id = 58 },
   { name = "detector_simple_up",          type = "other",     id = 59 },
   { name = "detector_advanced_up",        type = "other",     id = 60 },
   { name = "detector_elite_up",           type = "other",     id = 61 },
   { name = "detector_scientific_up",      type = "other",     id = 62 },
   { name = "detector_omega_up",           type = "other",     id = 63 },
   { name = "mutant_snork_booty",          type = "other",     id = 64 },
   { name = "mutant_psevdodog_booty",      type = "other",     id = 65 },
   { name = "mutant_krovosos_booty",       type = "other",     id = 66 },
   { name = "mutant_boar_booty",           type = "other",     id = 67 },
   { name = "mutant_dog_booty",            type = "other",     id = 68 },
   { name = "mutant_flesh_booty",          type = "other",     id = 69 },
   { name = "mutant_giant_booty",          type = "other",     id = 70 },
   { name = "mutant_chimera_booty",        type = "other",     id = 71 },
   { name = "mutant_controler_booty",      type = "other",     id = 72 },
   { name = "mutant_burer_booty",          type = "other",     id = 73 },
   { name = "money_meshochek_100_500",     type = "other",     id = 74 },
   { name = "money_meshochek_100_3000",    type = "other",     id = 75 },
   { name = "money_meshochek_500_1000",    type = "other",     id = 76 },
   { name = "money_meshochek_1000_1500",   type = "other",     id = 77 },
   { name = "money_meshochek_1000_5000",   type = "other",     id = 78 },
   { name = "money_meshochek_1500_2000",   type = "other",     id = 79 },
   { name = "money_meshochek_2000_3000",   type = "other",     id = 80 },
   { name = "money_meshochek_3000_4000",   type = "other",     id = 81 },
   { name = "money_meshochek_4000_5000",   type = "other",     id = 82 },
   { name = "money_meshochek_5000_10000",  type = "other",     id = 83 },
   { name = "money_meshochek_10000_15000", type = "other",     id = 84 },
   { name = "money_meshochek_15000_20000", type = "other",     id = 85 },
   { name = "capture_meal_chimera",        type = "other",     id = 86 },
   { name = "capture_meal_gigant",         type = "other",     id = 87 },
   { name = "capture_meal_boar",           type = "other",     id = 88 },
   { name = "capture_meal_dog",            type = "other",     id = 89 },
   { name = "capture_meal_flesh",          type = "other",     id = 90 },
   { name = "capture_meal_tushkano",       type = "other",     id = 91 },
   { name = "capture_meal_pseudodog",      type = "other",     id = 92 },
   { name = "capture_meal_snork",          type = "other",     id = 93 },
   { name = "explosive_barrel",            type = "explosive", id = 94 },
   { name = "explosive_fuelcan",           type = "explosive", id = 95 },
   { name = "explosive_tank",              type = "explosive", id = 96 },
   { name = "bag_medkit_1",                type = "other",     id = 97 },
   { name = "bag_medkit_2",                type = "other",     id = 98 },
   { name = "bag_medkit_3",                type = "other",     id = 99 },
   { name = "bag_medkit_4",                type = "other",     id = 100 }
}
local allspawn_sections_panel_8 = {
   { name = "wpn_pm",                    type = "weapon", id = 1 },
   { name = "wpn_pb",                    type = "weapon", id = 2 },
   { name = "wpn_fort",                  type = "weapon", id = 3 },
   { name = "wpn_hpsa",                  type = "weapon", id = 4 },
   { name = "wpn_beretta",               type = "weapon", id = 5 },
   { name = "wpn_walther",               type = "weapon", id = 6 },
   { name = "wpn_sig220",                type = "weapon", id = 7 },
   { name = "wpn_colt1911",              type = "weapon", id = 8 },
   { name = "wpn_usp",                   type = "weapon", id = 9 },
   { name = "wpn_desert_eagle",          type = "weapon", id = 10 },
   { name = "wpn_bm16",                  type = "weapon", id = 11 },
   { name = "wpn_toz34",                 type = "weapon", id = 12 },
   { name = "wpn_wincheaster1300",       type = "weapon", id = 13 },
   { name = "wpn_spas12",                type = "weapon", id = 14 },
   { name = "wpn_protecta",              type = "weapon", id = 15 },
   { name = "wpn_ak74u",                 type = "weapon", id = 16 },
   { name = "wpn_mp5",                   type = "weapon", id = 17 },
   { name = "wpn_ak74",                  type = "weapon", id = 18 },
   { name = "wpn_abakan",                type = "weapon", id = 19 },
   { name = "wpn_l85",                   type = "weapon", id = 20 },
   { name = "wpn_gauss",                 type = "weapon", id = 21 },
   { name = "wpn_lr300",                 type = "weapon", id = 22 },
   { name = "wpn_sig550",                type = "weapon", id = 23 },
   { name = "wpn_groza",                 type = "weapon", id = 24 },
   { name = "wpn_val",                   type = "weapon", id = 25 },
   { name = "wpn_vintorez",              type = "weapon", id = 26 },
   { name = "wpn_svu",                   type = "weapon", id = 27 },
   { name = "wpn_svd",                   type = "weapon", id = 28 },
   { name = "wpn_rg-6",                  type = "weapon", id = 29 },
   { name = "wpn_rpg7",                  type = "weapon", id = 30 },
   { name = "wpn_g36",                   type = "weapon", id = 31 },
   { name = "wpn_fn2000",                type = "weapon", id = 32 },
   { name = "wpn_pkm",                   type = "weapon", id = 33 },
   { name = "wpn_abakan_m1",             type = "weapon", id = 34 },
   { name = "wpn_abakan_m2",             type = "weapon", id = 35 },
   { name = "wpn_abakan_m3",             type = "weapon", id = 36 },
   { name = "wpn_ak74u_m1",              type = "weapon", id = 37 },
   { name = "wpn_ak74u_m2",              type = "weapon", id = 38 },
   { name = "wpn_ak74u_m3",              type = "weapon", id = 39 },
   { name = "wpn_ak74_m1",               type = "weapon", id = 40 },
   { name = "wpn_ak74_m2",               type = "weapon", id = 41 },
   { name = "wpn_ak74_m3",               type = "weapon", id = 42 },
   { name = "wpn_beretta_m1",            type = "weapon", id = 43 },
   { name = "wpn_beretta_m2",            type = "weapon", id = 44 },
   { name = "wpn_beretta_m3",            type = "weapon", id = 45 },
   { name = "wpn_bm16_m1",               type = "weapon", id = 46 },
   { name = "wpn_bm16_m2",               type = "weapon", id = 47 },
   { name = "wpn_bm16_m3",               type = "weapon", id = 48 },
   { name = "wpn_fort_m1",               type = "weapon", id = 49 },
   { name = "wpn_fort_m2",               type = "weapon", id = 50 },
   { name = "wpn_fort_m3",               type = "weapon", id = 51 },
   { name = "wpn_groza_m1",              type = "weapon", id = 52 },
   { name = "wpn_groza_m2",              type = "weapon", id = 53 },
   { name = "wpn_groza_m3",              type = "weapon", id = 54 },
   { name = "wpn_lr300_m1",              type = "weapon", id = 55 },
   { name = "wpn_lr300_m2",              type = "weapon", id = 56 },
   { name = "wpn_lr300_m3",              type = "weapon", id = 57 },
   { name = "wpn_mp5_m1",                type = "weapon", id = 58 },
   { name = "wpn_mp5_m2",                type = "weapon", id = 59 },
   { name = "wpn_mp5_m3",                type = "weapon", id = 60 },
   { name = "wpn_pm_m1",                 type = "weapon", id = 61 },
   { name = "wpn_pm_m2",                 type = "weapon", id = 62 },
   { name = "wpn_pm_m3",                 type = "weapon", id = 63 },
   { name = "wpn_sig220_m1",             type = "weapon", id = 64 },
   { name = "wpn_sig220_m2",             type = "weapon", id = 65 },
   { name = "wpn_sig220_m3",             type = "weapon", id = 66 },
   { name = "wpn_sig550_m1",             type = "weapon", id = 67 },
   { name = "wpn_sig550_m2",             type = "weapon", id = 68 },
   { name = "wpn_sig550_m3",             type = "weapon", id = 69 },
   { name = "wpn_spas12_m1",             type = "weapon", id = 70 },
   { name = "wpn_spas12_m2",             type = "weapon", id = 71 },
   { name = "wpn_spas12_m3",             type = "weapon", id = 72 },
   { name = "wpn_toz34_m1",              type = "weapon", id = 73 },
   { name = "wpn_toz34_m2",              type = "weapon", id = 74 },
   { name = "wpn_toz34_m3",              type = "weapon", id = 75 },
   { name = "wpn_vintorez_m1",           type = "weapon", id = 76 },
   { name = "wpn_vintorez_m2",           type = "weapon", id = 77 },
   { name = "wpn_vintorez_m3",           type = "weapon", id = 78 },
   { name = "wpn_wincheaster1300_m1",    type = "weapon", id = 79 },
   { name = "wpn_wincheaster1300_m2",    type = "weapon", id = 80 },
   { name = "wpn_wincheaster1300_m3",    type = "weapon", id = 81 },
   { name = "helm_spectacles",           type = "outfit", id = 1 },
   { name = "helm_mercenary",            type = "outfit", id = 2 },
   { name = "helm_piranhas",             type = "outfit", id = 3 },
   { name = "helm_respirator",           type = "outfit", id = 4 },
   { name = "helm_hardhat",              type = "outfit", id = 5 },
   { name = "helm_protective",           type = "outfit", id = 6 },
   { name = "helm_tactic",               type = "outfit", id = 7 },
   { name = "helm_battle",               type = "outfit", id = 8 },
   { name = "novice_outfit",             type = "outfit", id = 9 },
   { name = "stalker_outfit",            type = "outfit", id = 10 },
   { name = "scientific_outfit",         type = "outfit", id = 11 },
   { name = "svoboda_light_outfit",      type = "outfit", id = 12 },
   { name = "svoboda_heavy_outfit",      type = "outfit", id = 13 },
   { name = "cs_heavy_outfit",           type = "outfit", id = 14 },
   { name = "dolg_outfit",               type = "outfit", id = 15 },
   { name = "dolg_heavy_outfit",         type = "outfit", id = 16 },
   { name = "exo_outfit",                type = "outfit", id = 17 },
   { name = "specops_outfit",            type = "outfit", id = 18 },
   { name = "military_outfit",           type = "outfit", id = 19 },
   { name = "ecolog_regular_outfit",     type = "outfit", id = 20 },
   { name = "ecolog_military_outfit",    type = "outfit", id = 21 },
   { name = "killer_outfit",             type = "outfit", id = 22 },
   { name = "monolith_outfit",           type = "outfit", id = 23 },
   { name = "cs_specnaz_outfit",         type = "outfit", id = 24 },
   { name = "csky_exo_outfit",           type = "outfit", id = 25 },
   { name = "freedom_exo_outfit",        type = "outfit", id = 26 },
   { name = "dolg_exo_outfit",           type = "outfit", id = 27 },
   { name = "monolit_exo_outfit",        type = "outfit", id = 28 },
   { name = "heavy_stalker_outfit",      type = "outfit", id = 29 },
   { name = "bandit_raid_outfit",        type = "outfit", id = 30 },
   { name = "svoboda_army_outfit",       type = "outfit", id = 31 },
   { name = "bandit_prikid_outfit",      type = "outfit", id = 32 },
   { name = "novice_stalker_outfit",     type = "outfit", id = 33 },
   { name = "novice_bandit_outfit",      type = "outfit", id = 34 },
   { name = "bandit_exo_outfit",         type = "outfit", id = 35 },
   { name = "army_exo_outfit",           type = "outfit", id = 36 },
   { name = "killer_exo_outfit",         type = "outfit", id = 37 },
   { name = "stalker_reinforced_outfit", type = "outfit", id = 38 },
   { name = "army_nauchniy_outfit",      type = "outfit", id = 39 }
}
class "allspawn_editor_item" (CUIListBoxItem)
function allspawn_editor_item:__init(height)
   super(height)
   self.name = self:GetTextItem()
   self:SetTextColor(GetARGB(255, 210, 210, 210))
   self.name:SetFont(GetFontLetterica18Russian())
   self.name:SetWndSize(vector2():set(278, height))
   self.name:SetEllipsis(true)
end

class "allspawn_editor" (CUIScriptWnd)
function allspawn_editor:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
   if allspawn_editor_section == 1 then
      self:FillList(allspawn_sections_panel_1)
   elseif allspawn_editor_section == 2 then
      self:FillList(allspawn_sections_panel_2)
   elseif allspawn_editor_section == 3 then
      self:FillList(allspawn_sections_panel_3)
   elseif allspawn_editor_section == 4 then
      self:FillList(allspawn_sections_panel_4)
   elseif allspawn_editor_section == 5 then
      self:FillList(allspawn_sections_panel_5)
   elseif allspawn_editor_section == 6 then
      self:FillList(allspawn_sections_panel_6)
   elseif allspawn_editor_section == 7 then
      self:FillList(allspawn_sections_panel_7)
   end
end

function allspawn_editor:__finalize()
end

function allspawn_editor:FillList(list)
   self.stations_list:Clear()
   for k, v in pairs(list) do
      self:AddItemToList(v.name, v.type, v.id)
   end
end

function allspawn_editor:AddItemToList(name, type, id)
   local source = allspawn_editor_item(22)
   source.name:SetText(name)
   self.stations_list:AddExistingItem(source)
   source.type = type
   source.id = source:AddTextField(id, 0)
   source.id:SetWndPos(vector2():set(296, 0))
end

function allspawn_editor:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.allspawn_editor_form = xml:InitStatic("allspawn_editor_form", self)
   self.editor_title = xml:InitStatic("allspawn_editor_form:editor_title", self.allspawn_editor_form)
   self:start_button(xml, "btn_create")
   self:start_button(xml, "btn_close")
   self:start_button(xml, "btn_read_example")
   self:start_button(xml, "btn_radius_minus")
   self:start_button(xml, "btn_radius_plus")
   self:start_button(xml, "btn_counter_minus")
   self:start_button(xml, "btn_counter_plus")
   self:start_button(xml, "btn_magazine_minus")
   self:start_button(xml, "btn_magazine_plus")
   self:start_button(xml, "btn_auto_print_activate")
   self:start_button(xml, "btn_auto_print_deactivate")
   self:start_button(xml, "btn_switch_panel_1")
   self:start_button(xml, "btn_switch_panel_2")
   self:start_button(xml, "btn_switch_panel_3")
   self:start_button(xml, "btn_switch_panel_4")
   self:start_button(xml, "btn_switch_panel_5")
   self:start_button(xml, "btn_switch_panel_6")
   self:start_button(xml, "btn_switch_panel_7")
   self.check_with_logic = xml:InitCheck("allspawn_editor_form:check_with_logic", self.allspawn_editor_form)
   self.check_with_logic:SetCheck(sgm_functions.info_get_boolean("allspawn_editor_check_logic", true))
   self.check_another_mode = xml:InitCheck("allspawn_editor_form:check_another_mode", self.allspawn_editor_form)
   self.check_another_mode:SetCheck(sgm_functions.info_get_boolean("allspawn_editor_check_another_mode"))
   self.check_button_spawner = xml:InitCheck("allspawn_editor_form:check_button_spawner", self.allspawn_editor_form)
   self.check_button_spawner:SetCheck(sgm_functions.info_get_boolean("allspawn_editor_check_button_spawner"))
   self.cfg_display_radius = xml:InitStatic("allspawn_editor_form:cfg_display_radius", self.allspawn_editor_form)
   self.cfg_display_counter = xml:InitStatic("allspawn_editor_form:cfg_display_counter", self.allspawn_editor_form)
   self.cfg_display_magazine = xml:InitStatic("allspawn_editor_form:cfg_display_magazine", self.allspawn_editor_form)
   self.cfg_name_prefix_field = xml:InitEditBox("allspawn_editor_form:cfg_name_prefix_field", self.allspawn_editor_form)
   self.cfg_name_suffix_field = xml:InitEditBox("allspawn_editor_form:cfg_name_suffix_field", self.allspawn_editor_form)
   self.cfg_name_logic_path_field = xml:InitEditBox("allspawn_editor_form:cfg_name_logic_path_field",
      self.allspawn_editor_form)
   self.cfg_name_hiding_place_field = xml:InitEditBox("allspawn_editor_form:cfg_name_hiding_place_field",
      self.allspawn_editor_form)
   self.stations_list = xml:InitListBox("allspawn_editor_form:stations_list", self)
   self.stations_list:ShowSelectedItem(true)
   self:Register(self.stations_list, "stations_list_window")
   self.editor_title:TextControl():SetText(game.translate_string("st_allspawn_editor_title"))
   if allspawn_cfg_prefix == "nil" then
      if allspawn_def_name_1 == "" or allspawn_def_name_1 == "auto" then
         allspawn_cfg_prefix = string.sub(level.name(), 1, 3)
      else
         allspawn_cfg_prefix = allspawn_def_name_1
      end
      self.cfg_name_prefix_field:SetText(allspawn_cfg_prefix)
   else
      self.cfg_name_prefix_field:SetText(allspawn_cfg_prefix)
   end
   if allspawn_cfg_suffix == "nil" then
      if allspawn_def_name_2 == "" then
         allspawn_cfg_suffix = "mod_object"
      else
         allspawn_cfg_suffix = allspawn_def_name_2
      end
      self.cfg_name_suffix_field:SetText(allspawn_cfg_suffix)
   else
      self.cfg_name_suffix_field:SetText(allspawn_cfg_suffix)
   end
   if allspawn_cfg_logic_path ~= "nil" then
      self.cfg_name_logic_path_field:SetText(allspawn_cfg_logic_path)
   end
   if allspawn_cfg_hiding_place ~= "nil" then
      self.cfg_name_hiding_place_field:SetText(allspawn_cfg_hiding_place)
   end
end

function allspawn_editor:InitCallBacks()
   self:AddCallback("btn_switch_panel_1", ui_events.BUTTON_CLICKED, self.btn_switch_panel_1, self)
   self:AddCallback("btn_switch_panel_2", ui_events.BUTTON_CLICKED, self.btn_switch_panel_2, self)
   self:AddCallback("btn_switch_panel_3", ui_events.BUTTON_CLICKED, self.btn_switch_panel_3, self)
   self:AddCallback("btn_switch_panel_4", ui_events.BUTTON_CLICKED, self.btn_switch_panel_4, self)
   self:AddCallback("btn_switch_panel_5", ui_events.BUTTON_CLICKED, self.btn_switch_panel_5, self)
   self:AddCallback("btn_switch_panel_6", ui_events.BUTTON_CLICKED, self.btn_switch_panel_6, self)
   self:AddCallback("btn_switch_panel_7", ui_events.BUTTON_CLICKED, self.btn_switch_panel_7, self)
   self:AddCallback("btn_create", ui_events.BUTTON_CLICKED, self.btn_create, self)
   self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
   self:AddCallback("btn_read_example", ui_events.BUTTON_CLICKED, self.btn_read_example, self)
   self:AddCallback("btn_radius_minus", ui_events.BUTTON_CLICKED, self.btn_radius_minus, self)
   self:AddCallback("btn_radius_plus", ui_events.BUTTON_CLICKED, self.btn_radius_plus, self)
   self:AddCallback("btn_counter_minus", ui_events.BUTTON_CLICKED, self.btn_counter_minus, self)
   self:AddCallback("btn_counter_plus", ui_events.BUTTON_CLICKED, self.btn_counter_plus, self)
   self:AddCallback("btn_magazine_minus", ui_events.BUTTON_CLICKED, self.btn_magazine_minus, self)
   self:AddCallback("btn_magazine_plus", ui_events.BUTTON_CLICKED, self.btn_magazine_plus, self)
   self:AddCallback("btn_auto_print_activate", ui_events.BUTTON_CLICKED, self.btn_auto_print_activate, self)
   self:AddCallback("btn_auto_print_deactivate", ui_events.BUTTON_CLICKED, self.btn_auto_print_deactivate, self)
   self:AddCallback("stations_list_window", ui_events.WINDOW_LBUTTON_DB_CLICK, self.btn_create, self)
end

function allspawn_editor:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   end
   if allspawn_cfg_radius < 0 then allspawn_cfg_radius = 0 end
   if allspawn_cfg_counting < 0 then allspawn_cfg_counting = 0 end
   if allspawn_cfg_magazine < 0 then allspawn_cfg_magazine = 0 end
   if self.cfg_display_radius:TextControl():GetText() ~= allspawn_cfg_radius then
      self.cfg_display_radius:TextControl():SetText(allspawn_cfg_radius)
   end
   if self.cfg_display_counter:TextControl():GetText() ~= allspawn_cfg_counting then
      self.cfg_display_counter:TextControl():SetText(allspawn_cfg_counting)
   end
   if self.cfg_display_magazine:TextControl():GetText() ~= allspawn_cfg_magazine then
      self.cfg_display_magazine:TextControl():SetText(allspawn_cfg_magazine)
   end
   if self.check_with_logic:GetCheck() and (self:get_currert_selected("type") == "smart_terrain" or self:get_currert_selected("type") == "anomal_zone") then
      if allspawn_cfg_logic_path == "nil" then
         if allspawn_def_logic_path == "" then
            if self:get_currert_selected("type") == "smart_terrain" then
               allspawn_cfg_logic_path = "scripts\\" .. level.name() .. "\\" .. "smart" .. "\\" ..
                   allspawn_cfg_prefix .. "_"
            elseif self:get_currert_selected("type") == "anomal_zone" then
               allspawn_cfg_logic_path = "scripts\\" .. level.name() .. "\\" .. "anomaly" ..
                   "\\" .. allspawn_cfg_prefix .. "_"
            end
         else
            allspawn_cfg_logic_path = allspawn_def_logic_path
         end
         self.cfg_name_logic_path_field:SetText(allspawn_cfg_logic_path)
      end
   end
   if tostring(self.cfg_name_hiding_place_field:GetText()) ~= "" and (self:get_currert_selected("type") == "other" or self:get_currert_selected("type") == "ammo" or self:get_currert_selected("type") == "weapon" or self:get_currert_selected("type") == "outfit" or self:get_currert_selected("type") == "grenade") then
      if find_out_string(allspawn_cfg_suffix, "hiding_" .. self:get_currert_selected("name")) then
         allspawn_cfg_suffix = "hiding_" .. self:get_currert_selected("name")
         self.cfg_name_suffix_field:SetText(allspawn_cfg_suffix)
      end
   end
   if allspawn_auto_print_mode == false then
      self.get_btn_auto_print_activate:Show(true)
      self.get_btn_auto_print_activate:Enable(true)
      self.get_btn_auto_print_deactivate:Show(false)
      self.get_btn_auto_print_deactivate:Enable(false)
   else
      self.get_btn_auto_print_activate:Show(false)
      self.get_btn_auto_print_activate:Enable(false)
      self.get_btn_auto_print_deactivate:Show(true)
      self.get_btn_auto_print_deactivate:Enable(true)
   end
   sgm_functions.info_give_on_boolean(self.check_with_logic:GetCheck(), "allspawn_editor_check_logic", true)
   sgm_functions.info_give_on_boolean(self.check_another_mode:GetCheck(), "allspawn_editor_check_another_mode")
   sgm_functions.info_give_on_boolean(self.check_button_spawner:GetCheck(), "allspawn_editor_check_button_spawner")
   --/sgm_functions.info_give_on_boolean(self.check_another_mode_spawn:GetCheck(),"allspawn_editor_check_another_mode_spawn")
end

function allspawn_editor:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_close()
      end
   end
   return true
end

function allspawn_editor:start_button(xml, button_name)
   self["get_" .. button_name] = xml:Init3tButton("allspawn_editor_form:" .. button_name, self.allspawn_editor_form)
   self:Register(self["get_" .. button_name], button_name)
end

function allspawn_editor:btn_switch_panel_1()
   self:FillList(allspawn_sections_panel_1)
   allspawn_editor_section = 1
end

function allspawn_editor:btn_switch_panel_2()
   self:FillList(allspawn_sections_panel_2)
   allspawn_editor_section = 2
end

function allspawn_editor:btn_switch_panel_3()
   self:FillList(allspawn_sections_panel_3)
   allspawn_editor_section = 3
end

function allspawn_editor:btn_switch_panel_4()
   self:FillList(allspawn_sections_panel_4)
   allspawn_editor_section = 4
end

function allspawn_editor:btn_switch_panel_5()
   self:FillList(allspawn_sections_panel_5)
   allspawn_editor_section = 5
end

function allspawn_editor:btn_switch_panel_6()
   self:FillList(allspawn_sections_panel_6)
   allspawn_editor_section = 6
end

function allspawn_editor:btn_switch_panel_7()
   self:FillList(allspawn_sections_panel_7)
   allspawn_editor_section = 7
end

function allspawn_editor:btn_radius_minus()
   allspawn_cfg_radius = allspawn_cfg_radius - 0.5
end

function allspawn_editor:btn_radius_plus()
   allspawn_cfg_radius = allspawn_cfg_radius + 0.5
end

function allspawn_editor:btn_counter_minus()
   allspawn_cfg_counting = allspawn_cfg_counting - 1
end

function allspawn_editor:btn_counter_plus()
   allspawn_cfg_counting = allspawn_cfg_counting + 1
end

function allspawn_editor:btn_magazine_minus()
   allspawn_cfg_magazine = allspawn_cfg_magazine - 1
end

function allspawn_editor:btn_magazine_plus()
   allspawn_cfg_magazine = allspawn_cfg_magazine + 1
end

function allspawn_editor:btn_create()
   if self.stations_list:GetSize() == 0 then return end
   local item = self.stations_list:GetSelectedItem()
   if not item then
      if allspawn_last_name == "nil" then
         return
      else
         local item_name = tostring(allspawn_last_name)
         local item_type = tostring(allspawn_last_type)
         local item_id = tonumber(allspawn_last_id)
         self:check_data_by_id(item_name, item_type, item_id)
         return
      end
   end
   local item_name = tostring(item.name:GetText())
   local item_type = tostring(item.type)
   local item_id = tonumber(item.id:GetText())
   self:check_data_by_id(item_name, item_type, item_id)
end

function allspawn_editor:get_currert_selected(what)
   if self.stations_list:GetSize() == 0 then return nil end
   local item = self.stations_list:GetSelectedItem()
   if not item then return nil end
   if what == "name" then
      return tostring(item.name:GetText())
   elseif what == "type" then
      return tostring(item.type)
   else
      return tonumber(item.id:GetText())
   end
end

function allspawn_editor:check_data_by_id(name, type, id, only_read)
   local data, logic = "", ""
   if self.check_another_mode:GetCheck() then
      data = "create(" ..
          name ..
          "," ..
          db.actor:position().x ..
          "," ..
          db.actor:position().y ..
          "," .. db.actor:position().z .. "," .. db.actor:level_vertex_id() .. "," .. db.actor:game_vertex_id() .. ")"
   else
      if type == "space_restrictor" then
         if self.check_with_logic:GetCheck() then
            if find_in_string(tostring(self.cfg_name_suffix_field:GetText()), "hiding_place") then
               logic = "custom_data = <<END" ..
                   game.translate_string("\n") ..
                   "[secret]" ..
                   game.translate_string("\n") ..
                   "cfg = misc\\secret_" ..
                   level.name() .. ".ltx" .. game.translate_string("\n") .. "END" .. game.translate_string("\n")
            elseif tostring(self.cfg_name_logic_path_field:GetText()) == "" then
               logic = "custom_data = <<END" .. game.translate_string("\n") .. "END" .. game.translate_string("\n")
            else
               logic = "custom_data = <<END" ..
                   game.translate_string("\n") ..
                   "[logic]" ..
                   game.translate_string("\n") ..
                   "cfg = " ..
                   tostring(self.cfg_name_logic_path_field:GetText()) ..
                   ".ltx" .. game.translate_string("\n") .. "END" .. game.translate_string("\n")
            end
         end
      elseif type == "smart_terrain" then
         if self.check_with_logic:GetCheck() then
            logic = "custom_data = <<END" ..
                game.translate_string("\n") ..
                "[smart_terrain]" ..
                game.translate_string("\n") ..
                "cfg = " ..
                tostring(self.cfg_name_logic_path_field:GetText()) ..
                ".ltx" .. game.translate_string("\n") .. "END" .. game.translate_string("\n")
         end
      elseif type == "anomal_zone" then
         if self.check_with_logic:GetCheck() then
            logic = "custom_data = <<END" ..
                game.translate_string("\n") ..
                "[anomal_zone]" ..
                game.translate_string("\n") ..
                "cfg = " ..
                tostring(self.cfg_name_logic_path_field:GetText()) ..
                ".ltx" .. game.translate_string("\n") .. "END" .. game.translate_string("\n")
         end
      elseif type == "inventory_box" then
         if self.check_with_logic:GetCheck() then
            logic = "custom_data = <<END" ..
                game.translate_string("\n") .. "[spawn]" .. game.translate_string("\n") .. "END" ..
                game.translate_string("\n")
         end
      else
         if self.check_with_logic:GetCheck() then
            if tostring(self.cfg_name_hiding_place_field:GetText()) == "" then
               logic = "custom_data = <<END" .. game.translate_string("\n") .. "END" .. game.translate_string("\n")
            else
               logic = "custom_data = <<END" ..
                   game.translate_string("\n") ..
                   "[secret]" ..
                   game.translate_string("\n") ..
                   "name = " ..
                   tostring(self.cfg_name_hiding_place_field:GetText()) ..
                   game.translate_string("\n") .. "END" .. game.translate_string("\n")
            end
         end
      end
      if type == "space_restrictor" then
         if find_in_string(tostring(self.cfg_name_suffix_field:GetText()), "hiding_place") then
            data = game.translate_string("\n") ..
                "[" ..
                allspawn_cfg_counting ..
                "]" ..
                game.translate_string("\n") ..
                "section_name = space_restrictor" ..
                game.translate_string("\n") ..
                "name = " ..
                tostring(self.cfg_name_prefix_field:GetText()) ..
                "_" ..
                tostring(self.cfg_name_suffix_field:GetText()) ..
                game.translate_string("\n") ..
                "position = " ..
                db.actor:position().x ..
                "," ..
                db.actor:position().y ..
                "," ..
                db.actor:position().z ..
                game.translate_string("\n") ..
                "direction = 0,0,0" ..
                game.translate_string("\n") ..
                "version = 128" ..
                game.translate_string("\n") ..
                "script_version = 12" ..
                game.translate_string("\n") ..
                "game_vertex_id = " ..
                db.actor:game_vertex_id() ..
                game.translate_string("\n") ..
                "distance = 0" ..
                game.translate_string("\n") ..
                "level_vertex_id = " ..
                db.actor:level_vertex_id() ..
                game.translate_string("\n") ..
                "object_flags = 0xffffff3e" ..
                game.translate_string("\n") ..
                logic ..
                "shapes = shape0" ..
                game.translate_string("\n") ..
                "shape0:type = sphere" ..
                game.translate_string("\n") ..
                "shape0:offset = 0,0,0" ..
                game.translate_string("\n") ..
                "shape0:radius = " .. allspawn_cfg_radius .. game.translate_string("\n") .. "restrictor_type = 3"
         else
            data = game.translate_string("\n") ..
                "[" ..
                allspawn_cfg_counting ..
                "]" ..
                game.translate_string("\n") ..
                "section_name = space_restrictor" ..
                game.translate_string("\n") ..
                "name = " ..
                tostring(self.cfg_name_prefix_field:GetText()) ..
                "_" ..
                tostring(self.cfg_name_suffix_field:GetText()) ..
                "_" ..
                allspawn_cfg_counting ..
                game.translate_string("\n") ..
                "position = " ..
                db.actor:position().x ..
                "," ..
                db.actor:position().y ..
                "," ..
                db.actor:position().z ..
                game.translate_string("\n") ..
                "direction = 0,0,0" ..
                game.translate_string("\n") ..
                "version = 128" ..
                game.translate_string("\n") ..
                "script_version = 12" ..
                game.translate_string("\n") ..
                "game_vertex_id = " ..
                db.actor:game_vertex_id() ..
                game.translate_string("\n") ..
                "distance = 0" ..
                game.translate_string("\n") ..
                "level_vertex_id = " ..
                db.actor:level_vertex_id() ..
                game.translate_string("\n") ..
                "object_flags = 0xffffff3e" ..
                game.translate_string("\n") ..
                logic ..
                "shapes = shape0" ..
                game.translate_string("\n") ..
                "shape0:type = sphere" ..
                game.translate_string("\n") ..
                "shape0:offset = 0,0,0" ..
                game.translate_string("\n") ..
                "shape0:radius = " .. allspawn_cfg_radius .. game.translate_string("\n") .. "restrictor_type = 3"
         end
      elseif type == "smart_terrain" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = smart_terrain" ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 14" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff3e" ..
             game.translate_string("\n") ..
             logic ..
             "shapes = shape0" ..
             game.translate_string("\n") ..
             "shape0:type = sphere" ..
             game.translate_string("\n") ..
             "shape0:offset = 0,0,0" ..
             game.translate_string("\n") ..
             "shape0:radius = " .. allspawn_cfg_radius .. game.translate_string("\n") .. "restrictor_type = 3"
      elseif type == "anomal_zone" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = anomal_zone" ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 0" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff3e" ..
             game.translate_string("\n") ..
             logic ..
             "shapes = shape0" ..
             game.translate_string("\n") ..
             "shape0:type = sphere" ..
             game.translate_string("\n") ..
             "shape0:offset = 0,0,0" ..
             game.translate_string("\n") ..
             "shape0:radius = " .. allspawn_cfg_radius .. game.translate_string("\n") .. "restrictor_type = 3"
      elseif type == "inventory_box" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = inventory_box" ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 0" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff3f" ..
             game.translate_string("\n") ..
             logic ..
             "visual_name = " ..
             "dynamics\\equipment_cache\\equipment_box_02_case" ..
             game.translate_string("\n") .. "tip = inventory_box_use"
      elseif type == "anomaly" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = " ..
             name ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 4" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff3e" ..
             game.translate_string("\n") ..
             logic ..
             "shapes = shape0" ..
             game.translate_string("\n") ..
             "shape0:type = sphere" ..
             game.translate_string("\n") ..
             "shape0:offset = 0,0,0" ..
             game.translate_string("\n") ..
             "shape0:radius = " ..
             allspawn_cfg_radius ..
             game.translate_string("\n") ..
             "restrictor_type = 3" ..
             game.translate_string("\n") ..
             "max_power = 0" ..
             game.translate_string("\n") ..
             "offline_interactive_radius = 30" ..
             game.translate_string("\n") ..
             "artefact_spawn_count = 32" .. game.translate_string("\n") .. "artefact_position_offset = 0x1320"
      elseif type == "ammo" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = " ..
             name ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 0" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff0f" ..
             game.translate_string("\n") ..
             logic ..
             "visual_name = " ..
             sgm_functions.ReadVisual(name) ..
             game.translate_string("\n") ..
             "condition = 1" ..
             game.translate_string("\n") ..
             "upgrades = " ..
             game.translate_string("\n") ..
             "ammo_left = " .. allspawn_cfg_magazine ..
             game.translate_string("\n") .. "upd:ammo_left = " .. allspawn_cfg_magazine
      elseif type == "outfit" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = " ..
             name ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 0" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff3f" ..
             game.translate_string("\n") ..
             logic ..
             "visual_name = " ..
             sgm_functions.ReadVisual(name) ..
             game.translate_string("\n") ..
             "condition = 1" ..
             game.translate_string("\n") .. "upgrades = " .. game.translate_string("\n") .. "upd:condition = 255"
      elseif type == "weapon" then
         local str_end = "upd:grenade_mode = 0"
         if find_in_string(name, "rg-6") or find_in_string(name, "protecta") or find_in_string(name, "spas12") or find_in_string(name, "toz") or find_in_string(name, "wincheaster") or find_in_string(name, "bm16") or find_in_string(name, "mossberg") or find_in_string(name, "mossberg") then
            str_end = "upd:ammo_ids = 0"
         end
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = " ..
             name ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 0" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff0f" ..
             game.translate_string("\n") ..
             logic ..
             "visual_name = " ..
             sgm_functions.ReadVisual(name) ..
             game.translate_string("\n") ..
             "condition = 1.0" ..
             game.translate_string("\n") ..
             "upgrades = " ..
             game.translate_string("\n") ..
             "ammo_current = 90" ..
             game.translate_string("\n") ..
             "upd:condition = 255" ..
             game.translate_string("\n") ..
             "upd:weapon_flags = 0" ..
             game.translate_string("\n") ..
             "upd:ammo_elapsed = 0" ..
             game.translate_string("\n") ..
             "upd:addon_flags = 0" ..
             game.translate_string("\n") ..
             "upd:ammo_type = 0" ..
             game.translate_string("\n") ..
             "upd:weapon_state = 0" ..
             game.translate_string("\n") ..
             "upd:weapon_zoom = 0" ..
             game.translate_string("\n") .. "upd:current_fire_mode = 0" .. game.translate_string("\n") .. str_end
      elseif type == "grenade" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = " ..
             name ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 0" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff0f" ..
             game.translate_string("\n") ..
             logic ..
             "visual_name = " ..
             sgm_functions.ReadVisual(name) ..
             game.translate_string("\n") .. "condition = 1" .. game.translate_string("\n") .. "upgrades = "
      elseif type == "explosive" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = " ..
             name ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 45.5" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffffbf" ..
             game.translate_string("\n") ..
             logic ..
             "visual_name = " ..
             sgm_functions.ReadVisual(name) ..
             game.translate_string("\n") .. "condition = 1" .. game.translate_string("\n") .. "upgrades = "
      elseif type == "other" then
         data = game.translate_string("\n") ..
             "[" ..
             allspawn_cfg_counting ..
             "]" ..
             game.translate_string("\n") ..
             "section_name = " ..
             name ..
             game.translate_string("\n") ..
             "name = " ..
             tostring(self.cfg_name_prefix_field:GetText()) ..
             "_" ..
             tostring(self.cfg_name_suffix_field:GetText()) ..
             "_" ..
             allspawn_cfg_counting ..
             game.translate_string("\n") ..
             "position = " ..
             db.actor:position().x ..
             "," ..
             db.actor:position().y ..
             "," ..
             db.actor:position().z ..
             game.translate_string("\n") ..
             "direction = 0,0,0" ..
             game.translate_string("\n") ..
             "version = 128" ..
             game.translate_string("\n") ..
             "script_version = 12" ..
             game.translate_string("\n") ..
             "game_vertex_id = " ..
             db.actor:game_vertex_id() ..
             game.translate_string("\n") ..
             "distance = 0" ..
             game.translate_string("\n") ..
             "level_vertex_id = " ..
             db.actor:level_vertex_id() ..
             game.translate_string("\n") ..
             "object_flags = 0xffffff3f" ..
             game.translate_string("\n") ..
             logic ..
             "visual_name = " ..
             sgm_functions.ReadVisual(name) ..
             game.translate_string("\n") .. "condition = 1" .. game.translate_string("\n") .. "upgrades = "
      end
   end
   if data == "" then return data end
   if only_read == true then
      return data
   else
      if self.check_another_mode:GetCheck() then
         debug_to_file("allspawn_another_mode.txt", data)
         create(name, db.actor:position().x, db.actor:position().y, db.actor:position().z, db.actor:level_vertex_id(),
            db.actor:game_vertex_id())
      else
         debug_to_file("allspawn_default_mode.txt", data)
         allspawn_cfg_counting = allspawn_cfg_counting + 1
      end
      allspawn_last_name = name
      allspawn_last_type = type
      allspawn_last_id = id
      --/create(name,db.actor:position().x,db.actor:position().y,db.actor:position().z,db.actor:level_vertex_id(),db.actor:game_vertex_id())
      --/sgm_packet.create_anomaly(name,allspawn_cfg_radius,db.actor:level_vertex_id(),db.actor:game_vertex_id(),nil,"toolkit_place_location")
   end
   return ""
end

function allspawn_editor:btn_close()
   if self.check_button_spawner:GetCheck() == true then
      allspawn_button_active = true
   else
      allspawn_button_active = false
   end
   self:HideDialog()
   set_ui_worked()
   allspawn_cfg_prefix = tostring(self.cfg_name_prefix_field:GetText())
   allspawn_cfg_suffix = tostring(self.cfg_name_suffix_field:GetText())
   if self.cfg_name_logic_path_field:GetText() ~= "" then
      allspawn_cfg_logic_path = tostring(self.cfg_name_logic_path_field:GetText())
   end
   if self.cfg_name_hiding_place_field:GetText() ~= "" then
      allspawn_cfg_hiding_place = tostring(self.cfg_name_hiding_place_field:GetText())
   end
end

function allspawn_editor:btn_read_example()
   if self.stations_list:GetSize() == 0 then return end
   local item = self.stations_list:GetSelectedItem()
   if not item then return end
   local item_name = tostring(item.name:GetText())
   local item_type = tostring(item.type)
   local item_id = tonumber(item.id:GetText())
   run_choose_box("yes", "allspawn_editor", self:check_data_by_id(item_name, item_type, item_id, true))
end

function allspawn_editor:btn_auto_print_activate()
   if allspawn_last_name == "nil" and self:get_currert_selected("name") ~= nil then
      allspawn_last_name = self:get_currert_selected("name")
      allspawn_last_type = self:get_currert_selected("type")
      allspawn_last_id = self:get_currert_selected("id")
   end
   if allspawn_last_name == "nil" then
      run_choose_box("yes", "allspawn_editor", game.translate_string("st_allspawn_auto_print_error"))
      return
   end
   self:btn_close()
   allspawn_auto_print_mode = true
end

function allspawn_editor:btn_auto_print_deactivate()
   sgm_flags.bool_allspawn_auto_print = false
   allspawn_auto_print_mode = false
end

function allspawn_editor_update()
   if allspawn_button_active == true then
      if get_hud():GetCustomStatic("main_task") ~= nil then
         if allspawn_button_action == false then
            allspawn_button_action = true
            allspawn_editor():btn_create()
            give_quick_news(game.translate_string("st_allspawn_auto_print_signal") .. " " .. allspawn_last_name)
         end
      else
         if allspawn_button_action == true then
            allspawn_button_action = false
         end
      end
   end
   local precond = allspawn_auto_print_mode == true and check_ui_worked()
   if precond then
      if sgm_flags.bool_allspawn_auto_print == false then
         sgm_flags.bool_allspawn_auto_print = true
         start_flague_timer("timer_allspawn_auto_print", allspawn_auto_print_delay + 500)
      end
      if sgm_flags.timer_allspawn_auto_print == 0 then
         allspawn_editor():btn_create()
         give_quick_news(game.translate_string("st_allspawn_auto_print_signal") .. " " .. allspawn_last_name)
         start_flague_timer("timer_allspawn_auto_print", allspawn_auto_print_delay)
      end
   end
end

------------------------------------------------------------------------------
--         Отладка позиции ГГ с возможностью ввода комментария              --
------------------------------------------------------------------------------
position_printer_last_comment = ""
class "position_printer" (CUIScriptWnd)
function position_printer:__init(object)
   super()
   self.object = object
   self:InitControls()
   self:InitCallBacks()
end

function position_printer:__finalize()
end

function position_printer:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.position_printer_form = xml:InitStatic("position_printer_form", self)
   self:Register(xml:Init3tButton("position_printer_form:btn_print_pos", self.position_printer_form), "btn_print_pos")
   self:Register(xml:Init3tButton("position_printer_form:btn_close", self.position_printer_form), "btn_close")
   self.position_comment_field = xml:InitEditBox("position_printer_form:position_comment_field",
      self.position_printer_form)
   self:Register(self.position_comment_field, "position_comment_field")
   if self.position_comment_field:GetText() == nil or self.position_comment_field:GetText() == "" then
      self.position_comment_field:SetText(position_printer_last_comment)
   end
end

function position_printer:InitCallBacks()
   self:AddCallback("btn_print_pos", ui_events.BUTTON_CLICKED, self.btn_print_pos, self)
   self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
end

function position_printer:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   end
end

function position_printer:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_close()
      end
   end
   return true
end

function position_printer:btn_print_pos()
   news_manager.send_tip(db.actor, "Комментарий: " .. self.position_comment_field:GetText(), 0, "mutant_hunter", 2000,
      nil, "Позиция снята")
   debug_to_file("printed_points.txt",
      self.object:position().x ..
      "," ..
      self.object:position().y ..
      "," ..
      self.object:position().z ..
      "," ..
      self.object:level_vertex_id() .. "," .. self.object:game_vertex_id() ..
      "  = " .. self.position_comment_field:GetText())
   self:btn_close()
end

function position_printer:btn_close()
   self:HideDialog()
   set_ui_worked()
   position_printer_last_comment = self.position_comment_field:GetText()
end

------------------------------------------------------------------------------
--                       Загрузчик информационных блоков                    --
------------------------------------------------------------------------------
local information_control = nil
class "information_block" (CUIScriptWnd)
function information_block:__init()
   super()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   self.information_mb = CUIMessageBoxEx()
   self:Register(self.information_mb, "information_mb")
   self:AddCallback("information_mb", ui_events.MESSAGE_BOX_OK_CLICKED, self.OnMsgOk, self)
   self:AddCallback("information_mb", ui_events.MESSAGE_BOX_YES_CLICKED, self.OnMsgYes, self)
   self:AddCallback("information_mb", ui_events.MESSAGE_BOX_NO_CLICKED, self.OnMsgNo, self)
end

function information_block:Show(mb_type, reason_type, text, extra_value)
   if mb_type == "yes_or_no" or mb_type == "no_or_yes" then
      self.information_mb:InitMessageBox("message_box_yes_no")
   else
      self.information_mb:InitMessageBox("message_box_ok")
   end
   self.information_mb:SetText(text)
   self.information_mb:ShowDialog(true)
   self.reason_type = reason_type
   if extra_value ~= nil then
      self.extra_value = extra_value
   end
   if reason_type == "level_change" then
      set_ui_disabled()
   end
end

function information_block:OnMsgOk()
   if self.reason_type == "level_change" then
      set_ui_worked()
      sgm_flags.bool_travel_level_change = false
      sgm_flags.bool_throw_level_change = true
   end
   if self.reason_type == "remove_bad_outfit" then
      remove_item_from_slot(db.actor, 7)
   end
   self:block_select()
end

function information_block:OnMsgYes()
   if self.reason_type == "level_change" then
      set_ui_worked()
      sgm_flags.bool_travel_level_change = true
   end
   if self.reason_type == "remove_bad_outfit" then
      remove_item_from_slot(db.actor, 7)
   end
   self:block_select()
end

function information_block:OnMsgNo()
   if self.reason_type == "level_change" then
      set_ui_worked()
      sgm_flags.bool_travel_level_change = false
      sgm_flags.bool_throw_level_change = true
   end
   self:block_select()
end

function information_block:block_select()
end

function information_block_show(mb_type, reason_type, text, extra_value)
   if information_control == nil then
      information_control = ui_mod_elements.information_block()
   end
   information_control:Show(mb_type, reason_type, text, extra_value)
end


------------------------------------------------------------------------------
--                     Регистрация игрока в Sigerous Top                    --
------------------------------------------------------------------------------
sigerous_top_name = ""
sigerous_top_location = ""
sigerous_top_welcome = false
class "sigerous_top" (CUIScriptWnd)
function sigerous_top:__init(object)
   super()
   self.object = object
   self:InitControls()
   self:InitCallBacks()
end

function sigerous_top:__finalize()
end

function sigerous_top:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.sigerous_top_form = xml:InitStatic("sigerous_top_form", self)
   self:start_button(xml, "btn_register")
   self.register_name_field = xml:InitEditBox("sigerous_top_form:register_name_field", self.sigerous_top_form)
   self:Register(self.register_name_field, "register_name_field")
end

function sigerous_top:InitCallBacks()
   self:AddCallback("btn_register", ui_events.BUTTON_CLICKED, self.btn_register, self)
end

function sigerous_top:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   end
   if sigerous_top_welcome == false then
      run_choose_box("yes", "sigerous_top", game.translate_string("st_sigerous_top_1_text"))
      sigerous_top_welcome = true
   end
   if self.register_name_field:GetText() == nil or self.register_name_field:GetText() == "" then
      self.get_btn_register:Show(false)
      self.get_btn_register:Enable(false)
   else
      if (sigerous_top_name == "" and string.len(tostring(self.register_name_field:GetText())) > 2 and string.len(tostring(self.register_name_field:GetText())) <= 10 and find_out_string(tostring(self.register_name_field:GetText()), " ")) then
         self.get_btn_register:Show(true)
         self.get_btn_register:Enable(true)
      elseif (sigerous_top_name ~= "" and string.len(tostring(self.register_name_field:GetText())) > 2 and string.len(tostring(self.register_name_field:GetText())) <= 12 and find_out_string(tostring(self.register_name_field:GetText()), " ")) then
         self.get_btn_register:Show(true)
         self.get_btn_register:Enable(true)
      else
         self.get_btn_register:Show(false)
         self.get_btn_register:Enable(false)
      end
   end
end

function sigerous_top:start_button(xml, button_name)
   self["get_" .. button_name] = xml:Init3tButton("sigerous_top_form:" .. button_name, self.sigerous_top_form)
   self:Register(self["get_" .. button_name], button_name)
end

function sigerous_top:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         --/self:btn_close()
      end
   end
   return true
end

function sigerous_top:btn_register()
   if sigerous_top_name == "" then
      sigerous_top_name = tostring(self.register_name_field:GetText())
      sgm_functions.write_variable("sigerous_top_name", sigerous_top_name)
      run_choose_box("yes", "sigerous_top", game.translate_string("st_sigerous_top_2_text"))
      self.register_name_field:SetText("")
   else
      sigerous_top_location = tostring(self.register_name_field:GetText())
      sgm_functions.write_variable("sigerous_top_location", sigerous_top_location)
      sgm_functions.write_variable("sigerous_top_allowed", "true")
      sigerous_top_update()
      run_choose_box("yes", "sigerous_top", game.translate_string("st_sigerous_top_3_text"))
      self.register_name_field:SetText("")
   end
   if sigerous_top_location ~= "" then
      self:btn_close()
   end
end

function sigerous_top:btn_close()
   self:HideDialog()
   set_ui_worked()
end

---------------------------------//Copyright GeJorge//-----------------------------------------------
