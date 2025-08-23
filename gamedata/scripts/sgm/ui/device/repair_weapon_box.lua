------------------------------------------------------------------------------
--                      Ремкомплект для оружия                              --
------------------------------------------------------------------------------
local repair_weapon_excluded = "pri_a17_gauss_rifle"
class "repair_weapon_box" (CUIScriptWnd)
function repair_weapon_box:__init(owner)
    super()
    self.repair_weapon_slot_1 = db.actor:item_in_slot(2)
    self.repair_weapon_slot_2 = db.actor:item_in_slot(3)
    self.owner = owner
    self:InitControls()
    self:InitCallBacks()
end

function repair_weapon_box:__finalize()
end

function repair_weapon_box:InitControls()
    self:SetWndRect(Frect():set(0, 0, 1024, 768))
    local xml = CScriptXmlInit()
    xml:ParseFile("ui_mod_elements.xml")
    self.repair_wpn_form = xml:InitStatic("repair_wpn_form", self)
    self:Register(xml:Init3tButton("repair_wpn_form:btn_repair", self.repair_wpn_form), "btn_repair")
    self:Register(xml:Init3tButton("repair_wpn_form:btn_close", self.repair_wpn_form), "btn_close")
    self.slot_a_cond = xml:InitStatic("repair_wpn_form:slot_a_cond", self.repair_wpn_form)
    self.slot_b_cond = xml:InitStatic("repair_wpn_form:slot_b_cond", self.repair_wpn_form)
    if self.repair_weapon_slot_1 ~= nil then
        slot_1_cond = string.format(math.floor(self.repair_weapon_slot_1:condition() * 100)) .. "%"
        self.slot_a_cond:TextControl():SetText(slot_1_cond)
    end
    if self.repair_weapon_slot_2 ~= nil then
        slot_2_cond = string.format(math.floor(self.repair_weapon_slot_2:condition() * 100)) .. "%"
        self.slot_b_cond:TextControl():SetText(slot_2_cond)
    end
    self.choose_box = CUIMessageBoxEx()
    self:Register(self.choose_box, "choose_box")
end

function repair_weapon_box:InitCallBacks()
    self:AddCallback("btn_repair", ui_events.BUTTON_CLICKED, self.btn_repair, self)
    self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
    self:AddCallback("choose_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.choose_box_yes, self)
    self:AddCallback("choose_box", ui_events.MESSAGE_BOX_NO_CLICKED, self.choose_box_no, self)
end

function repair_weapon_box:Update()
    CUIScriptWnd.Update(self)
    if not object_alive(db.actor) then
        self:btn_close()
    end
end

function repair_weapon_box:spend_items(item_name, slot)
    for k, v in pairs(self:get_release_items(item_name, slot)) do
        if v ~= nil and alife():object(v) then
            alife():release(alife():object(v), true)
        end
    end
end

function repair_weapon_box:get_release_items(need_item, slot)
    local items_cnt = 0
    local items_collected = {}
    local function relocator(temp, item)
        if item:section() == need_item and items_cnt == 0 and db.actor:item_in_slot(slot) ~= nil and item:id() ~= db.actor:item_in_slot(slot):id() then
            table.insert(items_collected, item:id())
            items_cnt = 1
        end
    end
    db.actor:iterate_inventory(relocator, db.actor)
    return items_collected
end

function repair_weapon_box:check_included_cond(type)
    local exclude_1_result, exclude_2_result = true, true
    if repair_weapon_excluded == "" then return true end
    if type == 1 and self.repair_weapon_slot_1 == nil then return true end
    if type == 2 and self.repair_weapon_slot_2 == nil then return true end
    local exclude_table = utils.parse_spawns(repair_weapon_excluded)
    local exclude_count = get_table_names(exclude_table)
    for k, v in pairs(exclude_table) do
        if type == 1 and find_in_string(self.repair_weapon_slot_1:section(), v.section) then
            exclude_1_result = false
        end
        if type == 2 and find_in_string(self.repair_weapon_slot_2:section(), v.section) then
            exclude_2_result = false
        end
    end
    if type == 1 then
        return exclude_1_result
    elseif type == 2 then
        return exclude_2_result
    end
end

function repair_weapon_box:choose_box_yes()
    local exclude_val = 0
    local passed1_bool = false
    local passed2_bool = false
    if self:check_included_cond(1) then
        if self.repair_weapon_slot_1 and have_item_count(self.repair_weapon_slot_1:section(), 2) then
            self:spend_items(self.repair_weapon_slot_1:section(), 2)
            local slot_1_name = sgm_functions.ReadCaption(self.repair_weapon_slot_1:section())
            local slot_1_conds = string.format(math.floor(self.repair_weapon_slot_1:condition() * 100)) .. "%"
            self.repair_weapon_slot_1:set_condition(1.0)
            news_manager.send_repair(slot_1_name, slot_1_conds)
            passed1_bool = true
        end
    else
        exclude_val = exclude_val + 1
    end
    if self:check_included_cond(2) then
        if self.repair_weapon_slot_2 and have_item_count(self.repair_weapon_slot_2:section(), 2) then
            if have_item_count(self.repair_weapon_slot_2:section(), 2) then
                self:spend_items(self.repair_weapon_slot_2:section(), 3)
                local slot_2_name = sgm_functions.ReadCaption(self.repair_weapon_slot_2:section())
                local slot_2_conds = string.format(math.floor(self.repair_weapon_slot_2:condition() * 100)) .. "%"
                self.repair_weapon_slot_2:set_condition(1.0)
                news_manager.send_repair(slot_2_name, slot_2_conds)
                passed2_bool = true
            end
        end
    else
        exclude_val = exclude_val + 1
    end
    if passed1_bool == false and passed2_bool == false then
        if exclude_val > 0 then
            news_manager.send_tip(db.actor, "st_no_repair", 0, "remont", 4000, nil, "st_no_repair_title")
        elseif self.repair_weapon_slot_1 ~= nil or self.repair_weapon_slot_2 ~= nil then
            news_manager.send_tip(db.actor, "st_no_donor_repair", 0, "remont", 4000, nil, "st_no_repair_title")
        else
            news_manager.send_tip(db.actor, "st_no_repair", 0, "remont", 4000, nil, "st_no_repair_title")
        end
        give_object_to_actor("repair_arms_box")
    elseif passed1_bool == true or passed2_bool == true then
        give_object_to_actor("repair_arms_box_used")
    end
    self.choose_box:ShowDialog(false)
    self.choose_box:HideDialog()
    self:HideDialog()
    game_hide_menu()
end

function repair_weapon_box:choose_box_no()
    local passed1_bool = false
    local passed2_bool = false
    if self:check_included_cond(1) then
        if self.repair_weapon_slot_1 ~= nil then
            local slot_1_name = sgm_functions.ReadCaption(self.repair_weapon_slot_1:section())
            local slot_1_cond = string.format(math.floor(self.repair_weapon_slot_1:condition() * 100)) .. "%"
            news_manager.send_repair(slot_1_name, slot_1_cond)
            self.repair_weapon_slot_1:set_condition(1.0)
            passed1_bool = true
        end
    end
    if self:check_included_cond(2) then
        if self.repair_weapon_slot_2 ~= nil then
            local slot_2_name = sgm_functions.ReadCaption(self.repair_weapon_slot_2:section())
            local slot_2_cond = string.format(math.floor(self.repair_weapon_slot_2:condition() * 100)) .. "%"
            news_manager.send_repair(slot_2_name, slot_2_cond)
            self.repair_weapon_slot_2:set_condition(1.0)
            passed2_bool = true
        end
    end
    if passed1_bool == false and passed2_bool == false then
        give_object_to_actor("repair_arms_box")
        news_manager.send_tip(db.actor, "st_no_repair", 0, "remont", 4000, nil, "st_no_repair_title")
    end
    self.choose_box:ShowDialog(false)
    self.choose_box:HideDialog()
    self:HideDialog()
    game_hide_menu()
end

function repair_weapon_box:OnKeyboard(dik, keyboard_action)
    CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
    if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
        if dik == DIK_keys.DIK_ESCAPE then
            self:btn_close()
        end
    end
    return true
end

function repair_weapon_box:btn_repair()
    self.choose_box:InitMessageBox("mb_choose_weapon_repair")
    self.choose_box:ShowDialog(true)
end

function repair_weapon_box:btn_close()
    self:HideDialog()
    give_object_to_actor("repair_arms_box")
end

class "repair_weapon_box_used" (CUIScriptWnd)
function repair_weapon_box_used:__init(owner)
    super()
    self.repair_weapon_slot_1 = db.actor:item_in_slot(2)
    self.repair_weapon_slot_2 = db.actor:item_in_slot(3)
    self.owner = owner
    self:InitControls()
    self:InitCallBacks()
end

function repair_weapon_box_used:__finalize()
end

function repair_weapon_box_used:InitControls()
    self:SetWndRect(Frect():set(0, 0, 1024, 768))
    local xml = CScriptXmlInit()
    xml:ParseFile("ui_mod_elements.xml")
    self.repair_wpn_form = xml:InitStatic("repair_wpn_form", self)
    self:Register(xml:Init3tButton("repair_wpn_form:btn_repair", self.repair_wpn_form), "btn_repair")
    self:Register(xml:Init3tButton("repair_wpn_form:btn_close", self.repair_wpn_form), "btn_close")
    self.slot_a_cond = xml:InitStatic("repair_wpn_form:slot_a_cond", self.repair_wpn_form)
    self.slot_b_cond = xml:InitStatic("repair_wpn_form:slot_b_cond", self.repair_wpn_form)
    if self.repair_weapon_slot_1 ~= nil then
        slot_1_cond = string.format(math.floor(self.repair_weapon_slot_1:condition() * 100)) .. "%"
        self.slot_a_cond:TextControl():SetText(slot_1_cond)
    end
    if self.repair_weapon_slot_2 ~= nil then
        slot_2_cond = string.format(math.floor(self.repair_weapon_slot_2:condition() * 100)) .. "%"
        self.slot_b_cond:TextControl():SetText(slot_2_cond)
    end
    self.choose_box = CUIMessageBoxEx()
    self:Register(self.choose_box, "choose_box")
end

function repair_weapon_box_used:InitCallBacks()
    self:AddCallback("btn_repair", ui_events.BUTTON_CLICKED, self.btn_repair, self)
    self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
    self:AddCallback("choose_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.choose_box_yes, self)
    self:AddCallback("choose_box", ui_events.MESSAGE_BOX_NO_CLICKED, self.choose_box_no, self)
end

function repair_weapon_box_used:Update()
    CUIScriptWnd.Update(self)
    if not object_alive(db.actor) then
        self:btn_close()
    end
end

function repair_weapon_box_used:spend_items(item_name, slot)
    for k, v in pairs(self:get_release_items(item_name, slot)) do
        if v ~= nil and alife():object(v) then
            alife():release(alife():object(v), true)
        end
    end
end

function repair_weapon_box_used:get_release_items(need_item, slot)
    local items_cnt = 0
    local items_collected = {}
    local function relocator(temp, item)
        if item:section() == need_item and items_cnt == 0 and db.actor:item_in_slot(slot) ~= nil and item:id() ~= db.actor:item_in_slot(slot):id() then
            table.insert(items_collected, item:id())
            items_cnt = 1
        end
    end
    db.actor:iterate_inventory(relocator, db.actor)
    return items_collected
end

function repair_weapon_box_used:check_included_cond(type)
    local exclude_1_result, exclude_2_result = true, true
    if repair_weapon_excluded == "" then return true end
    if type == 1 and self.repair_weapon_slot_1 == nil then return true end
    if type == 2 and self.repair_weapon_slot_2 == nil then return true end
    local exclude_table = utils.parse_spawns(repair_weapon_excluded)
    local exclude_count = get_table_names(exclude_table)
    for k, v in pairs(exclude_table) do
        if type == 1 and find_in_string(self.repair_weapon_slot_1:section(), v.section) then
            exclude_1_result = false
        end
        if type == 2 and find_in_string(self.repair_weapon_slot_2:section(), v.section) then
            exclude_2_result = false
        end
    end
    if type == 1 then
        return exclude_1_result
    elseif type == 2 then
        return exclude_2_result
    end
end

function repair_weapon_box_used:choose_box_yes()
    local exclude_val = 0
    local passed1_bool = false
    local passed2_bool = false
    if self:check_included_cond(1) then
        if self.repair_weapon_slot_1 ~= nil and have_item_count(self.repair_weapon_slot_1:section(), 2) then
            self:spend_items(self.repair_weapon_slot_1:section(), 2)
            local slot_1_name = sgm_functions.ReadCaption(self.repair_weapon_slot_1:section())
            local slot_1_conds = string.format(math.floor(self.repair_weapon_slot_1:condition() * 100)) .. "%"
            self.repair_weapon_slot_1:set_condition(1.0)
            news_manager.send_repair(slot_1_name, slot_1_conds)
            passed1_bool = true
        end
    else
        exclude_val = exclude_val + 1
    end
    if self:check_included_cond(2) then
        if self.repair_weapon_slot_2 ~= nil and have_item_count(self.repair_weapon_slot_2:section(), 2) then
            if have_item_count(self.repair_weapon_slot_2:section(), 2) then
                self:spend_items(self.repair_weapon_slot_2:section(), 3)
                local slot_2_name = sgm_functions.ReadCaption(self.repair_weapon_slot_2:section())
                local slot_2_conds = string.format(math.floor(self.repair_weapon_slot_2:condition() * 100)) .. "%"
                self.repair_weapon_slot_2:set_condition(1.0)
                news_manager.send_repair(slot_2_name, slot_2_conds)
                passed2_bool = true
            end
        end
    else
        exclude_val = exclude_val + 1
    end
    if passed1_bool == false and passed2_bool == false then
        if exclude_val > 0 then
            news_manager.send_tip(db.actor, "st_no_repair", 0, "remont", 4000, nil, "st_no_repair_title")
        elseif self.repair_weapon_slot_1 ~= nil or self.repair_weapon_slot_2 ~= nil then
            news_manager.send_tip(db.actor, "st_no_donor_repair", 0, "remont", 4000, nil, "st_no_repair_title")
        else
            news_manager.send_tip(db.actor, "st_no_repair", 0, "remont", 4000, nil, "st_no_repair_title")
        end
        give_object_to_actor("repair_arms_box_used")
    end
    self.choose_box:ShowDialog(false)
    self.choose_box:HideDialog()
    self:HideDialog()
    game_hide_menu()
end

function repair_weapon_box_used:choose_box_no()
    self.choose_box:ShowDialog(false)
    self.choose_box:HideDialog()
    self:btn_close()
end

function repair_weapon_box_used:OnKeyboard(dik, keyboard_action)
    CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
    if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
        if dik == DIK_keys.DIK_ESCAPE then
            self:btn_close()
        end
    end
    return true
end

function repair_weapon_box_used:btn_repair()
    self.choose_box:InitMessageBox("mb_only_weapon_donor_repair")
    self.choose_box:ShowDialog(true)
end

function repair_weapon_box_used:btn_close()
    self:HideDialog()
    give_object_to_actor("repair_arms_box_used")
end
