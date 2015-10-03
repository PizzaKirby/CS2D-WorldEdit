mapdatamanager = {}
mapdatamanager.__index = mapdatamanager
mapdatamanager.__metatable = "None of your business"

function mapdatamanager:new()
	local t = 	{
					data = 	{}
				}
	return setmetatable(t,mapdatamanager)
end

function mapdatamanager.setheader(self,h)
	self.data.header = h
end

function mapdatamanager.getheader(self)
	return self.data.header
end

function mapdatamanager.settilemode(self,tm)
	self.data.tilemode = tm
end

function mapdatamanager.gettilemode(self)
	return self.data.tilemode
end

function mapdatamanager.setmapdata(self,md)
	self.data.mapdata = md
end

function mapdatamanager.getmapdata(self)
	return self.data.mapdata
end

function mapdatamanager.setentitylist(self,el)
	self.data.entitylist = el
end

function mapdatamanager.getentitylist(self)
	return self.data.entitylist
end

function mapdatamanager.save(self,path)
	local f,e = io.open(path,"wb")
	if(f) then
		self:getheader():getbintable()
	else
		print(e)
	end
	--do all the save stuff
end