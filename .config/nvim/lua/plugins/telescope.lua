return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {"<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files"}
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
		        prompt_prefix = " ",
		        selection_caret = " ",
		        path_display = { "short" },
		        file_ignore_patterns = { ".git/", "node_modules" },

		        mappings = {
			        i = {
                        ["<esc>"] = actions.close,
				        ["<Down>"] = actions.cycle_history_next,
				        ["<Up>"] = actions.cycle_history_prev,
				        ["<C-j>"] = actions.move_selection_next,
				        ["<C-k>"] = actions.move_selection_previous,
				        ["<leader>c"] = actions.close,
			        },
		        },
	        },
	        extensions = {
		        fzf = {
			        fuzzy = true,
			        override_generic_sorter = true,
			        override_file_sorter = true,
			        case_mode = "smart_case",
		        },
	        },
        })
        telescope.load_extension("fzf")
    end
}
