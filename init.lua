-- mac doesnt' load dylib libraries by default
table.insert(vim._so_trails, "/?.dylib")

require("options")
require("abbrevs")
require("keymaps")
require("macros")
require("autocmds")

require("lazyplug")
