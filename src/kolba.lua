--[[ The beginning...

This module provides everything for the developer utilizing this framework. It
returns something very important.

kolba - the central object, instanced by the user, giving convenient access to
routing, and more...

route(method, path, func) - Handles routing
run() - Starts the server loop, which makes the application accessible

]]

SERVER = require("kolba.server")
ROUTE = require("kolba.route")
TEMPLATE = require("kolba.template")
JSON = require("util.json")

local kolba = {}

kolba.create = function()
	local _app = {}

	_app.run = function()
		SERVER.run()
	end

	_app.route = function(method, path, callback)
		ROUTE:route(method, path, callback)
	end

	_app.request = {}
	_app.request.json = function()
		return SERVER.body.get_json()
	end
	_app.request.body = function()
		return SERVER.body.text
	end

	_app.template = function(name, model)
		local _view, err = TEMPLATE.view(name, model)
		if not _view then
			io.stderr:write(err)
		end

		io.stderr:write("hi " .. _view)
		return _view
	end

	return _app
end

return kolba
