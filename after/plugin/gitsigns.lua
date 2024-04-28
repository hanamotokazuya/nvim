local status, gitsigns = pcall(require, 'gitsigns')
if not status then return end

gitsigns.setup()

local status2, scrollbar_gitsigns_handler = pcall(require, 'scrollbar.handlers.gitsigns')
if not status2 then return end

scrollbar_gitsigns_handler.setup()

