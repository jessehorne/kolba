local kolba = require("kolba")

app = kolba.create()

function json_echo()
	return 200, "application/json", app.request.body()
end

app.route("GET", "/", "Hello, World!")

app.run()
