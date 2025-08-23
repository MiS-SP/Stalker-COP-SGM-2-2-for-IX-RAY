
------------------------------------------------------------------------------
--                              Армейский таймер                            --
------------------------------------------------------------------------------
army_timer_value = 0
army_timer_deprive = 0
army_timer_active = false
class "army_timer" (CUIScriptWnd)
function army_timer:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function army_timer:__finalize()
end

function army_timer:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.army_timer_form = xml:InitStatic("army_timer_form", self)
   self:Register(xml:Init3tButton("army_timer_form:btn_start", self.army_timer_form), "btn_start")
   self:Register(xml:Init3tButton("army_timer_form:btn_close", self.army_timer_form), "btn_close")
   self:Register(xml:Init3tButton("army_timer_form:btn_stop", self.army_timer_form), "btn_stop")
   self.timer_value = xml:InitStatic("army_timer_form:timer_value", self.army_timer_form)
end

function army_timer:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   end
   if army_timer_active == true then
      army_timer_value = string.format(math.floor(time_global() / 1000)) - army_timer_deprive
   else
      if army_timer_value > 0 then
         army_timer_value = 0
      end
   end
   self.timer_value:TextControl():SetText(army_timer_value)
end

function army_timer:InitCallBacks()
   self:AddCallback("btn_start", ui_events.BUTTON_CLICKED, self.btn_start, self)
   self:AddCallback("btn_stop", ui_events.BUTTON_CLICKED, self.btn_stop, self)
   self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
end

function army_timer:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_close()
      end
   end
   return true
end

function army_timer:btn_start()
   army_timer_active = true
   army_timer_deprive = string.format(math.floor(time_global() / 1000))
end

function army_timer:btn_stop()
   army_timer_active = false
end

function army_timer:btn_close()
   give_object_to_actor("army_timer")
   self:HideDialog()
end
