local M = {}

-- Turn lines into one long string
function M.flatten_to_string(lines_table, keep_linebreaks)
	local outstring = ""
	for _, line in pairs(lines_table) do
		outstring = outstring .. line
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
	makecommand = makecommand .. " " .. args_string
	makecommand = string.gsub(makecommand, "%s+", "\\ ")
	-- vim.bo.makeprg = makecommand
	vim.cmd("set makeprg=" .. makecommand)
	vim.cmd[[make]]
end

return M
