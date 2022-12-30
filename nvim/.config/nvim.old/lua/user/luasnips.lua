local types = require("luasnip.util.types")

require'luasnip'.config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"●", "DiagnosticSignHint"}}
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "DiagnosticSignInfo"}}
			}
		}
	},
})
