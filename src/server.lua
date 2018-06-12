--[[ Manages incoming requests from the reverse proxy

more coming soon...

]]--

local http_server = require("http.server")
local http_headers = require("http.headers")

local server = {}
server.is_in_dev = true
server.port = 8080
server.stream = nil
server.method = nil

server.body = {}
server.body.json = nil
server.body.get_json = function()
	if not server.body.json then
		server.body.json = JSON.decode(server.body.text)
	end

	return server.body.json
end
server.body.text = nil
server.body.get_text = function() return server.body.text end

server.response = {}
server.response.headers = http_headers.new()

server.onstream = function(serv, stream)
	server.stream = stream

	local _headers = stream:get_headers()
	local _method = _headers:get(":method")
	local _path = _headers:get(":path") or ""

	server.method = _method

	server.body.text = stream:get_body_as_string(1)

	-- Development Mode: Log request
	if server.is_in_dev then
		_pre = '[%s] "%s %s HTTP/%g" "%s" "%s"\n'

		local _dev_msg = {
			os.date("%d/%b/%Y:%M:%S %z"),
			_method or "",
			_path,
			stream.connection.version,
		   _headers:get("referer") or "-",
			_headers:get("user-agent") or "-"
		}

		local _dev_msg_print = string.format(_pre, table.unpack(_dev_msg))

		io.stderr:write(_dev_msg_print)
	end


	local _status, _type, _body = ROUTE:body(_method, _path)

	if type(_status) == "number" then
		_status = tostring(_status)
	end

	server.response.headers:append(":status", _status)
	server.response.headers:append("content-type", _type)

	stream:write_headers(server.response.headers, _method=="HEAD")

	if _method ~= "HEAD" then
		stream:write_chunk(_body, true)
	end
end

server.onerror = function(serv, ctx, op, err, errno)
	if server.is_in_dev then
		io.stderr:write(tostring(err) .. "\n")
	end
end

server.instance = http_server.listen({
	host="localhost",
	port=server.port,
	onstream=server.onstream,
	onerror=server.onerror
})

server.run = function()
	io.stderr:write("kolba is running your application in development mode on port " .. server.port .. "\n")
	assert(server.instance:listen())
	assert(server.instance:loop())
end

return server
