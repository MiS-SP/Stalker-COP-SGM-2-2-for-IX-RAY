local _M = {}

_M.loadSGM = function ()
    dofile("gamedata/scripts/sgm/globals/getter.lua")
    dofile("gamedata/scripts/sgm/globals/setter.lua")
    dofile("gamedata/scripts/sgm/globals/globalizer.lua")
    dofile("gamedata/scripts/sgm/globals/patcher.lua")
end

return _M
