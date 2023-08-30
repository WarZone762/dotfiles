local keymap = vim.keymap
local cmd = vim.cmd

return {
    -- Vim
    "editorconfig/editorconfig-vim",
    "mg979/vim-visual-multi",
    "tpope/vim-eunuch",
    "tpope/vim-fugitive",

    -- Neovim
    "kyazdani42/nvim-web-devicons",
    "liuchengxu/vista.vim",
    "mfussenegger/nvim-dap",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    { "akinsho/bufferline.nvim",             config = true },
    { "lewis6991/gitsigns.nvim",             config = true },
    { "lukas-reineke/indent-blankline.nvim", config = true },
    { "nvim-lualine/lualine.nvim",           config = true },

    require("plugins.lsp"),

    {
        "ThePrimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            keymap.set("n", "<Leader>m", mark.add_file, { desc = "Harpoon mark toggle" })
            keymap.set("n", "<Leader>h", ui.toggle_quick_menu, { desc = "Harpoon toggle" })

            keymap.set("n", "<Leader>+", function() ui.nav_file(1) end,
                { desc = "Harpoon go to file 1" })
            keymap.set("n", "<Leader>[", function() ui.nav_file(2) end,
                { desc = "Harpoon go to file 2" })
            keymap.set("n", "<Leader>{", function() ui.nav_file(3) end,
                { desc = "Harpoon go to file 3" })
            keymap.set("n", "<Leader>(", function() ui.nav_file(4) end,
                { desc = "Harpoon go to file 4" })
            keymap.set("n", "<Leader>&", function() ui.nav_file(5) end,
                { desc = "Harpoon go to file 5" })
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = { long_message_to_split = true },
        },
    },

    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
            keymap.set("n", "<Leader>e", cmd.NvimTreeToggle,
                { silent = true, noremap = true, desc = "NvimTree toggle" })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                auto_install = true,
                highlight = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gv",
                        scope_incremental = "<CR>",
                        node_incremental = "<TAB>",
                        node_decremental = "<S-TAB>",
                    },
                },
            })
        end,
        build = function()
            local ts_update = require("nvim-treesitter.install").update()
            ts_update()
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.completion.spell,
                },
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope.builtin")
            keymap.set("n", "<C-f>", telescope.git_files,
                { noremap = true, desc = { "Search git files" } })
            keymap.set("n", "<Leader>f", telescope.find_files,
                { noremap = true, desc = { "Search files" } })
            keymap.set("n", "<C-t>", cmd.Telescope, { noremap = true, desc = "Telescope" })
        end,
    },

    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })
            cmd.colorscheme("tokyonight-night")
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            keymap.set(
                "n",
                "<Leader>d",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                { silent = true, noremap = true, desc = "Workspace diagnostics toggle" }
            )
            keymap.set(
                "n",
                "<Leader>q",
                "<cmd>TroubleToggle quickfix<cr>",
                { silent = true, noremap = true, desc = "Quickfix toggle" }
            )
        end,
    },

    {
        "mbbill/undotree",
        config = function()
            keymap.set("n", "<Leader>u", cmd.UndotreeToggle, { desc = "Undootree toggle" })
        end,
    },
}
