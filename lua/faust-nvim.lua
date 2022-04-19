local M = {}

local browser = vim.g.faust_browser or "firefox"
local faustexamples = vim.g.faust_examples_dir or "/usr/share/faust/examples"
vim.g.faust2appls_dir = vim.g.faust2appls_dir or "/bin/"
vim.g.faustlib_dir = vim.g.faustlib_dir or "/usr/share/faust/"
local api = vim.api
local vimcmd = api.nvim_command
local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

U = require("faust-nvim.utils")

if fn.has "nvim-0.7" == 1 then
    if vim.g.do_filetype_lua == 1 then
        vim.filetype.add {
            extension = {
                dsp = "faust",
                lib = "faust"
            }
        }
        augroup("Faust", {clear = true})
        autocmd({"FileType"}, {
            pattern = "faust",
            callback = function ()
                require'faust-nvim'.load()
            end,
            group = "Faust"
        })
    else
        augroup("Faust", {clear = true})
        autocmd({"BufRead", "BufEnter", "BufNewFile"}, {
            pattern = "*.dsp",
            command = 'setfiletype faust',
            group = "Faust"
        })
        autocmd({"FileType"}, {
            pattern = "faust",
            callback = function ()
                require'faust-nvim'.load()
            end,
            group = "Faust"
        })
    end
else
    api.nvim_exec([[
    augroup Faust
    autocmd!
    autocmd BufRead,BufNewFile,BufEnter *.dsp setfiletype faust
    autocmd BufRead,BufNewFile,BufEnter *.lib setlocal filetype=faust
    autocmd FileType faust lua require'faust-nvim'.load()
    augroup END
    ]], true)
end

-- autocmd FileType faust setlocal commentstring=//\ %s

function M.load()
	-- Register commands
	require'faust-nvim/commands'
	require'faust-nvim/compiler'.register_command()
end

function M.load_snippets()
    local path = U.faust_nvim_root_dir .. U.path_sep .. "lua" .. U.path_sep .. "faust-nvim" .. U.path_sep .. "snippets"
    require("luasnip.loaders.from_lua").load({paths = path})
end

function M.terminal(cmd, precmd)
	local dothisfirst = precmd or "split"
	vimcmd(dothisfirst)
	vimcmd("terminal " .. cmd)
end

function M.silent_shell(cmd)
	vimcmd("silent exe '! " .. cmd .. " &'")
end

function M.shell(cmd)
	vimcmd("exe '! " .. cmd .. " &'")
end

-- ------------------
-- Docs
-- ------------------
function M.faustlibdocs()
	M.silent_shell(browser .. " https://faustlibraries.grame.fr/")
end

function M.faustcompilerdocs()
	M.silent_shell(browser .. " https://faustdoc.grame.fr/manual/compiler/")
end

function M.faust101()
	M.silent_shell(browser .. " https://faustdoc.grame.fr/workshops/2020-04-10-faust-101/")
end

function M.faustsyntax()
	M.silent_shell(browser .. " https://faustdoc.grame.fr/manual/syntax/")
end

-- ------------------
-- Misc
-- ------------------

function M.faustexamples()
	vim.cmd(":FZF " .. faustexamples)
end

-- ------------------
-- docs
-- ------------------

function M.generate_faust_docs()
	print("Generating faust documentation...")
	local plugin_dir=M.get_faust_nvim_root_dir()
	M.terminal(plugin_dir .. "/scripts/generate_helpfiles.sh " .. plugin_dir .. " " .. vim.g.faustlib_dir)

	-- @FIXME this results in tons of "duplicate tags" errors and so is silenced
	vim.cmd("silent! helptags " .. plugin_dir .. "/doc/doc")
end

function M.post_install()
	M.generate_faust_docs()
end

return M
