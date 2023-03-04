require('kah.plugins-setup')
require('kah.core.options')
require('kah.core.keymaps')
require('kah.core.colorscheme')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"
local is_wsl = has "wsl"

if is_mac then
	require('kah.core.macos')
end
if is_win then
	require('kah.core.windows')
end
if is_wsl then
  require('kah.core.wsl')
end
