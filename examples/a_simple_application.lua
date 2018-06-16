local kolba = require("kolba")

local config = {
	host="localhost",
	port=7070,
	is_dev=true
}

app = kolba.create(config)

local index = function()
	return {200, "text/plain", "Hello, World!"}
end

local index2 = function()
	return {200, "text/plain", "Hello2, World2!222"}
end

app.route("GET", "^/.+$", index)
app.route("GET", "^/hello$", index2)


app.run()
