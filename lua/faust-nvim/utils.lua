local M = {}

-- Turn lines into one long string with spaces between each item
function M.flatten_to_string(lines_table, keep_linebreaks)
	local outstring = ""
	for _, line in pairs(lines_table) do
		outstring = outstring .. " " .. line
		if keep_linebreaks then
			outstring = outstring .. "\n"
		end
	end

	return outstring
end

function M.slice(tbl, first, last, step)
	local sliced = {}

	for i = first or 1, last or #tbl, step or 1 do
	sliced[#sliced+1] = tbl[i]
	end

	return sliced
end

function M.make(makecommand, arguments)
	local args_string = M.flatten_to_string(arguments)
	print(args_string)
	makecommand = makecommand .. " " .. args_string
	makecommand = string.gsub(makecommand, "%s+", "\\ ")
	-- vim.bo.makeprg = makecommand
	vim.cmd("set makeprg=" .. makecommand)
	vim.cmd[[make]]
end

M.name = 'faust-nvim'
M.path_sep = vim.loop.os_uname().sysname:match('Windows') and '\\' or '/'

function M.get_len(tbl)
	local count = 0
	for _ in pairs(tbl) do
		count = count + 1
	end
	return count
end

function M.get_plugin_root_dir()
	local package_path = debug.getinfo(1).source:gsub('@', '')
	package_path = vim.split(package_path, M.path_sep, true)
	-- find index of plugin root dir
	local index = 1
	for i, v in ipairs(package_path) do
		if v == M.name then
			index = i
			break
		end
	end
	local path_len = M.get_len(package_path)
	if index == 1 or index == path_len then
		error('['..M.name..'] could not find plugin root dir')
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
	assert(dir ~= '', '['..M.name..'] Could not get plugin root path')
	dir = dir:sub(1, -2) -- delete trailing slash
	return dir
end

M.faust_nvim_root_dir = M.get_plugin_root_dir()

return M
