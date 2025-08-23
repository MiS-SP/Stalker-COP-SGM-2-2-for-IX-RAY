------------------------------------------------------------------------------
--              Мини-игра: Зачем? Под кем? Во сколько?                      --
------------------------------------------------------------------------------
question_game_correct_answer_descr = { "st_question_game_correct_answer_1_text", "st_question_game_correct_answer_2_text",
   "st_question_game_correct_answer_3_text", "st_question_game_correct_answer_4_text" }
question_game_wrong_answer_descr = { "st_question_game_wrong_answer_1_text", "st_question_game_wrong_answer_2_text",
   "st_question_game_wrong_answer_3_text", "st_question_game_wrong_answer_4_text" }
question_game_ini = ini_file("misc\\config_question_game.ltx")
question_game_q_count = 1
question_game_a_count = 1
question_game_q_available = 0
question_game_a_available = 0
question_game_reward_money = 0
question_game_question_number = 1
question_game_correct_series = 0
question_game_stage = "nil"
question_game_question_descr = ""
question_game_answer_a = ""
question_game_answer_b = ""
question_game_answer_c = ""
question_game_answer_d = ""
question_game_correct = ""
question_game_q_s = "nil"
question_game_q_h_f = false
question_game_a_s = "nil"
question_game_a_h_f = false
question_q_table = {}
question_a_table = {}
class "question_game" (CUIScriptWnd)
function question_game:__init(owner)
   super()
   self.owner = owner
   self:InitControls()
   self:InitCallBacks()
end

function question_game:__finalize()
end

function question_game:InitControls()
   self:SetWndRect(Frect():set(0, 0, 1024, 768))
   xml = CScriptXmlInit()
   xml:ParseFile("ui_mod_elements.xml")
   self.question_game_form = xml:InitStatic("question_game_form", self)
   self.form_title = xml:InitStatic("question_game_form:form_title", self.question_game_form)
   self:start_button(xml, "btn_exit_game")
   self:start_button(xml, "btn_answer_a")
   self:start_button(xml, "btn_answer_b")
   self:start_button(xml, "btn_answer_c")
   self:start_button(xml, "btn_answer_d")
   self:start_button(xml, "btn_manual")
   self:start_button(xml, "btn_start_game")
   self:start_button(xml, "btn_continue_game")
   self.question_number_field = xml:InitStatic("question_game_form:question_number_field", self.question_game_form)
   self.correct_series_field = xml:InitStatic("question_game_form:correct_series_field", self.question_game_form)
   self.question_field = xml:InitStatic("question_game_form:question_field", self.question_game_form)
   self.answer_a_field = xml:InitStatic("question_game_form:answer_a_field", self.question_game_form)
   self.answer_b_field = xml:InitStatic("question_game_form:answer_b_field", self.question_game_form)
   self.answer_c_field = xml:InitStatic("question_game_form:answer_c_field", self.question_game_form)
   self.answer_d_field = xml:InitStatic("question_game_form:answer_d_field", self.question_game_form)
   self.result_box = CUIMessageBoxEx()
   self:Register(self.result_box, "result_box")
   self.reward_box = CUIMessageBoxEx()
   self:Register(self.reward_box, "reward_box")
   self.message_box = CUIMessageBoxEx()
   self:Register(self.message_box, "message_box")
   self:parse_questions()
   self:parse_advices()
end

function question_game:InitCallBacks()
   self:AddCallback("btn_exit_game", ui_events.BUTTON_CLICKED, self.btn_exit_game, self)
   self:AddCallback("btn_answer_a", ui_events.BUTTON_CLICKED, self.btn_answer_a, self)
   self:AddCallback("btn_answer_b", ui_events.BUTTON_CLICKED, self.btn_answer_b, self)
   self:AddCallback("btn_answer_c", ui_events.BUTTON_CLICKED, self.btn_answer_c, self)
   self:AddCallback("btn_answer_d", ui_events.BUTTON_CLICKED, self.btn_answer_d, self)
   self:AddCallback("btn_manual", ui_events.BUTTON_CLICKED, self.btn_manual, self)
   self:AddCallback("btn_start_game", ui_events.BUTTON_CLICKED, self.btn_start_game, self)
   self:AddCallback("btn_continue_game", ui_events.BUTTON_CLICKED, self.btn_continue_game, self)
   self:AddCallback("result_box", ui_events.MESSAGE_BOX_OK_CLICKED, self.close_result, self)
   self:AddCallback("result_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.close_result, self)
   self:AddCallback("reward_box", ui_events.MESSAGE_BOX_OK_CLICKED, self.close_reward, self)
   self:AddCallback("reward_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.close_reward, self)
   self:AddCallback("message_box", ui_events.MESSAGE_BOX_OK_CLICKED, self.close_message, self)
   self:AddCallback("message_box", ui_events.MESSAGE_BOX_YES_CLICKED, self.close_message, self)
end

function question_game:Update()
   CUIScriptWnd.Update(self)
   if not object_alive(db.actor) then
      self:btn_exit_game()
   else
      --/self.form_title:TextControl():SetText(game.translate_string("st_question_game_title"))
      if question_game_stage ~= "nil" then
         self.question_field:TextControl():SetText(game.translate_string(question_game_question_descr))
         self.answer_a_field:TextControl():SetText("A)" .. game.translate_string(question_game_answer_a))
         self.answer_b_field:TextControl():SetText("B)" .. game.translate_string(question_game_answer_b))
         self.answer_c_field:TextControl():SetText("C)" .. game.translate_string(question_game_answer_c))
         self.answer_d_field:TextControl():SetText("D)" .. game.translate_string(question_game_answer_d))
         self.question_number_field:TextControl():SetText(question_game_question_number)
         self.correct_series_field:TextControl():SetText(question_game_correct_series)
      end
   end
   if question_game_stage == "begin" or question_game_stage == "next_question" then
      self.get_btn_answer_a:Show(true)
      self.get_btn_answer_a:Enable(true)
      self.get_btn_answer_b:Show(true)
      self.get_btn_answer_b:Enable(true)
      self.get_btn_answer_c:Show(true)
      self.get_btn_answer_c:Enable(true)
      self.get_btn_answer_d:Show(true)
      self.get_btn_answer_d:Enable(true)
      self.get_btn_start_game:Show(false)
      self.get_btn_start_game:Enable(false)
      self.get_btn_continue_game:Show(false)
      self.get_btn_continue_game:Enable(false)
   elseif question_game_stage == "answer_accepted" then
      self.get_btn_answer_a:Show(true)
      self.get_btn_answer_a:Enable(false)
      self.get_btn_answer_b:Show(true)
      self.get_btn_answer_b:Enable(false)
      self.get_btn_answer_c:Show(true)
      self.get_btn_answer_c:Enable(false)
      self.get_btn_answer_d:Show(true)
      self.get_btn_answer_d:Enable(false)
      self.get_btn_start_game:Show(false)
      self.get_btn_start_game:Enable(false)
      self.get_btn_continue_game:Show(true)
      self.get_btn_continue_game:Enable(true)
      if question_game_q_h_f == false then
         self:select_random_question()
      end
      if question_game_a_h_f == false then
         self:select_random_advice()
      end
   else
      self.get_btn_answer_a:Enable(false)
      self.get_btn_answer_a:Show(false)
      self.get_btn_answer_b:Show(false)
      self.get_btn_answer_b:Enable(false)
      self.get_btn_answer_c:Show(false)
      self.get_btn_answer_c:Enable(false)
      self.get_btn_answer_d:Show(false)
      self.get_btn_answer_d:Enable(false)
      self.get_btn_start_game:Show(true)
      self.get_btn_start_game:Enable(true)
      self.get_btn_continue_game:Show(false)
      self.get_btn_continue_game:Enable(false)
      if question_game_q_h_f == false then
         self:select_random_question()
      end
      if question_game_a_h_f == false then
         self:select_random_advice()
      end
   end
end

function question_game:OnKeyboard(dik, keyboard_action)
   CUIScriptWnd.OnKeyboard(self, dik, keyboard_action)
   if keyboard_action == ui_events.WINDOW_KEY_PRESSED then
      if dik == DIK_keys.DIK_ESCAPE then
         self:btn_exit_game()
      end
   end
   return true
end

function question_game:start_button(xml, button_name)
   self["get_" .. button_name] = xml:Init3tButton("question_game_form:" .. button_name, self.question_game_form)
   self:Register(self["get_" .. button_name], button_name)
end

function question_game:btn_exit_game(hide)
   self:HideDialog()
   if question_game_reward_money > 0 then
      dialogs.relocate_money(db.actor, question_game_reward_money, "in")
   end
   question_q_table = {}
   question_a_table = {}
   question_game_stage = "nil"
   question_game_question_number = 1
   question_game_correct_series = 0
   question_game_q_available = 0
   question_game_a_available = 0
   question_game_q_s = "nil"
   question_game_a_s = "nil"
   question_game_q_h_f = false
   question_game_a_h_f = false
   question_game_reward_money = 0
   set_ui_worked()
end

function question_game:close_result()
   self.result_box:ShowDialog(false)
   self.result_box:HideDialog()
   if question_game_correct_series >= 5 then
      if question_game_a_available > 0 then
         self:show_reward(game.translate_string("st_question_game_reward_advice") ..
            " " ..
            self:get_advice(question_game_a_s, "advice") ..
            " " ..
            game.translate_string("st_question_game_reward_money") .. " " ..
            self:get_advice(question_game_a_s, "reward_money"))
         question_game_reward_money = question_game_reward_money + self:get_advice(question_game_a_s, "reward_money")
         create_inventory_item(self:get_advice(question_game_a_s, "items"), "zat_informer_hiding",
            self:get_advice(question_game_a_s, "place_x"), self:get_advice(question_game_a_s, "place_y"),
            self:get_advice(question_game_a_s, "place_z"), self:get_advice(question_game_a_s, "place_lv"),
            self:get_advice(question_game_a_s, "place_gv"))
         give_info(question_game_a_s)
         question_game_a_available = question_game_a_available - 1
         question_game_a_h_f = false
      end
      question_game_correct_series = 0
   end
end

function question_game:close_reward()
   self.reward_box:ShowDialog(false)
   self.reward_box:HideDialog()
end

function question_game:close_message()
   self.message_box:ShowDialog(false)
   self.message_box:HideDialog()
end

function question_game:show_result(text)
   self.result_box:InitMessageBox("message_box_ok")
   self.result_box:SetText(game.translate_string(text))
   self.result_box:ShowDialog(true)
end

function question_game:show_reward(text)
   self.reward_box:InitMessageBox("message_box_ok")
   self.reward_box:SetText(game.translate_string(text))
   self.reward_box:ShowDialog(true)
end

function question_game:show_message(text)
   self.message_box:InitMessageBox("message_box_ok")
   self.message_box:SetText(game.translate_string(text))
   self.message_box:ShowDialog(true)
end

function question_game:setup_result(type)
   give_info(question_game_q_s)
   question_game_q_available = question_game_q_available - 1
   question_game_stage = "answer_accepted"
   if type == "correct" then
      self:show_result(game.translate_string(get_random_string(question_game_correct_answer_descr)))
      question_game_correct_series = question_game_correct_series + 1
   elseif type == "wrong" then
      self:show_result(game.translate_string(get_random_string(question_game_wrong_answer_descr)))
      question_game_correct_series = 0
   end
end

function question_game:issue_reward_money()
   question_game_reward_money = question_game_reward_money + self:get_question(question_game_q_s, "cost")
end

function question_game:btn_answer_a()
   if question_game_correct == "a" then
      self:setup_result("correct")
      self:issue_reward_money()
   else
      self:setup_result("wrong")
   end
end

function question_game:btn_answer_b()
   if question_game_correct == "b" then
      self:setup_result("correct")
      self:issue_reward_money()
   else
      self:setup_result("wrong")
   end
end

function question_game:btn_answer_c()
   if question_game_correct == "c" then
      self:setup_result("correct")
      self:issue_reward_money()
   else
      self:setup_result("wrong")
   end
end

function question_game:btn_answer_d()
   if question_game_correct == "d" then
      self:setup_result("correct")
      self:issue_reward_money()
   else
      self:setup_result("wrong")
   end
end

function question_game:select_random_question()
   local min_q, max_q = 1, question_game_q_count
   local rnd_q = "q_" .. string.sub(level.name(), 1, 1) .. "_cell_" .. math.random(min_q, max_q)
   for k, v in pairs(question_q_table) do
      if k ~= nil and k == rnd_q and dont_has_alife_info(k) then
         question_game_q_s = k
         question_game_q_h_f = true
      end
   end
   if question_game_q_h_f == false then
      if question_game_q_available > 0 and to_string(sgm_functions.check_section_condlist(question_game_ini, rnd_q, "cond", "true")) == "false" then
         self:select_random_question()
      end
   end
end

function question_game:select_random_advice()
   local min_a, max_a = 1, question_game_a_count
   local rnd_a = "a_" .. string.sub(level.name(), 1, 1) .. "_cell_" .. math.random(min_a, max_a)
   for k, v in pairs(question_a_table) do
      if k ~= nil and k == rnd_a and dont_has_alife_info(k) then
         question_game_a_s = k
         question_game_a_h_f = true
      end
   end
   if question_game_a_h_f == false then
      if question_game_a_available > 0 and to_string(sgm_functions.check_section_condlist(question_game_ini, rnd_a, "cond", "true")) == "false" then
         self:select_random_advice()
      end
   end
end

function question_game:btn_start_game()
   if question_game_q_available > 0 then
      question_game_stage = "begin"
      question_game_question_descr = self:get_question(question_game_q_s, "question")
      question_game_answer_a = self:get_question(question_game_q_s, "var_a")
      question_game_answer_b = self:get_question(question_game_q_s, "var_b")
      question_game_answer_c = self:get_question(question_game_q_s, "var_c")
      question_game_answer_d = self:get_question(question_game_q_s, "var_d")
      question_game_correct = self:get_question(question_game_q_s, "correct")
      question_game_q_h_f = false
   else
      self:show_message("st_question_game_less_available_text")
   end
end

function question_game:btn_continue_game()
   if question_game_q_available > 0 then
      question_game_question_number = question_game_question_number + 1
      question_game_stage = "next_question"
      question_game_question_descr = self:get_question(question_game_q_s, "question")
      question_game_answer_a = self:get_question(question_game_q_s, "var_a")
      question_game_answer_b = self:get_question(question_game_q_s, "var_b")
      question_game_answer_c = self:get_question(question_game_q_s, "var_c")
      question_game_answer_d = self:get_question(question_game_q_s, "var_d")
      question_game_correct = self:get_question(question_game_q_s, "correct")
      question_game_q_h_f = false
   else
      self:show_message("st_question_game_less_available_text")
   end
end

function question_game:parse_questions()
   local par_cond = "true"
   local par_question = ""
   local par_var_a = ""
   local par_var_b = ""
   local par_var_c = ""
   local par_var_d = ""
   local par_correct = ""
   local par_cost = -1
   local n = question_game_ini:line_count("questions_" .. level.name())
   question_game_q_count = n
   for i = 0, n - 1 do
      local result, id, value = question_game_ini:r_line("questions_" .. level.name(), i, "", "")
      if question_game_ini:section_exist(id) then
         local items_count = question_game_ini:line_count(id)
         local item_section = ""
         for i = 0, items_count - 1 do
            result, item_section, str = question_game_ini:r_line(id, i, "", "")
            if item_section == "cond" then
               par_cond = to_string(sgm_functions.check_section_condlist(question_game_ini, id, "cond", "false"))
            elseif item_section == "question" then
               par_question = game.translate_string(str)
            elseif item_section == "var_a" then
               par_var_a = game.translate_string(str)
            elseif item_section == "var_b" then
               par_var_b = game.translate_string(str)
            elseif item_section == "var_c" then
               par_var_c = game.translate_string(str)
            elseif item_section == "var_d" then
               par_var_d = game.translate_string(str)
            elseif item_section == "correct" then
               par_correct = str
            elseif item_section == "cost" then
               par_cost = to_number(sgm_functions.check_section_condlist(question_game_ini, id, "cost", 10))
            end
         end
         if par_cond == "true" and ((question_q_table[id] == nil or question_q_table[id].question == nil) or (question_q_table[id] ~= nil and question_q_table[id].question == nil)) then
            question_q_table[id] = {}
            if par_question == "" then
               question_q_table[id].question = game.translate_string("st_" .. id .. "_descr")
            else
               question_q_table[id].question = par_question
            end
            if par_var_a == "" then
               question_q_table[id].var_a = game.translate_string("st_" .. id .. "_a")
            else
               question_q_table[id].var_a = par_var_a
            end
            if par_var_b == "" then
               question_q_table[id].var_b = game.translate_string("st_" .. id .. "_b")
            else
               question_q_table[id].var_b = par_var_b
            end
            if par_var_c == "" then
               question_q_table[id].var_c = game.translate_string("st_" .. id .. "_c")
            else
               question_q_table[id].var_c = par_var_c
            end
            if par_var_d == "" then
               question_q_table[id].var_d = game.translate_string("st_" .. id .. "_d")
            else
               question_q_table[id].var_d = par_var_d
            end
            if par_correct == "" then
               question_q_table[id].correct = "a"
            else
               question_q_table[id].correct = par_correct
            end
            if par_cost == -1 then
               question_q_table[id].cost = 10
            else
               question_q_table[id].cost = par_cost
            end
         end
      end
   end
   self:consider_available_questions()
end

function question_game:consider_available_questions()
   for k, v in pairs(question_q_table) do
      if k ~= nil and dont_has_alife_info(k) then
         question_game_q_available = question_game_q_available + 1
      end
   end
end

function question_game:parse_advices()
   local par_cond = "true"
   local par_advice = ""
   local par_items = nil
   local par_reward_money = -1
   local n = question_game_ini:line_count("advices_" .. level.name())
   question_game_a_count = n
   for i = 0, n - 1 do
      local result, id, value = question_game_ini:r_line("advices_" .. level.name(), i, "", "")
      if question_game_ini:section_exist(id) then
         local items_count = question_game_ini:line_count(id)
         local item_section = ""
         for i = 0, items_count - 1 do
            result, item_section, str = question_game_ini:r_line(id, i, "", "")
            if item_section == "cond" then
               par_cond = to_string(sgm_functions.check_section_condlist(question_game_ini, id, "cond", "false"))
            elseif item_section == "advice" then
               par_advice = game.translate_string(str)
            elseif item_section == "reward_money" then
               par_reward_money = to_number(sgm_functions.check_section_condlist(question_game_ini, id, "reward_money",
                  500))
            elseif item_section == "items" then
               par_items = str
            end
         end
         if par_cond == "true" and ((question_a_table[id] == nil or question_a_table[id].advice == nil) or (question_a_table[id] ~= nil and question_a_table[id].advice == nil)) then
            question_a_table[id] = {}
            if par_advice == "" then
               question_a_table[id].advice = game.translate_string("st_" .. id .. "_descr")
            else
               question_a_table[id].advice = par_advice
            end
            if par_reward_money == -1 then
               question_a_table[id].reward_money = 500
            else
               question_a_table[id].reward_money = par_reward_money
            end
            local place_param = sgm_functions.check_section_comma(question_game_ini, id, "place", nil, 5)
            question_a_table[id].place_x = tonumber(place_param[1])
            question_a_table[id].place_y = tonumber(place_param[2])
            question_a_table[id].place_z = tonumber(place_param[3])
            question_a_table[id].place_lv = tonumber(place_param[4])
            question_a_table[id].place_gv = tonumber(place_param[5])
            question_a_table[id].items = par_items
         end
      end
   end
   self:consider_available_advices()
end

function question_game:consider_available_advices()
   for k, v in pairs(question_a_table) do
      if k ~= nil and dont_has_alife_info(k) then
         question_game_a_available = question_game_a_available + 1
      end
   end
end

function question_game:get_question(section_id, param)
   if question_q_table[section_id] ~= nil and question_q_table[section_id][param] ~= nil then
      return question_q_table[section_id][param]
   end
   return "nil"
end

function question_game:get_advice(section_id, param)
   if question_a_table[section_id] ~= nil and question_a_table[section_id][param] ~= nil then
      return question_a_table[section_id][param]
   end
   return "nil"
end

function question_game:btn_manual()
   self:show_message("st_question_game_manual_text")
end