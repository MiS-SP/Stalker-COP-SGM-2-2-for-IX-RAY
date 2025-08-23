---==================================================================================================---
--------------------------------------------------------------------------------------------------------
-------------------------(Система обязательных предметов и вознаграждений)------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---
local Class = require('gamedata.scripts.lib.oop').Class
local Rewarder = Class()
-- Повышение уровня торговли
function Rewarder.inc_trader_stage(val)
   local p_value = 1
   if val ~= nil then p_value = val end
   write_mod_param("trader_supplies_stage", read_mod_param("trader_supplies_stage") + p_value)
end
function Rewarder.check_trader_stage(completion,pre_1,pre_2)
   if dont_has_alife_info("t_s_b"..completion) and get_actor_rank()>=pre_1 and (pre_2==nil or (pre_2~=nil and get_actor_rank()<pre_2)) then
      give_info("t_s_b"..completion)
      -- todo проверить
      -- self.inc_trader_stage()
   end
end
function Rewarder.check_medal_reward(nominal,descr_num,reward_secrets)
   if get_actor_rank()>=nominal and dont_has_alife_info("medal_rank_"..nominal) then
      give_info("medal_rank_"..nominal)
      give_object_to_actor("medal_rank_"..nominal)
      news_manager.send_tip(db.actor,"st_medal_tip_text"..descr_num,0,"medal",8000,nil,"st_medal_tip_title")
      inc_mod_param("stat_medaley",1)
      give_secret(reward_secrets)
   end
end
function Rewarder:update()
   --//Награждение медалями//-->
   self.check_medal_reward(50,1,1)
   self.check_medal_reward(100,2,1)
   self.check_medal_reward(250,3,1)
   self.check_medal_reward(500,4,2)
   self.check_medal_reward(750,5,2)
   self.check_medal_reward(1000,6,2)
   self.check_medal_reward(1250,7,3)
   self.check_medal_reward(1500,8,3)
   self.check_medal_reward(1750,9,4)
   self.check_medal_reward(2000,10,5)
   --//Награждение повышением уровня торговли//-->
   if dont_has_alife_info("t_s_b_end") then
     self.check_trader_stage("1",10,50)
     self.check_trader_stage("2",50,100)
     self.check_trader_stage("3",100,150)
     self.check_trader_stage("4",150,200)
     self.check_trader_stage("5",200,250)
     self.check_trader_stage("6",250,300)
     self.check_trader_stage("7",300,350)
     self.check_trader_stage("8",350,400)
     self.check_trader_stage("9",400,450)
     self.check_trader_stage("10",450,500)
     self.check_trader_stage("11",500,550)
     self.check_trader_stage("12",550,600)
     self.check_trader_stage("13",600,650)
     self.check_trader_stage("14",650,700)
     self.check_trader_stage("15",700,750)
     self.check_trader_stage("16",750,800)
     self.check_trader_stage("17",800,850)
     self.check_trader_stage("18",850,950)
     self.check_trader_stage("19",950,1000)
     self.check_trader_stage("20",1000,2000)
     self.check_trader_stage("_end",2000)
   end
end

return Rewarder

-------------------------------------//Copyright GeJorge//-------------------------------------------------