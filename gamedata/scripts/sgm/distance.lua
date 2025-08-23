---==================================================================================================---
--------------------------------------------------------------------------------------------------------
---------------------------------------(���� ��������� ��������)----------------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---
local Class = require('gamedata.scripts.lib.oop').Class
local Distance = Class()
Distance.level_name = level.name()
Distance.actor_pos = db.actor:position()

function Distance:update()
   if self.level_name == "zaton" then
      if dont_has_alife_info("zat_bandit_base_actor_hit") and dont_has_alife_info("zat_bandit_base_payment") and self.actor_pos:distance_to(vector():set(388.681, 32.518, 37.660), 1606246, 71) <= 150 then
         local zat_bandit_base_zone_0 = self.actor_pos:distance_to_sqr(vector():set(388.681, 32.518, 37.660), 1606246, 71) <
         10
         local zat_bandit_base_zone_1 = self.actor_pos:distance_to_sqr(vector():set(387.243, 32.654, 43.606), 1604098, 71) <
         10
         local zat_bandit_base_zone_2 = self.actor_pos:distance_to_sqr(vector():set(389.121, 32.479, 30.533), 1607317, 71) <
         10
         local zat_bandit_base_zone_3 = self.actor_pos:distance_to_sqr(vector():set(437.539, 35.785, -56.663), 1684130, 222) <
         10
         local zat_bandit_base_zone_4 = self.actor_pos:distance_to_sqr(vector():set(419.485, 35.904, -61.586), 1653169, 222) <
         10
         local zat_bandit_base_zone_5 = self.actor_pos:distance_to_sqr(vector():set(405.791, 35.543, -59.612), 1633369, 222) <
         10
         local zat_bandit_base_zone_6 = self.actor_pos:distance_to_sqr(vector():set(379.097, 34.036, -58.918), 1592280, 72) <
         10
         local zat_bandit_base_zone_7 = self.actor_pos:distance_to_sqr(vector():set(376.675, 34.314, -47.738), 1588241, 72) <
         10
         local zat_bandit_base_zone_8 = self.actor_pos:distance_to_sqr(vector():set(377.891, 34.310, -13.243), 1590269, 294) <
         10
         local zat_bandit_base_zone_9 = self.actor_pos:distance_to_sqr(vector():set(377.548, 34.314, 4.468), 1589288, 294) <
         10
         local zat_bandit_base_zone_10 = self.actor_pos:distance_to_sqr(vector():set(382.336, 33.434, 17.109), 1596614, 71) <
         10
         local zat_bandit_base_zone = zat_bandit_base_zone_0 or zat_bandit_base_zone_1 or zat_bandit_base_zone_2 or
         zat_bandit_base_zone_3 or zat_bandit_base_zone_4 or zat_bandit_base_zone_5 or zat_bandit_base_zone_6 or
         zat_bandit_base_zone_7 or zat_bandit_base_zone_8 or zat_bandit_base_zone_9 or zat_bandit_base_zone_10
         if zat_bandit_base_zone then
            give_info("zat_bandit_base_actor_hit")
         end
      end
      local zat_chimera_zagon_zone = self.actor_pos:distance_to_sqr(vector():set(144.097, -7.341, 183.857), 1212743, 186) < 7
      if dont_has_alife_info("zat_chimera_zagon_began") and zat_chimera_zagon_zone then
         give_info("zat_chimera_zagon_began")
         create("zat_roundup_stalker", 178.450, -7.480, 181.624, 1271518, 225)
         create_dead_body("chimera_dead_body", nil, 180.618, -6.959, 200.756, 1275019, 185)
      end
   end
   if self.level_name == "jupiter" then
      if dont_has_alife_info("jup_killer_base_actor_hit") and dont_has_alife_info("jup_killer_base_chief_payment") and self.actor_pos:distance_to(vector():set(187.908, 28.170, -427.741), 1035425, 610) <= 150 then
         local jup_killer_base_zone_0 = self.actor_pos:distance_to(vector():set(187.908, 28.170, -427.741), 1035425, 610) <
         12.0
         local jup_killer_base_zone_1 = self.actor_pos:distance_to(vector():set(232.566, 28.124, -432.624), 1112825, 342) <
         12.5
         local jup_killer_base_zone_2 = self.actor_pos:distance_to(vector():set(228.449, 28.155, -460.556), 1106007, 342) <
         12.5
         local jup_killer_base_zone_3 = self.actor_pos:distance_to(vector():set(241.843, 28.287, -443.731), 1126894, 342) <
         12.5
         local jup_killer_base_zone = jup_killer_base_zone_0 or jup_killer_base_zone_1 or jup_killer_base_zone_2 or
         jup_killer_base_zone_3
         if jup_killer_base_zone then
            give_info("jup_killer_base_actor_hit")
         end
      end
      if has_alife_info("jup_avoid_witnesses_start") and dont_has_alife_info("jup_avoid_witnesses_alarm") then
         local jup_witnesses_zone = self.actor_pos:distance_to_sqr(vector():set(307.501, 28.824, -138.640), 1213020, 535) < 5
         if jup_witnesses_zone then
            give_info("jup_avoid_witnesses_alarm")
         end
      end
   end
   if self.level_name == "darkvalley" then
      make_teleport_control_zone(-218.231, 2.204, -187.801, 979, 1087, 18.0, -171.381, 2.4373, -181.533, 2.00)
      make_teleport_control_zone(-170.923, 5.443, -304.867, 3961, 1097, 12.0, -152.959, 1.374, -316.281, 2.00)
      make_teleport_control_zone(122.703, -2.870, -256.941, 291699, 988, 2.5, 123.29345703125, -2.8414762020111,
         -266.95825195313, 3.44)
      if dont_has_alife_info("val_issue_secret_data_complete") then
         make_teleport_control_zone(-44.484, 0.432, -547.633, 119640, 1080, 6.5, -47.597, 0.434, -538.450, -0.02)
      end
      if has_alife_info("val_assault_factory_squad_passed_bridge") and dont_has_alife_info("val_assault_factory_garrison_alarmed") then
         local val_b1_zone = self.actor_pos:distance_to(vector():set(104.361, 0.153, -257.862), 272721, 953) <= 8
         if val_b1_zone then
            give_info("val_assault_factory_garrison_alarmed")
         end
      end
   end
   if self.level_name == "l04u_labx18" then
      make_teleport_control_zone(-0.431, 9.323, -9.036, 2678, 1173, 0.5, -2.545, 9.318, -6.698, 0.97)
   end
   if self.level_name == "military" then
      make_teleport_control_zone(70.577, -13.868, 395.091, 345999, 1319, 20.0, 57.009, -17.717, 364.353, 2.82)
   end
   if self.level_name == "agroprom" then
      make_teleport_control_zone(284.914, 0.319, 10.150, 373807, 1437, 5.0, 270.585, 0.308, -1.440, 1.84)
      make_teleport_control_zone(258.451, 3.014, -250.265, 363395, 1439, 5.0, 246.320, 2.250, -253.894, 1.64)
      if dont_has_alife_info("agr_find_underground_way_start") then
         make_teleport_control_zone(49.70373916626, -4.138, -283.903, 193576, 1523, 12.0, 72.392, -1.245, -257.772, 3.73)
      end
   end
   if self.level_name == "red_forest" then
      make_teleport_control_zone(262.203, -1.422, -313.459, 155509, 2120, 5.0, 252.624, -1.431, -309.846, 1.189)
   end
end

return Distance
-------------------------------------//Copyright GeJorge//-------------------------------------------------
