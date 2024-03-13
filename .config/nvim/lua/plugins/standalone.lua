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
    { "akinsho/bufferline.nvim",   config = true },
    { "lewis6991/gitsigns.nvim",   config = true },
    { "nvim-lualine/lualine.nvim", config = true },

    require("plugins.lsp"),
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 3000,
                lsp_fallback = true,
            }
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            keymap.set("n", "<Leader>m", function() harpoon:list():append() end,
                { desc = "Harpoon append to list" })
            keymap.set("n", "<Leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Harpoon list toggle" })

            keymap.set("n", "<Leader>+", function() harpoon:list():select(1) end,
                { desc = "Harpoon go to file 1" })
            keymap.set("n", "<Leader>[", function() harpoon:list():select(2) end,
                { desc = "Harpoon go to file 2" })
            keymap.set("n", "<Leader>{", function() harpoon:list():select(3) end,
                { desc = "Harpoon go to file 3" })
            keymap.set("n", "<Leader>(", function() harpoon:list():select(4) end,
                { desc = "Harpoon go to file 4" })
            keymap.set("n", "<Leader>&", function() harpoon:list():select(5) end,
                { desc = "Harpoon go to file 5" })
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    background_colour = "#000000",
                },
            },
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
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope.builtin")
            keymap.set("n", "<C-f>", telescope.git_files,
                { noremap = true, desc = "Search git files" })
            keymap.set("n", "<Leader>f", telescope.find_files,
                { noremap = true, desc = "Search files" })
            keymap.set("n", "<C-t>", cmd.Telescope, { noremap = true, desc = "Telescope" })
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                integrations = {
                    native_lsp = {
                        enabled = true,
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                },
            })
            cmd.colorscheme("catppuccin-mocha")
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
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = true,
        -- opt = {},
    },
}
