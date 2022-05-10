return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,  --pops up qickfix on 'gd' in lua if on
				},
			},
      telemetry = {
        enable = false,
      },
		},
	},
}
