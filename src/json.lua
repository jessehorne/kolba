local lunajson = require("lunajson")

local json = {}

function json.encode(lua_value)
	return lunajson.encode(lua_value)
end

function json.decode(json_string)
	return lunajson.decode(json_table)
end

return json
