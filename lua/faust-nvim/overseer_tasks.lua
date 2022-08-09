local status, overseer = pcall(require, 'overseer')

if status then
	-- Build
	overseer.register_template({
		name = "faust2sc",
		builder = function(params)
			return {
				cmd = {'faust2sc.py'},
				args = {"-s", vim.fn.expand("%")},
				name = "faust2sc",
				cwd = "",
				env = {},
				components = {
					"default",
					{"on_output_parse", parser = {
						-- Put the parser results into the 'diagnostics' field on the task result
						diagnostics = {
							-- Extract fields using lua patterns
							{
								"extract",
								"^([^%s].+) : (%d+) : (.+)$",
								"filename",
								"lnum",
								"text"
							},
						}
					}},
					{"on_result_diagnostics",
						remove_on_restart = true,
					},
					{"on_result_diagnostics_quickfix",
						open = true
					}
				},
				metadata = {},
			}
		end,
		desc = "Compile Faust file as SuperCollider plugin",
		tags = {overseer.TAG.BUILD},
		params = { },
		priority = 50,
		condition = {
			filetype = {"dsp", "faust"},
		},
	})
end
