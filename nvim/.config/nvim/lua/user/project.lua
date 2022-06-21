local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
	return
end
project.setup({
	-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
	detection_methods = { "pattern" },

	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Deseq2.R" },

	---@usage path to store the project history for use in telescope
  datapath = vim.fn.stdpath("data"),
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

telescope.load_extension('projects')
