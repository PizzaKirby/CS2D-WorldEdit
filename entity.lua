entity = { }
entity.__index = entity
entity.__metatable = "None of your business"

function entity:new()
	local t =	{
					data = 
					{
						int = {},
						string = {}
					}
				}
	return setmetatable(t,entity)
end

function entity.setname(self,s)
	self.data.name = s or ""
end

function entity.getname(self)
	return self.data.name
end

function entity.settype(self,b)
	self.data.type = b or 0
end

function entity.gettype(self)
	return self.data.type
end

function entity.setx(self,i)
	self.data.x = i or 0
end

function entity.getx(self)
	return self.data.x
end

function entity.sety(self,i)
	self.data.y = i or 0
end

function entity.gety(self)
	return self.data.y
end

function entity.settrigger(self,s)
	self.data.trigger = s or ""
end

function entity.gettrigger(self)
	return self.data.trigger
end

function entity.addstr(self,s)
	table.insert(self.data.string,s or "")
end

function entity.getstr(self,i)
	return self.data.str[i]
end

function entity.addint(self,i)
	table.insert(self.data.int,i or 0)
end

function entity.getint(self,i)
	return self.data.int[i]
end	

function entity.__tostring(self)
	str = self.data.name.."\n"..self.data.type..self.data.x..self.data.y..self.data.trigger.."\n"	
	for i = 1,10 do
		str = str..self.data.int[i]..self.data.string[i].."\n"
	end	
	return str
end

function entity.copy(self)
end