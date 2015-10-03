entitylist = {}
entitylist.__index = entitylist
entitylist.__metatable = "None of your business"

function entitylist:new()
	local t = 	{
					count = 0,
					data = {}
				}
	return setmetatable(t,entitylist)
end

function entitylist.addentity(self,e)	
	self.count = self.count + 1
	self.data[self.count] = e
end

function entitylist.getlength(self)
	return self.count
end