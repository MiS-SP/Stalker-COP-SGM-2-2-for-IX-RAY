
------------------------------------------------------------------------------
--                            Персональный маяк                             --
------------------------------------------------------------------------------
class "personal_marker" (CUIScriptWnd)
function personal_marker:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function personal_marker:__finalize()
end

function personal_marker:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.personal_marker_form = xml:InitStatic("personal_marker_form", self)
   self:Register(xml:Init3tButton("personal_marker_form:btn_setup", self.personal_marker_form), "btn_setup")
   self:Register(xml:Init3tButton("personal_marker_form:btn_radius_hide", self.personal_marker_form), "btn_radius_hide")
   self:Register(xml:Init3tButton("personal_marker_form:btn_all_hide", self.personal_marker_form), "btn_all_hide")
   self:Register(xml:Init3tButton("personal_marker_form:btn_cancel", self.personal_marker_form), "btn_cancel")
   self.enter_field = xml:InitEditBox("personal_marker_form:enter_field", self.personal_marker_form)
   self:Register(self.enter_field, "enter_field")
end

function personal_marker:InitCallBacks()
   self:AddCallback("btn_setup", ui_events.BUTTON_CLICKED, self.btn_setup, self)
   self:AddCallback("btn_radius_hide", ui_events.BUTTON_CLICKED, self.btn_radius_hide, self)
   self:AddCallback("btn_all_hide", ui_events.BUTTON_CLICKED, self.btn_all_hide, self)
   self:AddCallback("btn_cancel", ui_events.BUTTON_CLICKED, self.btn_cancel, self)
end

function personal_marker:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_cancel()
      end
   end
   return true
end

function personal_marker:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_cancel()
   end
end

function personal_marker:btn_setup()
   local sobj = alife():create("personal_marker", db.actor:position(), db.actor:level_vertex_id(),
      db.actor:game_vertex_id())
   if exists(self.enter_field:GetText()) and self.enter_field:GetText() ~= "" then
      add_spot_on_map(sobj.id, sgm_flags.spot_map_marker, self.enter_field:GetText())
   else
      add_spot_on_map(sobj.id, sgm_flags.spot_map_marker, "st_personal_marker_name")
   end
   self:HideDialog()
end

function personal_marker:btn_radius_hide()
   hide_radius_spot_by_section("personal_marker", sgm_flags.spot_map_marker, 100)
end

function personal_marker:btn_all_hide()
   hide_spot_by_section("personal_marker", sgm_flags.spot_map_marker)
end

function personal_marker:btn_cancel()
   give_object_to_actor("personal_marker")
   self:HideDialog()
end