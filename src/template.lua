local lustache = require("lustache")

local template = {}

template.folder = ""
template.views = {}

function template.view(name, model)
	local _view
	if not template.views[name] then
		_file = io.open(template.folder .. name .. ".html", "rb")
		_file_contents = _file:read("a")
		_view = lustache:render(_file_contents, model)
		_file:close()
	end

	return _view
end

return template
