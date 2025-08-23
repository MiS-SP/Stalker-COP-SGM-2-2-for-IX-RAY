
------------------------------------------------------------------------------
--                          Персональный рюкзак                             --
------------------------------------------------------------------------------
class "personal_rukzak" (CUIScriptWnd)
function personal_rukzak:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function personal_rukzak:__finalize()
end

function personal_rukzak:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.personal_rukzak_form = xml:InitStatic("personal_rukzak_form", self)
   self:Register(xml:Init3tButton("personal_rukzak_form:btn_leave", self.personal_rukzak_form), "btn_leave")
   self:Register(xml:Init3tButton("personal_rukzak_form:btn_radius_hide", self.personal_rukzak_form), "btn_radius_hide")
   self:Register(xml:Init3tButton("personal_rukzak_form:btn_all_hide", self.personal_rukzak_form), "btn_all_hide")
   self:Register(xml:Init3tButton("personal_rukzak_form:btn_cancel", self.personal_rukzak_form), "btn_cancel")
   self.spot_name_field = xml:InitEditBox("personal_rukzak_form:spot_name_field", self.personal_rukzak_form)
   self:Register(self.spot_name_field, "spot_name_field")
   self.check_with_spot = xml:InitCheck("personal_rukzak_form:check_with_spot", self.personal_rukzak_form)
   self.check_with_spot:SetCheck(true)
   self.check_with_take = xml:InitCheck("personal_rukzak_form:check_with_take", self.personal_rukzak_form)
   self.check_with_take:SetCheck(true)
end

function personal_rukzak:InitCallBacks()
   self:AddCallback("btn_leave", ui_events.BUTTON_CLICKED, self.btn_leave, self)
   self:AddCallback("btn_radius_hide", ui_events.BUTTON_CLICKED, self.btn_radius_hide, self)
   self:AddCallback("btn_all_hide", ui_events.BUTTON_CLICKED, self.btn_all_hide, self)
   self:AddCallback("btn_cancel", ui_events.BUTTON_CLICKED, self.btn_cancel, self)
end

function personal_rukzak:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_cancel()
   end
end

function personal_rukzak:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_cancel()
      end
   end
   return true
end

function personal_rukzak:btn_leave()
   if self.check_with_spot:GetCheck() == true then
      local sobj = create("default_inventory_box", db.actor:position().x, db.actor:position().y, db.actor:position().z,
         db.actor:level_vertex_id(), db.actor:game_vertex_id())
      if exists(self.spot_name_field:GetText()) and self.spot_name_field:GetText() ~= "" then
         add_spot_on_map(sobj.id, sgm_flags.spot_hero_rucksack, self.spot_name_field:GetText())
      else
         add_spot_on_map(sobj.id, sgm_flags.spot_hero_rucksack, "st_treasure_rukzak_name")
      end
      if self.check_with_take:GetCheck() == true then
         alife():create("use_personal_rukzak", vector(), 0, 0, sobj.id)
      end
   else
      local sobj = create("default_inventory_box", db.actor:position().x, db.actor:position().y, db.actor:position().z,
         db.actor:level_vertex_id(), db.actor:game_vertex_id())
      if self.check_with_take:GetCheck() == true then
         alife():create("use_personal_rukzak", vector(), 0, 0, sobj.id)
      end
   end
   self:HideDialog()
end

function personal_rukzak:btn_radius_hide()
   hide_radius_spot_by_section("default_inventory_box", sgm_flags.spot_hero_rucksack, 100)
end

function personal_rukzak:btn_all_hide()
   hide_spot_by_section("default_inventory_box", sgm_flags.spot_hero_rucksack)
end

function personal_rukzak:btn_cancel()
   give_object_to_actor("personal_rukzak")
   self:HideDialog()
end
