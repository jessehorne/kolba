<p align="center">
	<img src="assets/kolba_blue_1_small.png" height="130">
</p>

---

<p align="center"><i>Kolba is a fast, minimal, web framework for Lua.</i></p>

---

![version](https://img.shields.io/badge/version-0.1.0-red.svg)
[![MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
![IRC](https://img.shields.io/badge/irc.freenode.net-%23kolba-lightgrey.svg)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/jessehorne/kolba/issues)

# Try it
<pre><code><b>~$ </b>sudo apt-get install luarocks
<b>~$ </b>sudo luarocks install kolba
<b>~$ </b>lua5.3
Lua 5.3.3  Copyright (C) 1994-2016 Lua.org, PUC-Rio
<b>> </b>kolba = require("kolba")
<b>> </b>app = kolba.create()
<b>> </b>app.route("GET", "/", "Hello, World!")
<b>> </b>app.run()
The kolba development server is running on port 7000
</code>
</pre>

# Ways to contribute

### Code
- Star the project
- Report a bug or suggest an enhancement by creating an issue
- Fork the repository and create a pull request
- Use kolba to build something and then tell the world!

# Useful links
- [OWASP Secure Web Application Framework Manifesto](https://www.owasp.org/index.php/Projects/OWASP_Secure_Web_Application_Framework_Manifesto/Releases/Current/Manifesto)
- [GitHub's Open Source Guide](https://opensource.guide/)
- [lua-http Documentation](https://daurnimator.github.io/lua-http/0.2/)
- [LuaRocks](https://luarocks.org/)
- [Official Lua Website](https://www.lua.org/)
- [Semantic Versioning](https://semver.org/)
- [LuaRocks Style Guide](https://github.com/luarocks/lua-style-guide)
