<p align="center">
	<img src="assets/kolba_blue_1_small.png" height="130">
</p>

<p align="center"><i>Kolba is a fast, minimal, web framework for Lua.</i></p>

<p align="center">
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/jessehorne/kolba/issues)
[![MIT](https://img.shields.io/packagist/l/doctrine/orm.svg)](LICENSE)
![version](https://img.shields.io/badge/version-0.1.0-red.svg)
</p>

# Try it
<pre><code><b>~$ </b>sudo apt-get install luarocks
<b>~$ </b>sudo luarocks install kolba
<b>~$ </b>lua5.3
Lua 5.3.3  Copyright (C) 1994-2016 Lua.org, PUC-Rio
<b>> </b>kolba = require("kolba")
<b>> </b>app = kolba.create()
<b>> </b>app.route("GET", "/", "Hello, World!")
<b>> </b>app.run()
Your kolba development server is running on port 7000
</code>
</pre>

# Ways to contribute

### Code
- Star the project
- Report a bug or suggest an enhancement by creating an issue
- Fork the repository and create a pull request
- Use kolba to build something and then tell the world!

### Communication
- Join #kolba on <i>Freenode</i>

### Funding
Donations will go towards web hosting for the project, domain name registration, caffeine, and so on.
[Buy me a coffee](ko-fi.com/kolbaproject)

# Useful links
- [OWASP Secure Web Application Framework Manifesto](https://www.owasp.org/index.php/Projects/OWASP_Secure_Web_Application_Framework_Manifesto/Releases/Current/Manifesto)
- [GitHub's Open Source Guide](https://opensource.guide/)
- [lua-http Documentation](https://daurnimator.github.io/lua-http/0.2/)
- [LuaRocks](https://luarocks.org/)
- [Official Lua Website](https://www.lua.org/)
- [Semantic Versioning](https://semver.org/)

# NOTE
If you're reading this, you're witnessing the birth of a brand new project. Stick around, things are going to change.
