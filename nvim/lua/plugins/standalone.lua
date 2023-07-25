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
    { "ray-x/lsp_signature.nvim",            config = true },

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
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
            keymap.set("n", "<leader>f", cmd.NvimTreeToggle,
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
