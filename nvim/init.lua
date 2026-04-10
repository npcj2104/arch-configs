-- ~ / .config / nvim / init.lua

-- 1. LOAD SYSTEM OPTIONS
require("core.options")

-- 2. LOAD GLOBAL KEYMAPS
require("core.keymaps")

-- 3. INITIALIZE PLUGIN MANAGER (LAZY.NVIM)
require("config.lazy")
