if not we then we = {} end

dofile("sys/lua/entity.lua")
dofile("sys/lua/header.lua")
dofile("sys/lua/tilemode.lua")
dofile("sys/lua/mapdata.lua")
dofile("sys/lua/entitylist.lua")
dofile("sys/lua/mapdatamanager.lua")
dofile("sys/lua/maputil.lua")

local settings = 	{
						"mp_hud 0",
						"sv_gm 2",
						"mp_roundtime 100",
						"mp_radar 0"
					}

for k,v in pairs(settings) do parse(v) end

we.pos = {}
we.image = {}
we.updaterate = 50
we.imagepath = "gfx/gui_c.bmp"
we.map = { tilex = map("xsize"), tiley = map("ysize") }

timer(we.updaterate,"we.requestdata","",0)
function we.requestdata(id,mode)
	reqcld(0,2)
end

mdm_current = getmapdatamanager("maps/"..map("name")..".map")
mdm = getmapdatamanager("maps/de_dust.map")
mdm2 = getmapdatamanager("maps/de_dust2.map")

mdm_current:save("maps/savetest.map")

for x = 0,mdm:getheader():getdata("map_width") do
	for y = 0,mdm:getheader():getdata("map_height") do
		parse("settile "..x.." "..y.." "..mdm:getmapdata():getindex(x,y))
	end
end
--print(ent_d[1]:getname())
--print(ent_d[1]:getx())
--print(ent_d[1]:gety())
--tostring(tiles_d)
--print(header_d:getdata("tiles_required"))
--print(header_d:getdata("teststr"))
--print(header_d:getdata("tileset"))
--print(header_d:getdata("use_modifiers"))
--print(map_d:getmodifier(1,1))
--table.foreach(header_d,function(k,v)print(k.." | "..v) end)
--table.foreach(tiles,function(k,v)print(k.." | "..v) end)
--table.foreach(map_d,function(k,v)print(k.." | "..v)end)
--table.foreach(map_m,function(k,v)print(k.." | "..v)end)
--for k,v in pairs(ent_m) do print("x : "..entity.getx(v).." y : "..entity.gety(v)) end


addhook("join","we.join")
function we.join(id)
	we.pos[id] = {}
	we.image[id] = image(we.imagepath,16,16,3,id)
	imagecolor(we.image[id],0,0,255)
	imagealpha(we.image[id],0.40)
end

addhook("use","we.use")
function we.use(id,event,data,tilex,tiley)
	--open contextmenu
end

addhook("spawn","we.spawn")
function we.spawn(id)
	parse('strip '..id..' 0')
	parse('equip '..id..' 5')
	parse('setweapon '..id..' 5')
	parse('setammo '..id..' 5 0 1')
end

addhook("reload","we.reload")
function we.reload(id,mode)
	if(player(id,"weapontype") == 5) then
		if(not (we.pos[id].tilex < 0 or we.pos[id].tiley < 0 or we.pos[id].tilex > we.map.tilex or we.pos[id].tiley > we.map.tiley)) then
			parse('setpos '..id..' '..we.pos[id].x..' '..we.pos[id].y)
		end
		parse('setweapon '..id..' 5')
	end
end

addhook("serveraction","we.serveraction")
function we.serveraction(id,action)
for x = 0,mdm2:getheader():getdata("map_width") do
	for y = 0,mdm2:getheader():getdata("map_height") do
		parse("settile "..x.." "..y.." "..mdm2:getmapdata():getindex(x,y))
	end
end

	if(action == 1) then
		parse('settile '..we.pos[id].tilex..' '..we.pos[id].tiley..' 1')
	end
end

addhook("drop","we.drop")
function we.drop(id,iid,type,ammo,sammo,mode,tilex,tiley)
	if(iid == 5) then
		return 1
	end
end

addhook("walkover","we.walkover")
function we.walkover(id,iid,type,ammo,sammo,mode)
	if(iid == 62) then
		return 1
	end
end

addhook("clientdata","we.clientdata")
function we.clientdata(id,mode,d1,d2)
	if(mode == 2) then
		we.pos[id].x = d1
		we.pos[id].y = d2
		we.pos[id].tilex = math.floor(d1 / 32)
		we.pos[id].tiley = math.floor(d2 / 32)
		imagepos(we.image[id], we.pos[id].tilex * 32 + 16,we.pos[id].tiley * 32 + 16, 0)
	end
end