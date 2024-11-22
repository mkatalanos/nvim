local function sum_numbers(number_lines)
	local sum = 0
	for _, numStr in ipairs(number_lines) do
		local parsed_number = string.match(numStr, "([-+]?[0-9]*%.?[0-9]+)")
		parsed_number = tonumber(parsed_number) or 0
		sum = sum + parsed_number
	end
	return sum
end

local function get_visual_selection()
	vim.cmd([[norm "vy]])
	return vim.split(vim.fn.getreg("v"), "\n")
end

local function calculate_selection()
	local text = get_visual_selection()
	local count = 0
	for _ in pairs(text) do
		count = count + 1
	end

	print("Sum:", sum_numbers(text))
end

vim.keymap.set("v", "<LocalLeader>vs", calculate_selection, { desc = "Sum numbers of visual selection" })

-- 1 2 3 4
-- 1 2
-- 3 4
-- 1 2 3 4
-- 1 2 3 4
