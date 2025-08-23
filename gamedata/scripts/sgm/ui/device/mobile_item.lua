---==================================================================================================---
--------------------------------------------------------------------------------------------------------
---------------------------------------------(Утилиты)--------------------------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---

local _M = {}

function _M.read_boolean(section, param, ini_path)
   local ltx_ini = system_ini()
   if ini_path ~= nil and ini_path ~= "nil" then
      ltx_ini = ini_file(ini_path)
   end
   if ltx_ini:line_exist(section, param) then
      return ltx_ini:r_bool(section, param)
   else
      return "nil"
   end
end
------------------------------------------------------------------------------
--                         Портативный архив                                --
------------------------------------------------------------------------------
local mobile_tool_target_title = "Предмет не выбран"
local mobile_tool_items = {}
local mobile_tool_available = 0
local mobile_tool_universal = true
class "mobile_item" (CUIListBoxItem)
function mobile_item:__init(height)
   super(height)
   self.title = self:GetTextItem()
   self:SetTextColor(GetARGB(255, 210, 210, 210))
   self.title:SetFont(GetFontLetterica18Russian())
   self.title:SetWndSize(vector2():set(249, height))
   self.title:SetEllipsis(true)
end

class "mobile_tool" (CUIScriptWnd)
function mobile_tool:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
   if mobile_tool_universal == true then
      self:find_all_items()
   else
      self:find_available_items()
      self:FillList(mobile_tool_items)
   end
end

function mobile_tool:__finalize()
end

function mobile_tool:FillList(list)
   self.available_items_list:Clear()
   for k, v in pairs(list) do
      if v ~= nil then
         self:AddItemToList(v.title, v.section, v.id)
      end
   end
end

function mobile_tool:AddItemToList(title, section, id)
   local source = mobile_item(22)
   source.title:SetText(game.translate_string(title))
   self.available_items_list:AddExistingItem(source)
   source.section = section
   source.id = id
   --/source.title:SetWndPos(vector2():set(50,0))
end

function mobile_tool:find_available_items()
   local function calc(temp, item)
      if find_out_string(item:section(), "_knife") and find_out_string(item:section(), "_binoc") and (find_in_string(item:section(), "outfit") or find_in_string(item:section(), "helm") or find_in_string(item:section(), "wpn_")) then
         mobile_tool_items[item:section()] = {}
         mobile_tool_items[item:section()].title = sgm_functions.ReadCaption(item:section())
         mobile_tool_items[item:section()].section = item:section()
         mobile_tool_items[item:section()].id = item:id()
         mobile_tool_available = mobile_tool_available + 1
      end
   end
   db.actor:iterate_inventory(calc, db.actor)
end

function mobile_tool:find_all_items()
   self:FillListUn(allspawn_sections_panel_3)
end

function mobile_tool:FillListUn(list)
   self.available_items_list:Clear()
   for k, v in pairs(list) do
      if v ~= nil then
         self:AddItemToList(sgm_functions.ReadCaption(v.name), v.name, v.id)
         mobile_tool_available = mobile_tool_available + 1
      end
   end
end

function mobile_tool:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.mobile_tool_form = xml:InitStatic("mobile_tool_form", self)
   self:Register(xml:Init3tButton("mobile_tool_form:btn_close", self.mobile_tool_form), "btn_close")
   self:Register(xml:Init3tButton("mobile_tool_form:tab_1", self.mobile_tool_form), "tab_1")
   self:Register(xml:Init3tButton("mobile_tool_form:tab_2", self.mobile_tool_form), "tab_2")
   self:Register(xml:Init3tButton("mobile_tool_form:tab_3", self.mobile_tool_form), "tab_3")
   self:Register(xml:Init3tButton("mobile_tool_form:tab_4", self.mobile_tool_form), "tab_4")
   self.f_selected_item = xml:InitStatic("mobile_tool_form:f_selected_item", self.mobile_tool_form)
   self.selected_item_icon = xml:InitStatic("mobile_tool_form:selected_item_icon", self.mobile_tool_form)
   self.params_field = xml:InitStatic("mobile_tool_form:params_field", self.mobile_tool_form)
   self.available_items_list = xml:InitListBox("mobile_tool_form:available_items_list", self)
   self.available_items_list:ShowSelectedItem(true)
   self:Register(self.available_items_list, "available_items_list_window")
end

function mobile_tool:InitCallBacks()
   self:AddCallback("tab_1", ui_events.BUTTON_CLICKED, self.enter_tab_1, self)
   self:AddCallback("tab_2", ui_events.BUTTON_CLICKED, self.enter_tab_2, self)
   self:AddCallback("tab_3", ui_events.BUTTON_CLICKED, self.enter_tab_3, self)
   self:AddCallback("tab_4", ui_events.BUTTON_CLICKED, self.enter_tab_4, self)
   self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
   self:AddCallback("available_items_list_window", ui_events.WINDOW_LBUTTON_DB_CLICK, self.btn_select, self)
end

function mobile_tool:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   end
   if self.f_selected_item:TextControl():GetText() ~= mobile_tool_target_title then
      self.f_selected_item:TextControl():SetText(mobile_tool_target_title)
   end
end

function mobile_tool:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_close()
      end
   end
   return true
end

function mobile_tool:btn_close()
   self:HideDialog()
   set_ui_worked()
   mobile_tool_items = nil
   mobile_tool_items = {}
   mobile_tool_available = 0
   mobile_tool_target_title = "Предмет не выбран"
   give_object_to_actor("mobile_tool")
   set_ui_worked()
   level.show_weapon(true)
end

function mobile_tool:btn_select()
   if self.available_items_list:GetSize() == 0 then return end
   local item = self.available_items_list:GetSelectedItem()
   if not item then return end
   local item_title = item.title:GetText()
   mobile_tool_target_title = game.translate_string(item_title)
   CUI_show_item_icon(self.selected_item_icon, item.section)
   --/self.params_field:TextControl():SetText(self:get_obj_params(item.section))
   self.params_field:TextControl():SetText(game.translate_string(sgm_functions.ReadDescription(item.section)))
end

function mobile_tool:get_weapon_ammo_slots(section)
   local ammo_s = sgm_functions.check_section_comma(system_ini(), section, "ammo_class", nil, 5)
   if ammo_s[5] ~= nil then
      return game.translate_string(tostring(ammo_s[1])) ..
          ", " ..
          game.translate_string(tostring(ammo_s[2])) ..
          ", " ..
          game.translate_string(tostring(ammo_s[3])) ..
          ", " .. game.translate_string(tostring(ammo_s[4])) .. ", " .. game.translate_string(tostring(ammo_s[5]))
   elseif ammo_s[4] ~= nil then
      return game.translate_string(tostring(ammo_s[1])) ..
          ", " ..
          game.translate_string(tostring(ammo_s[2])) ..
          ", " .. game.translate_string(tostring(ammo_s[3])) .. ", " .. game.translate_string(tostring(ammo_s[4]))
   elseif ammo_s[3] ~= nil then
      return game.translate_string(tostring(ammo_s[1])) ..
          ", " .. game.translate_string(tostring(ammo_s[2])) .. ", " .. game.translate_string(tostring(ammo_s[3]))
   elseif ammo_s[2] ~= nil then
      return game.translate_string(tostring(ammo_s[1])) .. ", " .. game.translate_string(tostring(ammo_s[2]))
   elseif ammo_s[1] ~= nil then
      return game.translate_string(tostring(ammo_s[1]))
   end
end

function mobile_tool:get_weapon_addons(section, type)
   local sc_s = read_number(section, "scope_status")
   local sl_s = read_number(section, "silencer_status")
   local gl_s = read_number(section, "grenade_launcher_status")
   if type == "sc" then
      if sc_s == 0 then
         return "нет"
      elseif sc_s == 1 then
         return "уже"
      elseif sc_s == 2 then
         return "да"
      end
   elseif type == "sl" then
      if sl_s == 0 then
         return "нет"
      elseif sl_s == 1 then
         return "уже"
      elseif sl_s == 2 then
         return "да"
      end
   elseif type == "gl" then
      if gl_s == 0 then
         return "нет"
      elseif gl_s == 1 then
         return "уже"
      elseif gl_s == 2 then
         return "да"
      end
   end
end

function mobile_tool:get_helm_antigas(section)
   local ha_s = _M.read_boolean(section, "has_antigas")
   if ha_s == true then
      return "да"
   else
      return "нет"
   end
end

function mobile_tool:get_night_vision(section)
   local hn_s = read_string(section, "nightvision_sect")
   if hn_s == "effector_nightvision_1" then
      return "уровень 1"
   elseif hn_s == "effector_nightvision_2" then
      return "уровень 2"
   elseif hn_s == "effector_nightvision_3" then
      return "уровень 3"
   else
      return "отсутствует"
   end
end

function mobile_tool:get_obj_params(section)
   local obj_params
   if sgm_functions.ReadWeaponType(section) ~= "unknown" and sgm_functions.ReadWeaponType(section) ~= "grenade" then
      local w_type = "Тип оружия =" .. " " .. sgm_functions.ReadWeaponType(section)
      local w_ammo = "Боеприпасы =" .. " " .. self:get_weapon_ammo_slots(section)
      local w_sc = "Установка оптического прицела =" .. " " .. self:get_weapon_addons(section, "sc")
      local w_sl = "Установка глушителя =" .. " " .. self:get_weapon_addons(section, "sl")
      local w_gl = "Установка подствольного гранатомета =" .. " " .. self:get_weapon_addons(section, "gl")
      local w_sb = "Книга навыка =" ..
          " " .. game.translate_string(sgm_functions.ReadCaption(read_string(section, "increasing_skill_info")))
      local w_sd = "Бонус книги навыка =" .. " " .. read_number(section, "increasing_skill_point")
      local w_cs = "Износ при стрельбе =" .. " " .. read_number(section, "condition_shot_dec")
      obj_params = w_type ..
          game.translate_string("; ") ..
          w_ammo ..
          game.translate_string("; ") ..
          w_sc ..
          game.translate_string("; ") ..
          w_sl ..
          game.translate_string("; ") ..
          w_gl .. game.translate_string("; ") .. w_sb .. game.translate_string("; ") ..
          w_sd .. game.translate_string("; ") .. w_cs
   elseif sgm_functions.ReadOutfitType(section) ~= "unknown" then
      local o_type = "Тип бронекостюма =" .. " " .. sgm_functions.ReadOutfitType(section)
      local o_pl = "Коэфициент траты сил на передвижение в костюме =" .. " " .. read_number(section, "power_loss")
      local o_ha = "Внутренний противогаз =" .. " " .. self:get_helm_antigas(section)
      obj_params = o_type .. game.translate_string("; ") .. o_pl .. game.translate_string("; ") .. o_ha
   elseif sgm_functions.ReadHelmType(section) ~= "unknown" then
      local h_type = "Тип защитного шлема =" .. " " .. sgm_functions.ReadHelmType(section)
      local h_hn = "Внутренний ПНВ =" .. " " .. self:get_night_vision(section)
      obj_params = h_type .. game.translate_string("; ") .. h_hn
   else
      obj_params = ""
   end
   return obj_params
end

function mobile_tool:enter_tab_1()
   self:FillListUn(allspawn_sections_panel_3)
end

function mobile_tool:enter_tab_2()
   self:FillListUn(allspawn_sections_panel_4)
end

function mobile_tool:enter_tab_3()
   self:FillListUn(allspawn_sections_panel_5)
end

function mobile_tool:enter_tab_4()
   self:FillListUn(allspawn_sections_panel_6)
end