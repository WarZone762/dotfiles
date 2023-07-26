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

            keymap.set("n", "<leader>m", mark.add_file)
            keymap.set("n", "<leader>h", ui.toggle_quick_menu)

            keymap.set("n", "<leader>+", function() ui.nav_file(1) end)
            keymap.set("n", "<leader>[", function() ui.nav_file(2) end)
            keymap.set("n", "<leader>{", function() ui.nav_file(3) end)
            keymap.set("n", "<leader>(", function() ui.nav_file(4) end)
            keymap.set("n", "<leader>&", function() ui.nav_file(5) end)
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
            keymap.set(
                "n",
                "<leader>f",
                cmd.NvimTreeToggle,
                { silent = true, noremap = true }
            )
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
            keymap.set("n", "<C-p>", telescope.git_files, { noremap = true })
            keymap.set("n", "<C-t>", cmd.Telescope, { noremap = true })
        end,
    },

    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
            })
            cmd.colorscheme("tokyonight-night")
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            keymap.set(
                "n",
                "<leader>d",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                { silent = true, noremap = true }
            )
            keymap.set(
                "n",
                "<leader>q",
                "<cmd>TroubleToggle quickfix<cr>",
                { silent = true, noremap = true }
            )
        end,
    },

    {
        "mbbill/undotree",
        config = function()
            keymap.set("n", "<leader>u", cmd.UndotreeToggle)
        end,
    },
}
