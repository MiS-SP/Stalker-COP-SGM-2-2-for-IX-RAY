---==================================================================================================---
--------------------------------------------------------------------------------------------------------
---------------------------------------(Загрузчик Sigerous MOD)-----------------------------------------
--------------------------------------------------------------------------------------------------------
---==================================================================================================---

local mt = {}
local instance = nil

SGMSYS = setmetatable({}, mt)
function mt.__call(self)
   self.saver = require("gamedata.scripts.sgm.save")
   return self
end

function SGMSYS:save(packet)
   self.saver:save(packet)
end

function SGMSYS:update()
   local updater = require("gamedata.scripts.sgm.updater")
   updater.update()
end

function SGMSYS:load(packet)
   self.saver:load(packet)
end

function get_instance()
   if instance == nil then
      instance = SGMSYS()
   end
   return instance
end

return get_instance()