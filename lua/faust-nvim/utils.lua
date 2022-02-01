local M = {}

function M.slice(tbl, first, last, step)
	local sliced = {}

	for i = first or 1, last or #tbl, step or 1 do
	sliced[#sliced+1] = tbl[i]
	end

	return sliced
end

return M
