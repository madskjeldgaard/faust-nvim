local M = {}

local browser = vim.g.faust_browser or "firefox"
local mapkeys = vim.g.faust_default_keymaps or true
local scinstalldir = vim.g.faust_sc_install_dir or "$HOME/.local/share/SuperCollider/Extensions/Faust"
local faustexamples = vim.g.faust_examples_dir or "/usr/share/faust/examples"

local api = vim.api
local vimcmd = api.nvim_command

function M.setup()
	-- Register commands
	require'faust-nvim/commands'
	require'faust-nvim/compiler'.register_command()

	-- If using Tim Pope's comment plugin
	vim.cmd([[autocmd FileType faust setlocal commentstring=//\ %s]])

	-- Set .lib filetypes to faust
	vim.cmd([[autocmd BufEnter *.lib setlocal filetype=faust]])

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

------------------
--- Table
------------------

--- Get table length
function M.tbl_len(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

------------------
--- Path
------------------

-- This stuff is from scnvim, thanks scnvim!
--- Get the system path separator
M.is_windows = vim.loop.os_uname().sysname:match('Windows')
M.path_sep = M.is_windows and '\\' or '/'

--- Get the root directory of the plugin.
-- FIXME: This only works if the plugin is inside of the pack path
function M.get_faust_nvim_root_dir()
  local package_path = debug.getinfo(1).source:gsub('@', '')
  package_path = vim.split(package_path, M.path_sep, true)
  -- find index of plugin root dir
  local index = 1
  for i, v in ipairs(package_path) do
    if v == 'faust-nvim' then
      index = i
      break
    end
  end
  local path_len = M.tbl_len(package_path)
  if index == 1 or index == path_len then
    error('[faust-nvim] could not find plugin root dir')
  end
  local path = {}
  for i, v in ipairs(package_path) do
    if i > index then
      break
    end
    path[i] = v
  end
  local dir = ''
  for _, v in ipairs(path) do
    -- first element is empty on unix
    if v == '' then
      dir = M.path_sep
    else
      dir = dir .. v .. M.path_sep
    end
  end
  assert(dir ~= '', '[faust-nvim] Could not get faust-nvim root path')
  dir = dir:sub(1, -2) -- delete trailing slash
  return dir
end

-- ------------------
-- docs
-- ------------------

function M.generate_faust_docs()
	print("Generating faust documentation...")
	local plugin_dir=M.get_faust_nvim_root_dir()
	M.terminal(plugin_dir .. "/scripts/generate_helpfiles.sh " .. plugin_dir)

	-- @FIXME this results in tons of "duplicate tags" errors and so is silenced
	vim.cmd("silent! helptags " .. plugin_dir .. "/doc/doc")
end

function M.post_install()
	M.generate_faust_docs()
end

return M
