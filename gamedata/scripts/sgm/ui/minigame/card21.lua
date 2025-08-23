
------------------------------------------------------------------------------
--                        Карточная игра: 21 очко                           --
------------------------------------------------------------------------------
card_game_21_stage = "need_rate"
card_game_21_take_else = "empty_card"
card_game_21_existing_masks = { "kresta", "pika", "bubna", "chirva" }
card_game_21_existing_names = { "6", "7", "8", "9", "10", "J", "Q", "K", "T" }
card_game_21_winner = "none"
card_game_21_enemy_name = "none"
card_game_21_info_about_your = ""
card_game_21_info_about_enemy = ""
card_game_21_your_points = 0
card_game_21_enemy_points = 0
card_game_21_rate = 0
card_game_21_show_winner = "hide"
card_game_21_difficulty = "easy"
card_game_21_increasing_rate = 50
class "card_game_21_point" (CUIScriptWnd)
function card_game_21_point:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function card_game_21_point:__finalize()
end

function card_game_21_point:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.card_game_21_point_form = xml:InitStatic("card_game_21_point_form", self)
   self:start_button(xml, "btn_exit_game")
   self:start_button(xml, "btn_play_game")
   self:start_button(xml, "btn_take_else")
   self:start_button(xml, "btn_send_move")
   self:start_button(xml, "btn_continue_game")
   self:start_button(xml, "btn_rate_minus")
   self:start_button(xml, "btn_rate_plus")
   self:start_button(xml, "btn_take_rate")
   self.form_title = xml:InitStatic("card_game_21_point_form:form_title", self.card_game_21_point_form)
   self.check_save_rate = xml:InitCheck("card_game_21_point_form:check_save_rate", self.card_game_21_point_form)
   self.check_save_rate:SetCheck(sgm_functions.info_get_boolean("card_game_21_save_rate"))
   self.check_increasing = xml:InitCheck("card_game_21_point_form:check_increasing", self.card_game_21_point_form)
   self.check_increasing:SetCheck(sgm_functions.info_get_boolean("card_game_21_increasing"))
   self.your_game_info = xml:InitStatic("card_game_21_point_form:your_game_info", self.card_game_21_point_form)
   self.enemy_game_info = xml:InitStatic("card_game_21_point_form:enemy_game_info", self.card_game_21_point_form)
   self.your_card_value = xml:InitStatic("card_game_21_point_form:your_card_value", self.card_game_21_point_form)
   self.enemy_card_value = xml:InitStatic("card_game_21_point_form:enemy_card_value", self.card_game_21_point_form)
   self.self_card_1 = xml:InitStatic("card_game_21_point_form:self_card_1", self.card_game_21_point_form)
   self.self_card_2 = xml:InitStatic("card_game_21_point_form:self_card_2", self.card_game_21_point_form)
   self.self_card_3 = xml:InitStatic("card_game_21_point_form:self_card_3", self.card_game_21_point_form)
   self.self_card_4 = xml:InitStatic("card_game_21_point_form:self_card_4", self.card_game_21_point_form)
   self.self_card_5 = xml:InitStatic("card_game_21_point_form:self_card_5", self.card_game_21_point_form)
   self.enemy_card_1 = xml:InitStatic("card_game_21_point_form:enemy_card_1", self.card_game_21_point_form)
   self.enemy_card_2 = xml:InitStatic("card_game_21_point_form:enemy_card_2", self.card_game_21_point_form)
   self.enemy_card_3 = xml:InitStatic("card_game_21_point_form:enemy_card_3", self.card_game_21_point_form)
   self.enemy_card_4 = xml:InitStatic("card_game_21_point_form:enemy_card_4", self.card_game_21_point_form)
   self.enemy_card_5 = xml:InitStatic("card_game_21_point_form:enemy_card_5", self.card_game_21_point_form)
   self.rate_field = xml:InitStatic("card_game_21_point_form:rate_field", self.card_game_21_point_form)
   self.infoline_1 = xml:InitStatic("card_game_21_point_form:your_game_info", self.card_game_21_point_form)
   self.infoline_2 = xml:InitStatic("card_game_21_point_form:enemy_game_info", self.card_game_21_point_form)
   self.r_green_diod = xml:InitStatic("card_game_21_point_form:r_green_diod", self.card_game_21_point_form)
   self.l_green_diod = xml:InitStatic("card_game_21_point_form:l_green_diod", self.card_game_21_point_form)
   self.r_yellow_diod = xml:InitStatic("card_game_21_point_form:r_yellow_diod", self.card_game_21_point_form)
   self.l_yellow_diod = xml:InitStatic("card_game_21_point_form:l_yellow_diod", self.card_game_21_point_form)
   self.r_red_diod = xml:InitStatic("card_game_21_point_form:r_red_diod", self.card_game_21_point_form)
   self.l_red_diod = xml:InitStatic("card_game_21_point_form:l_red_diod", self.card_game_21_point_form)
   self.winner_box = CUIMessageBoxEx()
   self:Register(self.winner_box, "winner_box")
end

function card_game_21_point:InitCallBacks()
   self:AddCallback("btn_exit_game", ui_events.BUTTON_CLICKED, self.btn_exit_game, self)
   self:AddCallback("btn_play_game", ui_events.BUTTON_CLICKED, self.btn_play_game, self)
   self:AddCallback("btn_take_else", ui_events.BUTTON_CLICKED, self.btn_take_else, self)
   self:AddCallback("btn_send_move", ui_events.BUTTON_CLICKED, self.btn_send_move, self)
   self:AddCallback("btn_take_rate", ui_events.BUTTON_CLICKED, self.btn_take_rate, self)
   self:AddCallback("btn_rate_minus", ui_events.BUTTON_CLICKED, self.btn_rate_minus, self)
   self:AddCallback("btn_rate_plus", ui_events.BUTTON_CLICKED, self.btn_rate_plus, self)
   self:AddCallback("btn_continue_game", ui_events.BUTTON_CLICKED, self.btn_continue_game, self)
   self:AddCallback("winner_box", ui_events.MESSAGE_BOX_OK_CLICKED, self.show_game_winner, self)
   self:AddCallback("winner_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.show_game_winner, self)
end

function card_game_21_point:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_exit_game()
   else
      self.form_title:TextControl():SetText(game.translate_string("st_21_point_title"))
      if card_game_21_stage == "play_game" or card_game_21_stage == "end_game" then
         self.your_game_info:TextControl():SetText(card_game_21_info_about_your)
         self.enemy_game_info:TextControl():SetText(card_game_21_info_about_enemy)
         self.your_card_value:TextControl():SetText(game.translate_string("st_21_point_your_card_value") ..
            " " .. card_game_21_your_points)
         self.enemy_card_value:TextControl():SetText(game.translate_string("st_21_point_enemy_card_value") ..
            " " .. card_game_21_enemy_points)
      else
         self.your_game_info:TextControl():SetText("")
         self.enemy_game_info:TextControl():SetText("")
         self.your_card_value:TextControl():SetText("")
         self.enemy_card_value:TextControl():SetText("")
      end
      if card_game_21_stage == "need_rate" then
         self.rate_field:TextControl():SetText(game.translate_string("st_21_point_rate_field") .. " " ..
            card_game_21_rate)
         self.infoline_1:TextControl():SetText(game.translate_string("st_21_point_infoline_1") ..
            " " .. db.actor:money() .. " " .. game.translate_string("st_21_point_money"))
         self.infoline_2:TextControl():SetText(game.translate_string("st_21_point_infoline_2") ..
            " " .. sgm_flags.value_card_21_max_rate .. ".")
      else
         self.infoline_1:TextControl():SetText("")
         self.infoline_2:TextControl():SetText("")
      end
   end
   if card_game_21_rate < 0 then
      card_game_21_rate = 0
   elseif card_game_21_rate > sgm_flags.value_card_21_max_rate then
      card_game_21_rate = sgm_flags.value_card_21_max_rate
   end
   if card_game_21_rate > db.actor:money() then
      run_choose_box("yes", "card_game_21_point", game.translate_string("st_21_point_dont_money_to_rate"))
      card_game_21_rate = db.actor:money()
   end
   if card_game_21_stage == "need_rate" then
      self.get_btn_send_move:Show(false)
      self.get_btn_take_else:Show(false)
      self.get_btn_play_game:Show(false)
      self.get_btn_send_move:Enable(false)
      self.get_btn_take_else:Enable(false)
      self.get_btn_play_game:Enable(false)
      self.get_btn_take_rate:Show(true)
      self.get_btn_take_rate:Enable(true)
      self.get_btn_rate_minus:Show(true)
      self.get_btn_rate_plus:Show(true)
      self.get_btn_continue_game:Show(false)
      self.get_btn_continue_game:Enable(false)
      self.get_btn_exit_game:Enable(true)
      self.check_save_rate:Show(true)
      self.check_save_rate:Enable(true)
      self.check_increasing:Show(true)
      self.check_increasing:Enable(true)
      self.r_green_diod:Show(false)
      self.r_green_diod:Enable(false)
      self.l_green_diod:Show(false)
      self.l_green_diod:Enable(false)
      self.r_yellow_diod:Show(false)
      self.r_yellow_diod:Enable(false)
      self.l_yellow_diod:Show(false)
      self.l_yellow_diod:Enable(false)
      self.r_red_diod:Show(false)
      self.r_red_diod:Enable(false)
      self.l_red_diod:Show(false)
      self.l_red_diod:Enable(false)
      if card_game_21_rate == 0 then
         self.get_btn_rate_minus:Enable(false)
      else
         self.get_btn_rate_minus:Enable(true)
      end
      if card_game_21_rate == sgm_flags.value_card_21_max_rate then
         self.get_btn_rate_plus:Enable(false)
      else
         self.get_btn_rate_plus:Enable(true)
      end
   elseif card_game_21_stage == "taked_rate" then
      self.get_btn_send_move:Show(true)
      self.get_btn_take_else:Show(true)
      self.get_btn_play_game:Show(true)
      self.get_btn_send_move:Enable(false)
      self.get_btn_take_else:Enable(false)
      self.get_btn_play_game:Enable(true)
      self.get_btn_take_rate:Show(false)
      self.get_btn_take_rate:Enable(false)
      self.get_btn_rate_minus:Show(false)
      self.get_btn_rate_plus:Show(false)
      self.get_btn_rate_minus:Enable(false)
      self.get_btn_rate_plus:Enable(false)
      self.get_btn_continue_game:Show(false)
      self.get_btn_continue_game:Enable(false)
      self.get_btn_exit_game:Enable(true)
      self.check_save_rate:Show(false)
      self.check_save_rate:Enable(false)
      self.check_increasing:Show(false)
      self.check_increasing:Enable(false)
      self.r_green_diod:Show(false)
      self.r_green_diod:Enable(false)
      self.l_green_diod:Show(false)
      self.l_green_diod:Enable(false)
      self.r_yellow_diod:Show(false)
      self.r_yellow_diod:Enable(false)
      self.l_yellow_diod:Show(false)
      self.l_yellow_diod:Enable(false)
      self.r_red_diod:Show(true)
      self.r_red_diod:Enable(true)
      self.l_red_diod:Show(true)
      self.l_red_diod:Enable(true)
   elseif card_game_21_stage == "play_game" then
      self.get_btn_send_move:Show(true)
      self.get_btn_take_else:Show(true)
      self.get_btn_play_game:Show(true)
      self.get_btn_send_move:Enable(true)
      self.get_btn_take_else:Enable(true)
      self.get_btn_play_game:Enable(false)
      self.get_btn_take_rate:Show(false)
      self.get_btn_take_rate:Enable(false)
      self.get_btn_rate_minus:Show(false)
      self.get_btn_rate_plus:Show(false)
      self.get_btn_rate_minus:Enable(false)
      self.get_btn_rate_plus:Enable(false)
      self.get_btn_continue_game:Show(false)
      self.get_btn_continue_game:Enable(false)
      self.get_btn_exit_game:Enable(false)
      self.check_save_rate:Show(false)
      self.check_save_rate:Enable(false)
      self.check_increasing:Show(false)
      self.check_increasing:Enable(false)
      self.r_green_diod:Show(false)
      self.r_green_diod:Enable(false)
      self.l_green_diod:Show(false)
      self.l_green_diod:Enable(false)
      self.r_yellow_diod:Show(true)
      self.r_yellow_diod:Enable(true)
      self.l_yellow_diod:Show(true)
      self.l_yellow_diod:Enable(true)
      self.r_red_diod:Show(false)
      self.r_red_diod:Enable(false)
      self.l_red_diod:Show(false)
      self.l_red_diod:Enable(false)
   elseif card_game_21_stage == "end_game" then
      self.get_btn_send_move:Show(true)
      self.get_btn_take_else:Show(true)
      self.get_btn_play_game:Show(false)
      self.get_btn_send_move:Enable(false)
      self.get_btn_take_else:Enable(false)
      self.get_btn_play_game:Enable(false)
      self.get_btn_take_rate:Show(false)
      self.get_btn_take_rate:Enable(false)
      self.get_btn_rate_minus:Show(false)
      self.get_btn_rate_plus:Show(false)
      self.get_btn_rate_minus:Enable(false)
      self.get_btn_rate_plus:Enable(false)
      self.get_btn_continue_game:Show(true)
      self.get_btn_continue_game:Enable(true)
      self.get_btn_exit_game:Enable(false)
      self.check_save_rate:Show(false)
      self.check_save_rate:Enable(false)
      self.check_increasing:Show(false)
      self.check_increasing:Enable(false)
      if card_game_21_winner == "your" then
         self.r_green_diod:Show(false)
         self.r_green_diod:Enable(false)
         self.l_green_diod:Show(true)
         self.l_green_diod:Enable(true)
         self.r_yellow_diod:Show(false)
         self.r_yellow_diod:Enable(false)
         self.l_yellow_diod:Show(false)
         self.l_yellow_diod:Enable(false)
         self.r_red_diod:Show(true)
         self.r_red_diod:Enable(true)
         self.l_red_diod:Show(false)
         self.l_red_diod:Enable(false)
      elseif card_game_21_winner == "enemy" then
         self.r_green_diod:Show(true)
         self.r_green_diod:Enable(true)
         self.l_green_diod:Show(false)
         self.l_green_diod:Enable(false)
         self.r_yellow_diod:Show(false)
         self.r_yellow_diod:Enable(false)
         self.l_yellow_diod:Show(false)
         self.l_yellow_diod:Enable(false)
         self.r_red_diod:Show(false)
         self.r_red_diod:Enable(false)
         self.l_red_diod:Show(true)
         self.l_red_diod:Enable(true)
      elseif card_game_21_winner == "equally" then
         self.r_green_diod:Show(true)
         self.r_green_diod:Enable(true)
         self.l_green_diod:Show(true)
         self.l_green_diod:Enable(true)
         self.r_yellow_diod:Show(false)
         self.r_yellow_diod:Enable(false)
         self.l_yellow_diod:Show(false)
         self.l_yellow_diod:Enable(false)
         self.r_red_diod:Show(false)
         self.r_red_diod:Enable(false)
         self.l_red_diod:Show(false)
         self.l_red_diod:Enable(false)
      end
   end
   if card_game_21_show_winner == "end_show" then
      self:btn_exit_game(false)
      card_game_21_show_winner = "hide"
      self.get_btn_continue_game:Show(false)
      self.get_btn_continue_game:Enable(false)
   end
   if self.check_increasing:GetCheck() == true and card_game_21_increasing_rate ~= 200 then
      card_game_21_increasing_rate = 200
   elseif self.check_increasing:GetCheck() == false and card_game_21_increasing_rate ~= 50 then
      card_game_21_increasing_rate = 50
   end
   sgm_functions.info_give_on_boolean(self.check_save_rate:GetCheck(), "card_game_21_save_rate")
   sgm_functions.info_give_on_boolean(self.check_increasing:GetCheck(), "card_game_21_increasing")
end

function card_game_21_point:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE and card_game_21_stage ~= "play_game" and card_game_21_stage ~= "end_game" then
         self:btn_exit_game()
      end
   end
   return true
end

function card_game_21_point:start_button(xml, button_name)
   self["get_" .. button_name] = xml:Init3tButton("card_game_21_point_form:" .. button_name, self
      .card_game_21_point_form)
   self:Register(self["get_" .. button_name], button_name)
end

function card_game_21_point:ClearGameCards()
   for i = 1, 5 do
      self["self_card_" .. i]:InitTexture("ui_mod_card_hide_side")
      self["enemy_card_" .. i]:InitTexture("ui_mod_card_hide_side")
   end
end

function card_game_21_point:FillCardPoint(param, name, mask)
   local result = 0
   if name == "6" then
      result = 6
   elseif name == "7" then
      result = 7
   elseif name == "8" then
      result = 8
   elseif name == "9" then
      result = 9
   elseif name == "10" then
      result = 10
   elseif name == "J" then
      result = 2
   elseif name == "Q" then
      result = 3
   elseif name == "K" then
      result = 4
   elseif name == "T" then
      result = 11
   end
   self[param]:InitTexture("ui_mod_card_" .. name .. "_" .. mask)
   if find_in_string(param, "self_") then
      card_game_21_your_points = card_game_21_your_points + result
   else
      card_game_21_enemy_points = card_game_21_enemy_points + result
   end
end

function card_game_21_point:FillEnemyStep(step_num)
   local name, mask = get_random_string(card_game_21_existing_names), get_random_string(card_game_21_existing_masks)
   if card_game_21_difficulty == "hard" and get_rnd(1, 2) == 1 then
      if self:GetNearestPoint(card_game_21_enemy_points) == 11 then
         name = get_random_line("T,10")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 9 or self:GetNearestPoint(card_game_21_enemy_points) == 10 then
         name = get_random_line("9,10")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 8 then
         name = get_random_line("8")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 7 then
         name = get_random_line("7,8")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 6 then
         name = get_random_line("6")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 5 or self:GetNearestPoint(card_game_21_enemy_points) == 4 then
         name = get_random_line("K,Q")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 3 then
         name = get_random_line("Q,J")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 2 then
         name = get_random_line("J")
      end
   elseif card_game_21_difficulty == "normal" and get_rnd(1, 4) == 1 then
      if self:GetNearestPoint(card_game_21_enemy_points) == 11 then
         name = get_random_line("T,10")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 9 or self:GetNearestPoint(card_game_21_enemy_points) == 10 then
         name = get_random_line("9,10")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 8 then
         name = get_random_line("7,8,9")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 7 then
         name = get_random_line("6,7,8")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 6 then
         name = get_random_line("6,K")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 5 or self:GetNearestPoint(card_game_21_enemy_points) == 4 then
         name = get_random_line("K,Q")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 3 then
         name = get_random_line("K,Q,J")
      elseif self:GetNearestPoint(card_game_21_enemy_points) == 2 then
         name = get_random_line("J")
      end
   end
   self:FillCardPoint("enemy_card_" .. step_num, name, mask)
end

function card_game_21_point:GetNearestPoint(value)
   local need_value = 21
   if value < need_value then
      return need_value - value
   elseif value > need_value then
      return value - need_value
   elseif value == need_value then
      return 0
   end
end

function card_game_21_point:GetTooManyPoint(value, extra_mode)
   local need_value = 21
   if value < need_value then
      return false
   elseif value > need_value then
      return true
   elseif value == need_value then
      if extra_mode == nil or extra_mode == false then
         return true
      else
         return false
      end
   end
end

function card_game_21_point:btn_rate_minus()
   card_game_21_rate = card_game_21_rate - card_game_21_increasing_rate
end

function card_game_21_point:btn_rate_plus()
   card_game_21_rate = card_game_21_rate + card_game_21_increasing_rate
end

function card_game_21_point:btn_take_rate()
   if card_game_21_rate > 0 and db.actor:money() >= card_game_21_rate then
      card_game_21_stage = "taked_rate"
   else
      run_choose_box("yes", "card_game_21_point", game.translate_string("st_21_point_dont_take_rate"))
   end
end

function card_game_21_point:btn_exit_game(hide)
   if hide == nil or hide == true then
      self:HideDialog()
      set_ui_worked()
   end
   card_game_21_stage = "need_rate"
   card_game_21_info_about_your = ""
   card_game_21_info_about_enemy = ""
   card_game_21_enemy_name = "none"
   card_game_21_your_points = 0
   card_game_21_enemy_points = 0
   card_game_21_take_else = "empty_card"
   card_game_21_winner = "none"
   if self.check_save_rate:GetCheck() == false then
      card_game_21_rate = 0
   end
   card_game_21_show_winner = "hide"
   self:ClearGameCards()
end

function card_game_21_point:btn_play_game()
   card_game_21_difficulty = get_random_line("easy,normal,hard")
   if card_game_21_difficulty ~= "hard" and get_rnd(1, 6) == 1 then
      --/card_game_21_difficulty="hard"
   end
   card_game_21_stage = "play_game"
   card_game_21_winner = "none"
   card_game_21_info_about_your = game.translate_string("st_21_point_info_about_your") ..
       " " .. card_game_21_rate .. " " .. game.translate_string("st_21_point_money")
   card_game_21_info_about_enemy = card_game_21_enemy_name ..
       game.translate_string("st_21_point_info_about_enemy") ..
       " " .. card_game_21_rate .. " " .. game.translate_string("st_21_point_web_money")
   local name, mask = get_random_string(card_game_21_existing_names), get_random_string(card_game_21_existing_masks)
   self:FillCardPoint("self_card_1", name, mask)
   local name, mask = get_random_string(card_game_21_existing_names), get_random_string(card_game_21_existing_masks)
   self:FillCardPoint("self_card_2", name, mask)
end

function card_game_21_point:btn_take_else()
   local name, mask = get_random_string(card_game_21_existing_names), get_random_string(card_game_21_existing_masks)
   if card_game_21_take_else == "empty_card" then
      if self:GetNearestPoint(card_game_21_your_points) <= 5 and get_rnd(1, 5) == 1 then
         name = get_random_line("T,10,9,8")
      end
      self:FillCardPoint("self_card_3", name, mask)
      card_game_21_take_else = "1st_card"
   elseif card_game_21_take_else == "1st_card" then
      if self:GetNearestPoint(card_game_21_your_points) <= 5 and get_rnd(1, 5) == 1 then
         name = get_random_line("T,10,9,8")
      end
      self:FillCardPoint("self_card_4", name, mask)
      card_game_21_take_else = "2nd_card"
   elseif card_game_21_take_else == "2nd_card" then
      if self:GetNearestPoint(card_game_21_your_points) <= 5 and get_rnd(1, 5) == 1 then
         name = get_random_line("T,10,9,8")
      end
      self:FillCardPoint("self_card_5", name, mask)
      card_game_21_take_else = "3rd_card"
      self:btn_send_move()
   end
end

function card_game_21_point:btn_send_move()
   local name, mask = get_random_string(card_game_21_existing_names), get_random_string(card_game_21_existing_masks)
   self:FillCardPoint("enemy_card_1", name, mask)
   local name, mask = get_random_string(card_game_21_existing_names), get_random_string(card_game_21_existing_masks)
   self:FillCardPoint("enemy_card_2", name, mask)
   local threshold_value = math.random(3, 5)
   if self:GetNearestPoint(card_game_21_enemy_points) > threshold_value and self:GetTooManyPoint(card_game_21_enemy_points) == false then
      self:enemy_move_add_one()
   else
      self:winner_reward()
   end
end

function card_game_21_point:enemy_move_add_one()
   self:FillEnemyStep(3)
   local threshold_value = math.random(3, 5)
   if self:GetNearestPoint(card_game_21_enemy_points) > threshold_value and self:GetTooManyPoint(card_game_21_enemy_points) == false then
      self:enemy_move_add_two()
   else
      self:winner_reward()
   end
end

function card_game_21_point:enemy_move_add_two()
   self:FillEnemyStep(4)
   local threshold_value = math.random(3, 5)
   if self:GetNearestPoint(card_game_21_enemy_points) > threshold_value and self:GetTooManyPoint(card_game_21_enemy_points) == false then
      self:enemy_move_add_three()
   else
      self:winner_reward()
   end
end

function card_game_21_point:enemy_move_add_three()
   self:FillEnemyStep(5)
   self:winner_reward()
end

function card_game_21_point:winner_reward()
   if r_mod_params("bool", "card_game_21_rules_default", true) == true then
      if self:GetTooManyPoint(card_game_21_your_points, true) == false and self:GetTooManyPoint(card_game_21_enemy_points, true) == true then
         card_game_21_winner = "your"
      elseif self:GetTooManyPoint(card_game_21_your_points, true) == true and self:GetTooManyPoint(card_game_21_enemy_points, true) == false then
         card_game_21_winner = "enemy"
      else
         if self:GetNearestPoint(card_game_21_your_points) < self:GetNearestPoint(card_game_21_enemy_points) then
            card_game_21_winner = "your"
         elseif self:GetNearestPoint(card_game_21_your_points) > self:GetNearestPoint(card_game_21_enemy_points) then
            card_game_21_winner = "enemy"
         elseif self:GetNearestPoint(card_game_21_your_points) == self:GetNearestPoint(card_game_21_enemy_points) then
            card_game_21_winner = "equally"
         end
      end
   elseif r_mod_params("bool", "card_game_21_rules_default", true) == false then
      if self:GetNearestPoint(card_game_21_your_points) == self:GetNearestPoint(card_game_21_enemy_points) then
         card_game_21_winner = "equally"
      elseif self:GetNearestPoint(card_game_21_your_points) < self:GetNearestPoint(card_game_21_enemy_points) then
         card_game_21_winner = "your"
      elseif self:GetNearestPoint(card_game_21_your_points) > self:GetNearestPoint(card_game_21_enemy_points) then
         card_game_21_winner = "enemy"
      end
   end
   card_game_21_stage = "end_game"
end

function card_game_21_point:btn_continue_game()
   card_game_21_show_winner = "begin_show"
   self.winner_box:InitMessageBox("message_box_ok")
   if card_game_21_winner == "your" then
      sgm_functions.relocate_web_money(card_game_21_rate, "in")
      self.winner_box:SetText(game.translate_string("st_21_point_winner_your_1") ..
         " " ..
         card_game_21_rate ..
         " " ..
         game.translate_string("st_21_point_winner_your_2") ..
         " " ..
         card_game_21_your_points .. game.translate_string("st_21_point_winner_your_3") ..
         " " .. card_game_21_enemy_points .. ".")
   elseif card_game_21_winner == "enemy" then
      dialogs.relocate_money(db.actor, card_game_21_rate, "out")
      db.actor:give_money(-card_game_21_rate)
      game_stats.money_quest_update(-card_game_21_rate)
      self.winner_box:SetText(game.translate_string("st_21_point_winner_enemy_1") ..
         " " ..
         card_game_21_rate ..
         " " ..
         game.translate_string("st_21_point_winner_enemy_2") ..
         " " ..
         card_game_21_your_points ..
         game.translate_string("st_21_point_winner_enemy_3") .. " " .. card_game_21_enemy_points .. ".")
   else
      self.winner_box:SetText(game.translate_string("st_21_point_winner_equally_1") ..
         " " ..
         card_game_21_your_points ..
         game.translate_string("st_21_point_winner_equally_2") .. " " .. card_game_21_enemy_points .. ".")
   end
   self.winner_box:ShowDialog(true)
end

function card_game_21_point:show_game_winner()
   self.winner_box:ShowDialog(false)
   self.winner_box:HideDialog()
   card_game_21_show_winner = "end_show"
end
