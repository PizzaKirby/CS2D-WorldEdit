mapdata = {}
mapdata.__index = mapdata
mapdata.__metatable = "None of your business"

function mapdata:new()
	local t = 	{
					data =	{
								tile_index = {},
								tile_modifier = {}
							}
				}
	return setmetatable(t,mapdata)
end

function mapdata.addindex(self,d)
	table.insert(self.data.tile_index,d)
end

function mapdata.addmodifier(self,d,extra,t) -- d : data , extra : extra data ? : t extra data in table ( ALWAYS a table )
	local data = 	{ 
						data = d,
						additional_data = t
					}
	table.insert(self.data.tile_modifier,data)
end