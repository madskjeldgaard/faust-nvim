local M = {}

local browser = vim.g.faust_browser or "firefox"
local mapkeys = vim.g.faust_default_keymaps or true
local scflags = vim.g.faust_compile_sc_flags or "-noprefix"
local scinstalldir = vim.g.faust_sc_install_dir or "$HOME/.local/share/SuperCollider/Extensions/Faust"

local api = vim.api
local vimcmd = api.nvim_command

function M.setup()
	-- Register commands
	require'faust-nvim/commands'

	-- Default keymaps
	-- if mapkeys == true then
	-- 	M.keymaps()
	-- end
end

function M.terminal(cmd, precmd)
	local dothisfirst = precmd or "split"
	vimcmd(dothisfirst)
	vimcmd("terminal " .. cmd)
end

function M.silent_shell(cmd)
	vimcmd("silent exe '! " .. cmd .. " &'")
end

-- ------------------
-- Compilation
-- ------------------
function M.faust2sc()
	M.terminal("faust2supercollider " .. scflags .. " %")
end

function M.faust2scinstall()
	local buildcmd = "faust2supercollider " .. scflags .. " %"
	local installcmd = "cp -v " .. vim.fn.expand("%:r") .. ".s[co] " .. scinstalldir
	M.silent_shell("mkdir " .. scinstalldir)
	M.terminal(buildcmd .. " && " .. installcmd)
end

-- ------------------
-- Docs
-- ------------------
function M.faustlibdocs()
	M.silent_shell(browser .. " https://faustlibraries.grame.fr/")
end

function M.faust101()
	M.silent_shell(browser .. " https://faustdoc.grame.fr/workshops/2020-04-10-faust-101/")
end

return M
