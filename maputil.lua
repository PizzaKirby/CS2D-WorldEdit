local BIG_ENDIAN = false
local fFile = 0

local function b_to_i(str)
     if #str ~= 4 then return 0 end
     if BIG_ENDIAN then str = str:reverse() end
     return str:byte(1) + 256 * str:byte(2) + (256 ^ 2) * str:byte(3) + (256 ^ 3) * str:byte(4)
end

function readByte()
	return string.byte(fFile:read(1))
end

function readString()
	return fFile:read()
end

function readInt()
	local b = fFile:read(4)
	return b_to_i(b)
end

function testflag(set, flag)
  return set % (2*flag) >= flag
end

function openMap(path)
	return io.open(path,"rb")
end

function getheader()
	local h = header:new()
	h:adddata(readString())
	for i = 1,10 do
		h:adddata(readByte())
	end
	for i = 1,10 do
		h:adddata(readInt())
	end
	for i = 1,10 do
		h:adddata(readString())
	end
	h:adddata(readString())
	h:adddata(readString())
	h:adddata(readByte())
	h:adddata(readInt())
	h:adddata(readInt())
	h:adddata(readString())
	h:adddata(readInt())
	h:adddata(readInt())
	h:adddata(readByte())
	h:adddata(readByte())
	h:adddata(readByte())
	h:adddata(readString())

	return h
end

function getTiles(tile_count)
	local t = tilemode:new()
	--local tile_count = header_d:getdata("tiles_required")
	for i = 0,tile_count do
		t:adddata(readByte())
	end

	return t
end

function getMap(xsize,ysize,usemod)

	--local xsize = header_d:getdata("map_width")
	--local ysize = header_d:getdata("map_height")
	--local usemod = header_d:getdata("use_modifiers")

	local m = mapdata:new(xsize,ysize)

	for x = 0,xsize do
		for y = 0,ysize do
			m:addindex(x,y,readByte())
		end
	end

	if(usemod == 1) then
		for x = 0,xsize do
			for y = 0,ysize do			
				local data = readByte()

				local flag64 = testflag(data,64)
				local flag128 = testflag(data,128)
				
				if( flag64 or flag128 ) then
					local xdata = {}
					if( flag64 and flag128 ) then
						xdata[1] = readString()
					elseif( flag64 and not flag128 ) then
						xdata[1] = readByte()
					else
						xdata[1] = readByte()
						xdata[2] = readByte()
						xdata[3] = readByte()
						xdata[4] = readByte()
					end

					m:addmodifier(x,y,data,xdata)

				end
				--table.insert(data)
			end
		end
	end

	return m
end

function getEntites()
	local entity_count = readInt() -- || entities[1]
	local el = entitylist:new()

	for i = 1,entity_count do
		---
		e = entity:new()
		e:setname(readString())
		e:settype(readByte())
		e:setx(readInt())
		e:sety(readInt())
		e:settrigger(readString())

		for c = 1,10 do
			e:addint(readInt())
			e:addstr(readString())
		end

		el:addentity(e)
	end

	return el

end
--for x=0 to map_xsize; for y=0 to map_ysize;
function getmapdatamanager(path)
	local mdm = mapdatamanager:new()
	fFile = openMap(path)

	if(fFile) then
		mdm:setheader( getheader() ) --  confirmed working
		local h = mdm:getheader()

		local tile_count = h:getdata("tiles_required")
		mdm:settilemode( getTiles(tile_count) ) --   confirmed working

		local xsize = h:getdata("map_width")
		local ysize = h:getdata("map_height")
		local usemod = h:getdata("use_modifiers")
		mdm:setmapdata( getMap(xsize,ysize,usemod) ) --     confirmed working <- BS
		mdm:setentitylist( getEntites() ) -- confirmed working ( except metatable part 		)

		fFile:close()
	else
		return nil
	end
	return mdm
end


