tilemode = {}
tilemode.__index = tilemode
tilemode.__metatable = "None of your business"

function tilemode:new()
	local t = 	{
					data_index = 0,
					data = {}
				}
	return setmetatable(t,tilemode)
end

function tilemode.adddata(self,d)
	self.data[self.data_index] = d
	self.data_index = self.data_index + 1
end

function tilemode.getdata(self,i)
	return self.data[i]
end

function tilemode.setdata(self,i,d)
	self.data[i] = d
end

function tilemode.__tostring(self)
	for k,v in ipairs(self.data) do
		print(k.." | "..v)
	end
end