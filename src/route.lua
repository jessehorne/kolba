--[[ Assists server.lua to manage the routing of requests effectively

TODO
	- The current version of this is extremely simply. More efficient routing should
	  be implemented in the future.

Routing

A route will be split by forward slashes (/).
	- "/hello" will become {"/hello"}
	- "/hello/world" will become {"/hello", "/world"}

Variables are matched using "<%l+>", which is any series of lower case letters
inbetween a less-than and greater-than symbol.
	- "/<hello>" will become {"/<hello>"}
	- "<hello>" can be any alphanumeric string. Examples are...
		- /1
		- /123
		- /hello
		- /hElLo
		- /hello123
		- /123hello

If a request is made to "/hello/1", it will run the callback associated with the
route that matches its table-conversion ({"/hello", "/1"}). The proper route to
define is "/hello/<varname>". "/hello/<varname>" will be stored as a table whose
value is {"/hello", "/<varname>"}.

No route can be matched with a path whose table-conversion does not have the
same number of values.
	- #{"/hello", "/<varname>"} == 2
	- #{"/hello", "/1"} == 2
	- "/1" == "/%w+"
	- "/<varname>" == "^/<%l+>$"

]]--

local route = {}

route.routes = {}

route.route = function(self, method, path, callback)
	local _methods = {"GET", "POST", "PUT", "HEAD", "DELETE", "PATCH", "OPTIONS"}
	local _method_is_valid = false

	-- Validate Method
	for i, v in ipairs(_methods) do
		if v == method then
			_method_is_valid = true
			break
		end
	end

	if not _method_is_valid then
		io.stderr:write("INVALID METHOD: " .. method .. "!\n")
		io.stderr:write("Attempted to create a route with an invalid method.\n")
		return
	end

	-- Break path into table
	local _path_table = {}

	if path == "/" then
		table.insert(_path_table, path)
	end

	for _piece in string.gmatch(path, "/[^/]+") do
		table.insert(_path_table, _piece)
	end

	local _route = {
		method=method,
		path=_path_table,
		callback=callback
	}

	table.insert(self.routes, _route)
end

route.body = function(self, method, path)
	local _callback_args = {}

	-- split request path
	local _req_path = {}

	if path == "/" then
		table.insert(_req_path, path)
	end

	for _req_piece in string.gmatch(path, "/[^/]+") do
		table.insert(_req_path, _req_piece)
	end

	-- loop through the routes created by the application
	for _r, _route in ipairs(self.routes) do
		local _paths_match = true

		if #_route.path == #_req_path then
			if _route.method == method then

				for _p, _route_piece in ipairs(_route.path) do
					if _route_piece ~= _req_path[_p] then
						if _route_piece == string.match(_route_piece, "^/<%l+>$") then
							local _arg = {}
							_arg_name = string.match(_route_piece, "^/<(%l+)>$")
							_arg_value = string.match(_req_path[_p], "^/([^/]+)$")

							_callback_args[_arg_name] = _arg_value
						else
							_paths_match = false
						end
					end
				end

				if _paths_match then
					if type(_route.callback) == "string" then
						return 200, "text/plain", _route.callback
					end

					if _callback_args then
						return _route.callback(_callback_args)
					else
						return _route.callback()
					end
				end

			end
		end
	end

	return 404, "text/plain", "no route found."
end

return route
