local lustache = require("lustache")

local template = {}

template.folder = "templates/"
template.views = {}

function template.view(name, model)
	if not template.views[name] then
		_file = io.open(template.folder .. name .. ".html", "rb")
		_file_contents = _file:read("a")
		_rendered = lustache:render(_file_contents, model)
		
		template.views[name] = _rendered

		_file:close()
	end

	return template.views[name]
end

return template
