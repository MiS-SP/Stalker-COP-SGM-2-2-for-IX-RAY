---==================================================================================================---
--------------------------------------------------------------------------------------------------------
-----------------------(Менеджер сохранения/загрузки важных переменных)---------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---
local Class = require('gamedata.scripts.lib.oop').Class
local SGMSaveManager = Class()
local instance = nil

function SGMSaveManager:init()
   self.statistic = {
      killed = {
         monsters = {
            bloodsucker = 0,
            boar = 0,
            burer = 0,
            chimera = 0,
            controller = 0,
            dog = 0,
            flesh = 0,
            gigant = 0,
            poltergeist = 0,
            pseudodog = 0,
            snork = 0,
            tushkano = 0,
            fracture = 0,
            cat = 0,
            zombie = 0
         },
         stalkers = {
            alfa = 0,
            army = 0,
            bandit = 0,
            dolg = 0,
            ecolog = 0,
            freedom = 0,
            killer = 0,
            monolith = 0,
            stalker = 0,
            rasvet = 0,
            renegade = 0,
            zombied = 0,
            night_stalker = 0
         },
      },
      trader = {
         orders = {
            zat_stalker_trader = "none",
            zat_stalker_trader_t = 0,
            zat_bandit_trader = "none",
            zat_bandit_trader_t = 0,
            jup_freedom_trader = "none",
            jup_freedom_trader_t = 0,
            jup_rasvet_trader = "none",
            jup_rasvet_trader_t = 0,
            jup_ecolog_trader = "none",
            jup_ecolog_trader_t = 0,
            jup_killer_trader = "none",
            jup_killer_trader_t = 0,
            pri_army_trader = "none",
            pri_army_trader_t = 0,
            pri_monolith_trader = "none",
            pri_monolith_trader_t = 0,
            mil_b7_trader = "none",
            mil_b7_trader_t = 0,
            esc_stalker_trader = "none",
            esc_stalker_trader_t = 0,
            mar_stalker_trader = "none",
            mar_stalker_trader_t = 0,
            val_b2_trader = "none",
            val_b2_trader_t = 0
         }
      }
   }
   self.dependancy = {
      battery = require("gamedata.scripts.sgm.battery")
   }
end

function SGMSaveManager:save(packet)
   for typeName, typeTable in pairs(self.statistic) do
      for entityName, entityTable in pairs(typeTable) do
         for k, v in pairs(entityTable) do
            if typeName == "trader" and entityName == "orders" then
               if find_in_string(k, "trader_t") then
                  packet:w_u32(v)
               else
                  packet:w_stringZ(v)
               end
            else
               packet:w_u32(v)
            end
         end
      end
   end
   for k, v in pairs(self.dependancy) do
      v:save(packet)
   end
end

function SGMSaveManager:load(packet)
   for typeName, typeTable in pairs(self.statistic) do
      for entityName, entityTable in pairs(typeTable) do
         for k, v in pairs(entityTable) do
            if typeName == "trader" and entityName == "orders" then
               if find_in_string(k, "trader_t") then
                  packet:r_u32(v)
               else
                  packet:r_stringZ(v)
               end
            else
               packet:r_u32(v)
            end
         end
      end
   end
   for k, v in pairs(self.dependancy) do
      v:load(packet)
   end
end

function get_instance()
   if instance == nil then
      instance = SGMSaveManager()
   end
   return instance
end

return get_instance()
-------------------------------------//Copyright GeJorge//-------------------------------------------------
