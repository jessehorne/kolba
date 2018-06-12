![kolba logo](assets/kolba_blue_1_small.png)
======

``Kolba is a fast, minimal, web framework for Lua.``

**NOTE: It is also very young! There is a bit of work to do before I can recommend using it in a production environment. I welcome contributions.**

[>MIT licensed<](LICENSE)

# Try it
<pre>
<code><b>~$ </b>sudo apt-get install luarocks
<b>~$ </b>cd kolba
<b>~kolba$ </b>sudo luarocks make
<b>~/kolba$ </b>lua5.3
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
1. Star the project
2. Report a bug or suggest an enhancement by creating an issue
3. Fork the repository and create a pull request
4. Use kolba to build something and then tell the world!

### Communication
Join the projects IRC channel on Freenode. I want to hear your thoughts! `/join #kolba`

### Funding
Donations will go towards web hosting for the project, domain name registration, caffeine, and so on.
[Buy me a coffee](ko-fi.com/kolbaproject)

# Useful links
- [OWASP Secure Web Application Framework Manifesto](https://www.owasp.org/index.php/Projects/OWASP_Secure_Web_Application_Framework_Manifesto/Releases/Current/Manifesto)
- [GitHub's Open Source Guide](https://opensource.guide/)
- [lua-http Documentation](https://daurnimator.github.io/lua-http/0.2/)
- [LuaRocks](https://luarocks.org/)
- [Official Lua Website](https://www.lua.org/)

# TODO
1. Documentation
2. Contributing Guide
3. Style Guide
4. Code of Conduct
5. Launch website
6. Finish core features
7. Create showcase section and official showcase application
