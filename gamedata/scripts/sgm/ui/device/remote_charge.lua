
------------------------------------------------------------------------------
--                             Заряд РС-15                                  --
------------------------------------------------------------------------------
cfg_remote_charge_delay = 0
class "remote_charge" (CUIScriptWnd)
function remote_charge:__init(owner)
   super()
   cfg_remote_charge_delay = 0
   self.remote_charge_delay = 0
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function remote_charge:__finalize()
end

function remote_charge:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.remote_charge_form = xml:InitStatic("remote_charge_form", self)
   self:Register(xml:Init3tButton("remote_charge_form:btn_place", self.remote_charge_form), "btn_place")
   self:Register(xml:Init3tButton("remote_charge_form:btn_cancel", self.remote_charge_form), "btn_cancel")
   self:Register(xml:Init3tButton("remote_charge_form:btn_charge_delay_dec", self.remote_charge_form),
      "btn_charge_delay_dec")
   self:Register(xml:Init3tButton("remote_charge_form:btn_charge_delay_inc", self.remote_charge_form),
      "btn_charge_delay_inc")
   self.charge_delay_field = xml:InitStatic("remote_charge_form:charge_delay_field", self.remote_charge_form)
end

function remote_charge:InitCallBacks()
   self:AddCallback("btn_place", ui_events.BUTTON_CLICKED, self.btn_place, self)
   self:AddCallback("btn_cancel", ui_events.BUTTON_CLICKED, self.btn_cancel, self)
   self:AddCallback("btn_charge_delay_dec", ui_events.BUTTON_CLICKED, self.btn_charge_delay_dec, self)
   self:AddCallback("btn_charge_delay_inc", ui_events.BUTTON_CLICKED, self.btn_charge_delay_inc, self)
end

function remote_charge:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_cancel()
      end
   end
   return true
end

function remote_charge:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_cancel()
   end
   if self.remote_charge_delay < 0 then
      self.remote_charge_delay = 0
   end
   if self.remote_charge_delay == 0 then
      self.charge_delay_field:TextControl():SetText(game.translate_string("st_remote_charge_delay_deactivated"))
   else
      local charge_delay = self.remote_charge_delay / 1000
      self.charge_delay_field:TextControl():SetText(game.translate_string("st_remote_charge_delay_timer") ..
         " " .. charge_delay .. " " .. game.translate_string("st_remote_charge_delay_value"))
   end
end

function remote_charge:btn_charge_delay_dec()
   self.remote_charge_delay = self.remote_charge_delay - 1000
end

function remote_charge:btn_charge_delay_inc()
   self.remote_charge_delay = self.remote_charge_delay + 1000
end

function remote_charge:btn_place()
   cfg_remote_charge_delay = self.remote_charge_delay
   local obj = create("remote_charge", db.actor:position().x, db.actor:position().y, db.actor:position().z,
      db.actor:level_vertex_id(), db.actor:game_vertex_id())
   if self.remote_charge_delay == 0 then
      add_spot_on_map(obj.id, sgm_flags.spot_remote_charge, "st_remote_charge_spot")
   else
      local charge_delay = self.remote_charge_delay / 1000
      add_spot_on_map(obj.id, sgm_flags.spot_remote_charge,
         game.translate_string("st_remote_charge_spot") ..
         ": " .. charge_delay .. " " .. game.translate_string("st_remote_charge_delay_value"))
   end
   check_actor_item_to_add("remote_charge_control")
   self:HideDialog()
end

function remote_charge:btn_cancel()
   give_object_to_actor("remote_explosive_charge")
   self:HideDialog()
end