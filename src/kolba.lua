--[[ The beginning...

]]

kolba = {}

kolba.server = require("kolba.server")
kolba.template = require("kolba.template")
kolba.route = require("kolba.route")
kolba.browze = require("kolba.browze")

kolba.json = require("util.json")
kolba.mimetypes = require("mimetypes")
kolba.lfs = require("lfs")


kolba.create = function(conf)
	local _app = {}

	kolba.server.conf = conf

	_app.run = function()
		kolba.server:run()
	end

	-- Routing
	_app.route = function(method, path, body)
		kolba.route.add(method, path, body)
	end


	-- Request
	_app.request = {}

	_app.request.json = function()
		return kolba.server.body.get_json()
	end

	_app.request.body = function()
		return kolba.server.body.text
	end


	-- Helper
	_app.load_view = function(path)
		local file = io.open(path, "rb")

		if file then
			local contents = file:read("a")
			file:close()
			return {200, kolba.mimetypes.guess(path), contents}
		end
	end

	_app.set_public_dir = function(public_path)
		-- create routes for projects public/ directory?
		local path = kolba.lfs.currentdir() .. "/" .. public_path

		if not kolba.browze.exists(path) then return end -- exit if file doesn't exist.

		local files = kolba.browze.get_all_files(path)

		for i,v in ipairs(files) do
			local route = string.match(v, path .. "(/.+)$")

			_app.route("GET", route, function() return _app.load_view(v) end)
		end
	end

	_app.set_template_dir = function(path)
		kolba.template.folder = path
	end

	-- Template
	_app.template = function(name, model)
		local _view, err = kolba.template.view(name, model)
		if not _view then
			io.stderr:write("no view " .. err)
		end

		return _view
	end

	-- Init
	_app.set_template_dir("templates/")
	_app.set_public_dir("public")

	return _app
end

return kolba
