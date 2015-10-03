mapdata = {}
mapdata.__index = mapdata
mapdata.__metatable = "None of your business"

--x size extension -> new tile_index/modifier[oldx + 1] -> [newx] = {}

function mapdata:new(xsize,ysize)
	local t = 	{
					xsize = xsize,
					ysize = ysize,
					data =	{
								tile_index = {},
								tile_modifier = {}
							}
				}
	for i = 0,xsize do
		t.data.tile_index[i] = {}
		t.data.tile_modifier[i] = {}
	end
	return setmetatable(t,mapdata)
end

function mapdata.addindex(self,x,y,d)
	self.data.tile_index[x][y] = d 
end

function mapdata.getindex(self,x,y)
	return self.data.tile_index[x][y]
end

function mapdata.addmodifier(self,x,y,d,t) -- d : data , extra : extra data ? : t extra data in table ( ALWAYS a table )
	local data = 	{ 
						data = d,
						additional_data = t
					}
	self.data.tile_modifier[x][y] = data 
end

function mapdata.getmodifier(self,x,y)
	return self.data.tile_modifier[x][y]
end

function mapdata.__tostring(self)
	for x = 0,self.xsize do
		for y = 0,self.ysize do
			print("x : "..x.." y : "..y.." "..self.data.tile_index[x][y])
		end
	end
end