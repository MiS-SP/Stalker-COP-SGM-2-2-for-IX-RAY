
------------------------------------------------------------------------------
--                           Конвертер для гранат                          --
------------------------------------------------------------------------------
class "conventer_grenade_box" (CUIScriptWnd)
function conventer_grenade_box:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function conventer_grenade_box:__finalize()
end

function conventer_grenade_box:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   local xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.conventer_grenade_form = xml:InitStatic("conventer_grenade_form", self)
   self:Register(xml:Init3tButton("conventer_grenade_form:btn_1_slot", self.conventer_grenade_form), "btn_1_slot")
   self:Register(xml:Init3tButton("conventer_grenade_form:btn_2_slot", self.conventer_grenade_form), "btn_2_slot")
   self:Register(xml:Init3tButton("conventer_grenade_form:btn_3_slot", self.conventer_grenade_form), "btn_3_slot")
   self:Register(xml:Init3tButton("conventer_grenade_form:btn_close", self.conventer_grenade_form), "btn_close")
   self.btn_1_slot_count = xml:InitStatic("conventer_grenade_form:btn_1_slot_count", self.conventer_grenade_form)
   self.btn_2_slot_count = xml:InitStatic("conventer_grenade_form:btn_2_slot_count", self.conventer_grenade_form)
   self.btn_3_slot_count = xml:InitStatic("conventer_grenade_form:btn_3_slot_count", self.conventer_grenade_form)
   self.btn_spare_count = xml:InitStatic("conventer_grenade_form:btn_spare_count", self.conventer_grenade_form)
   self.form_title = xml:InitStatic("conventer_grenade_form:form_title", self.conventer_grenade_form)
   self.need_spare_box = CUIMessageBoxEx()
   self:Register(self.need_spare_box, "need_spare_box")
   self.need_grenade_box = CUIMessageBoxEx()
   self:Register(self.need_grenade_box, "need_grenade_box")
end

function conventer_grenade_box:InitCallBacks()
   self:AddCallback("btn_1_slot", ui_events.BUTTON_CLICKED, self.btn_1_slot, self)
   self:AddCallback("btn_2_slot", ui_events.BUTTON_CLICKED, self.btn_2_slot, self)
   self:AddCallback("btn_3_slot", ui_events.BUTTON_CLICKED, self.btn_3_slot, self)
   self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
   self:AddCallback("need_spare_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.need_spare_box_ok, self)
   self:AddCallback("need_spare_box", ui_events.MESSAGE_BOX_OK_CLICKED, self.need_spare_box_ok, self)
   self:AddCallback("need_grenade_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.need_grenade_box_ok, self)
   self:AddCallback("need_grenade_box", ui_events.MESSAGE_BOX_OK_CLICKED, self.need_grenade_box_ok, self)
end

function conventer_grenade_box:need_spare_box_ok()
   self.need_spare_box:ShowDialog(false)
   self.need_spare_box:HideDialog()
end

function conventer_grenade_box:need_grenade_box_ok()
   self.need_grenade_box:ShowDialog(false)
   self.need_grenade_box:HideDialog()
end

function conventer_grenade_box:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_close()
   end
   self.form_title:TextControl():SetText(game.translate_string("st_conventer_grenade_title"))
   self.btn_1_slot_count:TextControl():SetText(get_item_count("grenade_rgd5"))
   self.btn_2_slot_count:TextControl():SetText(get_item_count("grenade_f1"))
   self.btn_3_slot_count:TextControl():SetText(get_item_count("grenade_gd-05"))
end

function conventer_grenade_box:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_close()
      end
   end
   return true
end

function conventer_grenade_box:btn_1_slot()
   if get_item_count("grenade_rgd5") < 2 then
      self.need_grenade_box:InitMessageBox("mb_need_rgd5_box")
      self.need_grenade_box:ShowDialog(true)
   else
      self:spend_granades("grenade_rgd5")
      self:HideDialog()
   end
end

function conventer_grenade_box:btn_2_slot()
   if get_item_count("grenade_f1") < 2 then
      self.need_grenade_box:InitMessageBox("mb_need_f1_box")
      self.need_grenade_box:ShowDialog(true)
   else
      self:spend_granades("grenade_f1")
      self:HideDialog()
   end
end

function conventer_grenade_box:btn_3_slot()
   if get_item_count("grenade_gd-05") < 2 then
      self.need_grenade_box:InitMessageBox("mb_need_gd05_box")
      self.need_grenade_box:ShowDialog(true)
   else
      self:spend_granades("grenade_gd-05")
      self:HideDialog()
   end
end

function conventer_grenade_box:spend_granades(granade_name)
   for k, v in pairs(self:get_release_granades(granade_name)) do
      if v ~= nil and alife():object(v) then
         alife():release(alife():object(v), true)
      end
   end
   give_object_to_actor(granade_name .. "_double")
end

function conventer_grenade_box:get_release_granades(granade_name)
   local item_cnt = 0
   local item_collected = {}
   local function calc(temp, item)
      if item:section() == granade_name then
         if item_cnt == 0 then
            item_cnt = 1
            table.insert(item_collected, item:id())
         elseif item_cnt == 1 then
            item_cnt = 2
            table.insert(item_collected, item:id())
         end
      end
   end
   db.actor:iterate_inventory(calc, db.actor)
   return item_collected
end

function conventer_grenade_box:btn_close()
   give_object_to_actor("conventer_grenade_box")
   self:HideDialog()
end
