local M = {}
local compilers = require"faust-nvim/faust2appls"
local utils = require"faust-nvim/utils"
local action = require("fzf.actions").action

function M.fuzzy_compilers()
	coroutine.wrap(function()

		local preview = function(item)

			local helpcmd =  "faust2" .. item[1] .. " -h"

			if vim.g.faust2appls_dir then
				helpcmd = vim.g.faust2appls_dir .. helpcmd
			end

			local handle = io.popen(helpcmd)
			local cmdresult = handle:read("*a")
			handle:close()

			return cmdresult
		end

		local result = require'fzf'.fzf(
		M.get_faust2_names(), "--ansi --prompt 'faust2' --preview=" .. action(preview) .. " --preview-window right:50:wrap "
		);
		if result then
			M.load_command(result[1])
		end;
	end)();
end

function M.get_faust2_names()
	local keys = vim.tbl_keys(compilers)
	return keys
end

function M.load_command(...)
    local args = {...}

	local command = args[1]

	-- Remove command from argument list
	args = utils.slice(args, 2, #args+1, 1)

	if command ~= nil then
		-- FIXME: This is a hack. When the command is chosen using fuzzy_commands, vim will go into normal mode before opening up the chosen fuzzy finder.
		compilers[command](args)
	else
		M.fuzzy_compilers()
	end
end

function M.register_command()

vim.cmd[[
function s:faust2_complete(arg,line,pos)
	let l:commands = luaeval("require'faust-nvim.compiler'.get_faust2_names()")
    return join(sort(commands), "\n")
endfunction

command! -nargs=* -complete=custom,s:faust2_complete Faust2 lua require('faust-nvim.compiler').load_command(<f-args>)
]]

end

return M
