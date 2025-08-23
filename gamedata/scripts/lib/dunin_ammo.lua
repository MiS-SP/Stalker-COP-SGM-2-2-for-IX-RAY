--/юбрнп: Dunin
local _M = {}
local ammo = {}
local repack = false
local packet = net_packet()
function _M.on_take(obj)
	local section = obj:section()
	if not ammo[section] then
		ammo[section] = {}
		ammo[section].repack = false
		ammo[section].box = system_ini():r_u32(section, "box_size")

	end
	if ammo[section].box > 1 then
		if ammo[section].repack == false then
			if _M.get_ammo_size(obj) < ammo[section].box then
				ammo[section].repack = true
				repack = true
			end
		end
	end
end
function _M.on_update()
	if repack then
		for section, data in pairs(ammo) do
			if data.repack then
				_M.repack_ammo(section, data.box)
				data.repack = false
			end
		end
		repack = false
	end
end
function _M.repack_ammo(section, box_size)
	local s, t = _M.enum_ammo(section, box_size)
	if s > 0 then
		if #t > 1 then
			local i, id
			local sim = alife()
			local pos = db.actor:position()
			local lvid = db.actor:level_vertex_id()
			local gvid = db.actor:game_vertex_id()
			local pid = db.actor:id()
			for i, id in pairs(t) do
				sim:release(sim:object(id), true)
			end
			while s >= box_size do
				s = s - box_size
				sim:create_ammo(section, pos, lvid, gvid, pid, box_size)
			end
			if s > 0 then
				sim:create_ammo(section, pos, lvid, gvid, pid, s)
			end
		end
	end
end
function _M.enum_ammo(section, box_size)
	local i, obj, size
	local s = 0
	local t = {}
	for i=0, db.actor:object_count()-1 do
		obj = db.actor:object(i)
		if obj:section() == section then
			size = _M.get_ammo_size(obj)
			if size < box_size then
				table.insert(t, obj:id())
				s = s + size
			end
		end
	end
	return s, t
end
function _M.get_ammo_size(obj)
	local se_obj = alife():object(obj:id())
	packet:w_begin(0)
	se_obj:STATE_Write(packet)
	packet:r_seek(packet:w_tell() - 2)
	return packet:r_s16()

end
function _M.read_ammo(packet)
	local st = {}
	st.game_vertex_id	= packet:r_u16()
	st.distance		= packet:r_float()
	st.direct_control	= packet:r_s32()
	st.level_vertex_id	= packet:r_s32()
	st.object_flags		= packet:r_s32()
	st.custom_data		= packet:r_stringZ()
	st.story_id		= packet:r_s32()
	st.spawn_story_id	= packet:r_s32()
	st.visual_name		= packet:r_stringZ()
	st.visual_flags		= packet:r_u8()
	st.condition		= packet:r_float()
	st.ammo_left		= packet:r_u16()
	return st
end
function _M.write_ammo(packet, st)
	packet:w_u16(st.game_vertex_id)
	packet:w_float(st.distance)
	packet:w_s32(st.direct_control)
	packet:w_s32(st.level_vertex_id)
	packet:w_s32(st.object_flags)
	packet:w_stringZ(st.custom_data)
	packet:w_s32(st.story_id)
	packet:w_s32(st.spawn_story_id)
	packet:w_stringZ(st.visual_name)
	packet:w_u8(st.visual_flags)
	packet:w_float(st.condition)
	packet:w_u16(st.ammo_left)
end

return _M