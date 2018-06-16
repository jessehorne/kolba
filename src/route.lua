local route = {}

route.routes = {}

function route.add(method, path, body)
	local _r = {
		method=method,
		path=path,
		body=body
	}

	table.insert(route.routes, _r)

	return true
end

function route.match(method, uri)
	-- Check if a route exists that matches method and uri
	-- Returns the callback or string assigned to the route

	local existing = false

	for i,v in ipairs(route.routes) do
		local the_same = uri == v.path
		if (the_same or string.match(uri, "^" .. v.path .. "$")) and method == v.method then
			return v.body()
		end
	end
end

return route
