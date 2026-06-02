-- https://m4xshen.dev/posts/build-your-modern-neovim-config-in-lua
-- nvim search for lua
--
-- Setting for python noteboke-like
vim.g.python3_host_prog=vim.fn.stdpath("config") .. "/neovim/Scripts/python.exe"

require("config.options")
require("config.mappings")
require("config.autocmds")
require("config.lazy")
-- require("skeletons")
