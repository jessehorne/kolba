--[[ Manages incoming requests from the reverse proxy

more coming soon...

]]--

local http_server = require("http.server")
local http_headers = require("http.headers")

local server = {}

server.body = {}
server.body.json = nil

function server.body.get_json()
	if not server.body.json then
		server.body.json = JSON.decode(server.body.text)
	end

	return server.body.json
end


server.body.text = nil
server.body.get_text = function() return server.body.text end


server.response = {}
server.response.headers = http_headers.new()


function server.onstream(serv, stream)
	local headers = stream:get_headers()

	local method = headers:get(":method")
	local path = headers:get(":path") or ""

	server.body.text = stream:get_body_as_string(1)


	if server.conf.is_dev then
		local pre = '[%s] "%s %s HTTP/%g" "%s" "%s"\n'

		local dev_msg = {
			os.date("%d/%b/%Y:%M:%S %z"),
			method or "",
			path,
			stream.connection.version,
		   headers:get("referer") or "-",
			headers:get("user-agent") or "-"
		}

		local dev_msg_print = string.format(pre, table.unpack(dev_msg))

		server.debug(dev_msg_print)
	end


	local route = kolba.route.match(method, path)
	local body = ""

	if route then
		headers:upsert(":status", tostring(route[1]))
		headers:upsert("content-type", route[2])
		body = route[3]
	else
		headers:upsert(":status", "404")
		body = "Route not found."
	end

	stream:write_headers(headers, method=="HEAD")


	if method ~= "HEAD" then
		stream:write_chunk(body, true)
	end
end


server.onerror = function(serv, ctx, op, err, errno)
	server.debug("[ERROR] " .. tostring(err))
end


server.debug = function(msg)
	if server.conf.is_dev then
		io.stderr:write("[DEBUG] " .. msg .. "\n")
	end
end


server.valid_config = function(conf)
	local ok = true
	local msgs = {}

	local valid_values = {
		"host",
		"port",
		"is_dev"
	}

	for i,v in ipairs(valid_values) do
		if not conf[v] then
			table.insert(msgs, v .. " is missing.")
			ok = false
		end
	end

	if not ok then
		for i,v in ipairs(msgs) do
			server.debug(v)
		end

		return
	end

	return ok
end

server.run = function(self, conf)

	local conf_is_valid = server.valid_config(server.conf)

	if not conf_is_valid then
		return false
	end

	server.debug("kolba is running in [development] mode on port " .. server.conf.port .. "!")

	server.instance = http_server.listen({
		host = server.conf.host,
		port = server.conf.port,
		onstream = server.onstream,
		onerror = server.onerror
	})

	server.instance:listen()
	server.instance:loop()
end

return server
