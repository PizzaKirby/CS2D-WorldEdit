header = {}
header.__index = header
header.__metatable = "None of your business"

function header:new()
	local t = 	{
					data_index = 1,
					data_type = 	{
										"s",
										"b",
										"b",
										"b",
										"b",
										"b",
										"b",
										"b",
										"b",
										"b",
										"b",
										"i",
										"i",
										"i",
										"i",
										"i",
										"i",
										"i",
										"i",
										"i",
										"i",
										"s",
										"s",
										"s",
										"s",
										"s",
										"s",
										"s",
										"s",
										"s",
										"s",
										"s",
										"s",
										"b",
										"i",
										"i",
										"s",
										"i",
										"i",
										"b",
										"b",
										"b",
										"s"
									},
					names = {
								"header",
								"scroll",
								"use_modifiers",
								"unused_byte_3",
								"unused_byte_4",
								"unused_byte_5",
								"unused_byte_6",
								"unused_byte_7",
								"unused_byte_8",
								"unused_byte_9",
								"unused_byte_10",
								"uptime",
								"usid",
								"unused_int_3",
								"unused_int_4",
								"unused_int_5",
								"unused_int_6",
								"unused_int_7",
								"unused_int_8",
								"unused_int_9",
								"unused_int_10",
								"author",
								"unused_string_2",
								"unused_string_3",
								"unused_string_4",
								"unused_string_5",
								"unused_string_6",
								"unused_string_7",
								"unused_string_8",
								"unused_string_9",
								"unused_string_10",
								"info_str",
								"tileset",
								"tiles_required",
								"map_width",
								"map_height",
								"bg_img",
								"bg_scroll_speed_x",
								"bg_scroll_speed_y",
								"bg_red",
								"bg_green",
								"bg_blue",
								"teststr"
							},
					data = {}
				}
	return setmetatable(t,header)
end

function header.adddata(self,d)
	if( not self:iscomplete() ) then
		self.data[self.names[self.data_index]] = d
		self.data_index = self.data_index + 1
	end
end

function header.setdata(self,s,d)
	self.data[s] = d
end

function header.getdata(self,s)
	return self.data[s]
end

function header.iscomplete(self)
	return self.data_index > #self.names
end

function header.getbintable(self)
	local data = {}
	if(self:iscomplete()) then
		for i = 1,#self.data do
			if(self.data_type[i] == "s") then

			elseif(self.data_type[i] == "b") then

			else(self.data_type[i] == "i") then

			end
			print(self.names[i].." | "..self.data_type[i])
		end
	end
end

function header.__tostring(self)
	if self:iscomplete() then
		for k,v in ipairs(self.names) do
			print(self.data[v])
		end
	end
end