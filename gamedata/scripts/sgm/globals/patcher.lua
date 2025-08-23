--' іроверка на инфопоршнv, даже если игрока не су	ествует
_G.has_alife_info = function(info_id)
    if not object_exists(db.actor, false) then
        return false
    end
    return alife():has_info(0, info_id)
end

local save_markers = {}

-- Функции для проверки корректности сейв лоад
_G.set_save_marker = function(p, mode, check, prefix)
    -- IX-Ray
    if save and not IsEditor() then
        save.set_stage(prefix)
    end
    -- END IX-Ray
    -- определяем ключ маркера.
    local result = ""
    --	if debug ~= nil then
    --		local info_table = debug.getinfo(2)
    --		local script_name = string.gsub(info_table.short_src, "%.script", "")
    --		script_name = string.gsub(script_name, "gamedata\\scripts\\", "")
    --		result = script_name
    --	end

    --	if prefix ~= nil then
    result = result .. "_" .. prefix
    --	end

    if check == true then
        if save_markers[result] == nil then
            abort("Trying to check without marker %s", result)
        end

        if mode == "save" then
            local dif = p:w_tell() - save_markers[result]
            printf(result .. ": SAVE DIF: %s", dif)
            if dif >= 8000 then
                printf("WARNING! may be this is problem save point")
            end
            if dif >= 10240 then
                -- IX-Ray
                callstack()

                if save and not IsEditor() then
                    save.call_error()
                end
                -- END IX-Ray
            end
            --/ SGM in
            if prefix == "actor_binder" then
                local r_s = p:w_tell() - save_markers[result]
                sgm_flags.value_pstor_factor = tonumber(r_s)
            end
            --/ SGM out
            p:w_u16(dif)
        else
            local c_dif = p:r_tell() - save_markers[result]
            local dif = p:r_u16()
            if dif ~= c_dif then
                abort("INCORRECT LOAD [%s].[%s][%s]", result, dif, c_dif)
            else
                printf(result .. ": LOAD DIF: %s", dif)
            end
        end
        return
    end

    if mode == "save" then
        printf(result .. ": set save marker: %s", p:w_tell())
        save_markers[result] = p:w_tell()
        if p:w_tell() > 16000 then
            abort("You are saving too much")
        end
    else
        printf(result .. ": set load marker: %s", p:r_tell())
        save_markers[result] = p:r_tell()
    end
end
local old_start_game_callback = _G.start_game_callback