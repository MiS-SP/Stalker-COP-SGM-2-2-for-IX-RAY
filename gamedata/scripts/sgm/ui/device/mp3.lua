------------------------------------------------------------------------------
--                                 МП-3 плеер                               --
------------------------------------------------------------------------------
class "mp3_snd" (CUIListBoxItem)
function mp3_snd:__init(height)
    super(height)
    self.title = self:GetTextItem()
    self:SetTextColor(GetARGB(255, 210, 210, 210))
    self.title:SetFont(GetFontLetterica18Russian())
    self.title:SetWndSize(vector2():set(278, height))
    self.title:SetEllipsis(true)
end

class "mp3_player" (CUIScriptWnd)
function mp3_player:__init(owner)
    super()
    self.owner = owner
    self:InitControls()
    self:InitCallBacks()
    if mp3_player_section == 1 then
        self:FillList(mp3_table_merry)
    elseif mp3_player_section == 2 then
        self:FillList(mp3_table_dance)
    elseif mp3_player_section == 3 then
        self:FillList(mp3_table_theme)
    elseif mp3_player_section == 4 then
        self:FillList(mp3_table_other)
    elseif mp3_player_section == 5 then
        self:FillList(mp3_table_bonus)
    end
end

function mp3_player:__finalize()
end

function mp3_player:FillList(list)
    self.mp3_list:Clear()
    for k, v in pairs(list) do
        if v.precond == nil or (v.precond ~= nil and has_alife_info(v.precond)) then
            self:AddItemToList(v.title, v.sound, v.author)
        end
    end
    mp3_chosen_list = list
end

function mp3_player:AddItemToList(title, sound, author)
    local source = mp3_snd(22)
    source.title:SetText(title)
    self.mp3_list:AddExistingItem(source)
    if string.len(author) > 34 then
        author = string.sub(author, 1, 34)
    end
    if author == "-" then
        source.author = source:AddIconField(0)
        source.author:InitTexture("ui_mod_red_plate")
        source.author:SetWndPos(vector2():set(120, 6))
    else
        source.author = source:AddTextField(author, 0)
        source.author:SetWndPos(vector2():set(120, 0))
    end
    source.length = source:AddTextField(self:get_sound_length(sound_object(sound)), 0)
    source.length:SetWndPos(vector2():set(430, 0))
end

function mp3_player:InitControls()
    self:SetWndRect(Frect():set(0, 0, 1024, 768))
    local xml = CScriptXmlInit()
    xml:ParseFile("ui_mod_elements.xml")
    self.mp3_player_form = xml:InitStatic("mp3_player_form", self)
    self:Register(xml:Init3tButton("mp3_player_form:btn_dance", self.mp3_player_form), "btn_dance")
    self:Register(xml:Init3tButton("mp3_player_form:btn_merry", self.mp3_player_form), "btn_merry")
    self:Register(xml:Init3tButton("mp3_player_form:btn_bonus", self.mp3_player_form), "btn_bonus")
    self:Register(xml:Init3tButton("mp3_player_form:btn_theme", self.mp3_player_form), "btn_theme")
    self:Register(xml:Init3tButton("mp3_player_form:btn_other", self.mp3_player_form), "btn_other")
    self:Register(xml:Init3tButton("mp3_player_form:btn_play", self.mp3_player_form), "btn_play")
    self:Register(xml:Init3tButton("mp3_player_form:btn_close", self.mp3_player_form), "btn_close")
    self:Register(xml:Init3tButton("mp3_player_form:btn_stop", self.mp3_player_form), "btn_stop")
    self:Register(xml:Init3tButton("mp3_player_form:btn_volume_minus", self.mp3_player_form), "btn_volume_minus")
    self:Register(xml:Init3tButton("mp3_player_form:btn_volume_plus", self.mp3_player_form), "btn_volume_plus")
    self.volume_number = xml:InitStatic("mp3_player_form:volume_number", self.mp3_player_form)
    self.repeat_check = xml:InitCheck("mp3_player_form:check_repeat", self.mp3_player_form)
    self.repeat_check:SetCheck(sgm_functions.info_get_boolean("mp3_player_repeat"))
    self.queue_check = xml:InitCheck("mp3_player_form:check_queue", self.mp3_player_form)
    self.queue_check:SetCheck(sgm_functions.info_get_boolean("mp3_player_queue"))
    self.mp3_red_diode = xml:InitStatic("mp3_player_form:mp3_red_diode", self.mp3_player_form)
    self.mp3_green_diode = xml:InitStatic("mp3_player_form:mp3_green_diode", self.mp3_player_form)
    self.mp3_info = xml:InitStatic("mp3_player_form:mp3_info", self.mp3_player_form)
    self.mp3_timer = xml:InitStatic("mp3_player_form:mp3_timer", self.mp3_player_form)
    self.mp3_list = xml:InitListBox("mp3_player_form:mp3_list", self)
    self.mp3_list:ShowSelectedItem(true)
    self:Register(self.mp3_list, "mp3_list_window")
end

function mp3_player:InitCallBacks()
    self:AddCallback("btn_merry", ui_events.BUTTON_CLICKED, self.btn_merry, self)
    self:AddCallback("btn_dance", ui_events.BUTTON_CLICKED, self.btn_dance, self)
    self:AddCallback("btn_bonus", ui_events.BUTTON_CLICKED, self.btn_bonus, self)
    self:AddCallback("btn_theme", ui_events.BUTTON_CLICKED, self.btn_theme, self)
    self:AddCallback("btn_other", ui_events.BUTTON_CLICKED, self.btn_other, self)
    self:AddCallback("btn_play", ui_events.BUTTON_CLICKED, self.btn_play, self)
    self:AddCallback("btn_stop", ui_events.BUTTON_CLICKED, self.btn_stop, self)
    self:AddCallback("btn_close", ui_events.BUTTON_CLICKED, self.btn_close, self)
    self:AddCallback("mp3_list_window", ui_events.WINDOW_LBUTTON_DB_CLICK, self.btn_play, self)
    self:AddCallback("btn_volume_minus", ui_events.BUTTON_CLICKED, self.btn_volume_minus, self)
    self:AddCallback("btn_volume_plus", ui_events.BUTTON_CLICKED, self.btn_volume_plus, self)
end

function mp3_player:Update()
    CUIScriptWnd.Update(self)
    if not object_alive(db.actor) then
        self:btn_close()
    end
    if read_mod_param("mp3_currert_volume") ~= nil then
        self.volume_number:TextControl():SetText(string.format(math.floor(read_mod_param("mp3_currert_volume") * 100)))
    end
    if self.mp3_info:TextControl():GetText() ~= mp3_info then
        self.mp3_info:TextControl():SetText(mp3_info)
    end
    if mp3_info == "" then
        self.mp3_green_diode:Show(false)
    else
        self.mp3_green_diode:Show(true)
    end
    if mp3_info ~= "" then
        self.mp3_timer:TextControl():SetText(self:get_sound_length(nil, mp3_length_position))
    else
        self.mp3_timer:TextControl():SetText("")
    end
    self:check_config_update()
end

function mp3_player:OnKeyboard(dik, keyboard_action)
    CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
    if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
        if dik == DIK_keys.DIK_ESCAPE then
            self:btn_close()
        end
    end
    return true
end

function mp3_player:check_config_update()
    if self.repeat_check:GetCheck() then
        self.queue_check:Enable(false)
    else
        self.queue_check:Enable(true)
    end
    if self.queue_check:GetCheck() then
        self.repeat_check:Enable(false)
    else
        self.repeat_check:Enable(true)
    end
    sgm_functions.info_give_on_boolean(self.repeat_check:GetCheck(), "mp3_player_repeat")
    sgm_functions.info_give_on_boolean(self.queue_check:GetCheck(), "mp3_player_queue")
end

function mp3_player:btn_volume_minus()
    write_mod_param("mp3_currert_volume", read_mod_param("mp3_currert_volume") - mp3_add_value)
    if mp3_obj ~= nil then
        mp3_obj.volume = read_mod_param("mp3_currert_volume")
    end
end

function mp3_player:btn_volume_plus()
    write_mod_param("mp3_currert_volume", read_mod_param("mp3_currert_volume") + mp3_add_value)
    if mp3_obj ~= nil then
        mp3_obj.volume = read_mod_param("mp3_currert_volume")
    end
end

function mp3_player:btn_merry()
    self:FillList(mp3_table_merry)
    mp3_player_section = 1
end

function mp3_player:btn_dance()
    self:FillList(mp3_table_dance)
    mp3_player_section = 2
end

function mp3_player:btn_theme()
    self:FillList(mp3_table_theme)
    mp3_player_section = 3
end

function mp3_player:btn_other()
    self:FillList(mp3_table_other)
    mp3_player_section = 4
end

function mp3_player:btn_bonus()
    self:FillList(mp3_table_bonus)
    mp3_player_section = 5
end

function mp3_player:get_sound_length(snd_obj, other_length)
    local length_second = 0
    if snd_obj ~= nil and other_length == nil then
        length_second = math.floor(snd_obj:length() / 1000)
    end
    if other_length ~= nil then
        length_second = other_length
    end
    local currert_minute = math.floor(length_second / 60)
    local data = "00:00"
    if currert_minute < 10 then
        currert_minute = "0" .. currert_minute
    end
    if length_second < 60 then
        if length_second < 10 then
            data = currert_minute .. ":0" .. length_second
        else
            data = currert_minute ..
                ":" .. length_second
        end
    elseif length_second < 120 then
        if length_second < 70 then
            data = currert_minute .. ":0" .. length_second - 60
        else
            data = currert_minute ..
                ":" .. length_second - 60
        end
    elseif length_second < 180 then
        if length_second < 130 then
            data = currert_minute .. ":0" .. length_second - 120
        else
            data = currert_minute ..
                ":" .. length_second - 120
        end
    elseif length_second < 240 then
        if length_second < 190 then
            data = currert_minute .. ":0" .. length_second - 180
        else
            data = currert_minute ..
                ":" .. length_second - 180
        end
    elseif length_second < 300 then
        if length_second < 250 then
            data = currert_minute .. ":0" .. length_second - 240
        else
            data = currert_minute ..
                ":" .. length_second - 240
        end
    elseif length_second < 360 then
        if length_second < 310 then
            data = currert_minute .. ":0" .. length_second - 300
        else
            data = currert_minute ..
                ":" .. length_second - 300
        end
    elseif length_second < 420 then
        if length_second < 370 then
            data = currert_minute .. ":0" .. length_second - 360
        else
            data = currert_minute ..
                ":" .. length_second - 360
        end
    elseif length_second < 480 then
        if length_second < 430 then
            data = currert_minute .. ":0" .. length_second - 420
        else
            data = currert_minute ..
                ":" .. length_second - 420
        end
    elseif length_second < 540 then
        if length_second < 490 then
            data = currert_minute .. ":0" .. length_second - 480
        else
            data = currert_minute ..
                ":" .. length_second - 480
        end
    elseif length_second < 600 then
        if length_second < 540 then
            data = currert_minute .. ":0" .. length_second - 540
        else
            data = currert_minute ..
                ":" .. length_second - 540
        end
    elseif length_second < 660 then
        if length_second < 610 then
            data = currert_minute .. ":0" .. length_second - 600
        else
            data = currert_minute ..
                ":" .. length_second - 600
        end
    elseif length_second < 720 then
        if length_second < 670 then
            data = currert_minute .. ":0" .. length_second - 660
        else
            data = currert_minute ..
                ":" .. length_second - 660
        end
    elseif length_second < 780 then
        if length_second < 730 then
            data = currert_minute .. ":0" .. length_second - 720
        else
            data = currert_minute ..
                ":" .. length_second - 720
        end
    elseif length_second < 840 then
        if length_second < 790 then
            data = currert_minute .. ":0" .. length_second - 780
        else
            data = currert_minute ..
                ":" .. length_second - 780
        end
    elseif length_second < 900 then
        if length_second < 850 then
            data = currert_minute .. ":0" .. length_second - 840
        else
            data = currert_minute ..
                ":" .. length_second - 840
        end
    elseif length_second < 960 then
        if length_second < 910 then
            data = currert_minute .. ":0" .. length_second - 900
        else
            data = currert_minute ..
                ":" .. length_second - 900
        end
    elseif length_second < 1020 then
        if length_second < 970 then
            data = currert_minute .. ":0" .. length_second - 960
        else
            data = currert_minute ..
                ":" .. length_second - 960
        end
    elseif length_second < 1080 then
        if length_second < 1030 then
            data = currert_minute .. ":0" .. length_second - 1020
        else
            data = currert_minute ..
                ":" .. length_second - 1020
        end
    elseif length_second < 1140 then
        if length_second < 1090 then
            data = currert_minute .. ":0" .. length_second - 1080
        else
            data = currert_minute ..
                ":" .. length_second - 1080
        end
    elseif length_second < 1200 then
        if length_second < 1150 then
            data = currert_minute .. ":0" .. length_second - 1140
        else
            data = currert_minute ..
                ":" .. length_second - 1140
        end
    elseif length_second < 1260 then
        if length_second < 1210 then
            data = currert_minute .. ":0" .. length_second - 1200
        else
            data = currert_minute ..
                ":" .. length_second - 1200
        end
    elseif length_second < 1320 then
        if length_second < 1270 then
            data = currert_minute .. ":0" .. length_second - 1260
        else
            data = currert_minute ..
                ":" .. length_second - 1260
        end
    end
    return data
end

function mp3_player:btn_play()
    if mp3_obj ~= nil then
        if mp3_obj:playing() == true then
            mp3_obj:stop()
            mp3_length_position, mp3_last_position = 0, 0
        end
    end
    if self.mp3_list:GetSize() == 0 then return end
    local item = self.mp3_list:GetSelectedItem()
    if not item then return end
    local sound_title = item.title:GetText()
    local sound_name = ""
    for k, v in pairs(mp3_chosen_list) do
        if v.title == sound_title then
            sound_name = v.sound
        end
    end
    mp3_obj = sound_object(sound_name)
    mp3_obj:play(db.actor, 0, sound_object.s2d)
    mp3_obj.volume = read_mod_param("mp3_currert_volume")
    mp3_plays = sound_title
    mp3_last_position = string.format(math.floor(time_global() / 1000))
    mp3_length_position = string.format(math.floor(time_global() / 1000)) - mp3_last_position
    mp3_info = sound_title .. " (" .. self:get_sound_length(mp3_obj) .. ")"
    mp3_obj.min_distance, mp3_obj.max_distance = 2, 6
    mp3_played_list = mp3_chosen_list
end

function mp3_player:btn_stop()
    if mp3_obj ~= nil then
        if mp3_obj:playing() == true then
            mp3_obj:stop()
            mp3_obj = nil
            mp3_info = ""
        end
    end
    mp3_plays = nil
    mp3_length_position, mp3_last_position = 0, 0
end

function mp3_player:btn_close()
    give_object_to_actor("mp3_player")
    self:HideDialog()
    set_ui_worked()
    level.show_weapon(true)
end
