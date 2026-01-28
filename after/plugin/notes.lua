---@diagnostic disable: unused-function
--- Commands for notes
local notes_path = vim.fn.expand("~/Documents/PC_Sync/Notes")

-- Function that creates a journal entry
local function open_daily_note()
	local dir = notes_path .. "/daily"
	local date = os.date("%Y-%m-%d")
	local f_date = os.date("%Y_%m_%d")
	local file = dir .. "/" .. f_date .. ".md"

	-- Ensure directory exists
	vim.fn.mkdir(dir, "p")

	local is_new = vim.fn.filereadable(file) == 0

	-- Open the file
	vim.cmd("edit " .. vim.fn.fnameescape(file))

	-- Insert template only if file is new
	if is_new then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			"---",
			"date: " .. date,
			"---",
			"",
			"",
		})
	end
	vim.cmd("normal! G")
end

-- Function that creates a dictionary entry
local function new_dictionary_entry()
	local dir = notes_path .. "/dictionary"

	-- Prompt for entry name
	local entry = vim.fn.input("Dictionary entry: ")
	if entry == "" then
		return
	end

	-- Sanitize filename (lowercase, spaces -> underscores)
	local filename = entry:lower():gsub("%s+", "_") .. ".md"
	local file = dir .. "/" .. filename

	-- Ensure directory exists
	vim.fn.mkdir(dir, "p")

	local is_new = vim.fn.filereadable(file) == 0

	-- Open the file
	vim.cmd("edit " .. vim.fn.fnameescape(file))

	-- Insert template only if file is new
	if is_new then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			"---",
			"title: " .. entry,
			"---",
			"",
			"**Definition:**",
			"",
			"",
			"**Notes:**",
			"",
		})
	end

	vim.cmd("normal! 6G")
	vim.cmd("startinsert!")
end

-- Function that creates a new paper note with a UUID-based ID (no hyphens)
local function new_paper()
	local dir = notes_path .. "/notes_on_papers"

	-- Ensure directory exists
	vim.fn.mkdir(dir, "p")

	local id = string.format("%x%02x", os.time(), math.random(0, 0xff))

	local filename = id .. ".md"
	local file = dir .. "/" .. filename

	-- Open the new file
	vim.cmd("edit " .. vim.fn.fnameescape(file))

	-- Insert template
	vim.api.nvim_buf_set_lines(0, 0, -1, false, {
		"---",
		"id: " .. id,
		"title: ",
		"---",
		"",
		"**Summary:**",
		"",
		"",
		"**Key points:**",
		"",
		"",
		"**Interesting figures:**",
		"",
		"",
	})

	-- Jump cursor to the title field
	vim.cmd("normal! 3G")
	vim.cmd("startinsert!")
end

local completions = {
	{ "Notes", "" },
	{ "Daily", "daily" },
	{ "Dictionary", "dictionary" },
	{ "Paper Notes", "notes_on_papers" },
}

local live_grep = function()
	local keys = vim.tbl_keys(completions)
	vim.ui.select(keys, {
		prompt = "Select Search Scope",
		format_item = function(item)
			return completions[item][1]
		end,
	}, function(choice)
		if choice then
			local sp = completions[choice][2]
			require("telescope.builtin").live_grep({ cwd = vim.fn.expand(notes_path .. "/" .. sp) })
		end
	end)
end

local find_files = function()
	require("telescope.builtin").find_files({ cwd = notes_path })
end

local get_all_todos = function()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local todos = {}
	local cwd = vim.fn.expand(notes_path .. "/daily")
	local md_files = vim.fn.globpath(cwd, "*.md", true, true)

	for _, file in ipairs(md_files) do
		local lines = vim.fn.readfile(file)
		local in_todo_section = false

		for lnum, line in ipairs(lines) do
			if line:match("^#+%s+TODO%s*$") then
				in_todo_section = true
			elseif in_todo_section and line:match("^#+%s+") then
				in_todo_section = false
			elseif in_todo_section then
				local task = line:match("^%s*%- %[%s%] (.+)")
				if task then
					table.insert(todos, {
						text = task,
						file = file,
						lnum = lnum,
					})
				end
			end
		end
	end

	--- Picker part (chatgpt generated)
	pickers
		.new({}, {
			prompt_title = "Find entry",
			finder = finders.new_table({
				results = todos,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.text,
						ordinal = entry.text,
						filename = entry.file,
						lnum = entry.lnum,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			previewer = conf.grep_previewer({}),
			attach_mappings = function(_, map)
				map("i", "<CR>", function(bufnr)
					local selection = action_state.get_selected_entry()
					actions.close(bufnr)
					vim.cmd("edit " .. selection.filename)
					vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
				end)
				return true
			end,
		})
		:find()
end

local paste_img = function()
	local img_dir = vim.fn.expand(notes_path .. "/img")

	-- Make sure img dir exists
	if vim.fn.isdirectory(img_dir) == 0 then
		vim.fn.mkdir(img_dir, "p")
	end

	local filename = "image_" .. os.time() .. ".png"
	local full_path = img_dir .. "/" .. filename

	local command = "wl-paste -n -t image/png >" .. full_path
	if os.execute(command) == 0 then
		local mdown_path = "/img/" .. filename
		vim.api.nvim_put({ "![](" .. mdown_path .. ")" }, "l", true, true)
		print("Pasted image:" .. full_path)
	else
		print("Failed to paste img")
	end
end

vim.api.nvim_create_user_command("Daily", open_daily_note, { desc = "Opens daily note" })
vim.api.nvim_create_user_command("NewDict", new_dictionary_entry, { desc = "Makes a new dictionary entry" })
vim.api.nvim_create_user_command("NewPaper", new_paper, { desc = "Makes a new paper entry" })
vim.api.nvim_create_user_command("NImage", paste_img, { desc = "Paste image in notes folder" })
--- Keymaps
--- <Leader>ww : Finds todos
--- <Leader>wt : Opens ~/Documents/Notes/ in a new tab
--- <Leader>wf : Finds files
--- <Leader>wg : Greps files
vim.keymap.set("n", "<Leader>ww", get_all_todos, { desc = "Opens todos" })
vim.keymap.set("n", "<Leader>wt", ":tabnew " .. notes_path .. "<CR>", { desc = "Opens notes folder in a new tab" })
vim.keymap.set("n", "<Leader>wf", find_files, { desc = "Look for files in notes folder" })
vim.keymap.set("n", "<Leader>wg", live_grep, { desc = "Live grep in notes folder" })
