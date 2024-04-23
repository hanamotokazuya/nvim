local status, indent = pcall(require, 'ibl')
if not status then return end

local opts = { }

indent.setup(opts)
