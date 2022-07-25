local cmd = vim.cmd
local fn = vim.fn

local M = {}

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
	return s ~= nil and s ~= ""
end

return M
