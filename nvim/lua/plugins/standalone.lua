local keymap = vim.keymap

return {
    -- Vim
    "editorconfig/editorconfig-vim",
    "mg979/vim-visual-multi",
    "tpope/vim-eunuch",
    "tpope/vim-fugitive",

    -- Neovim
    "L3MON4D3/LuaSnip",
    "RRethy/vim-illuminate",
    "TimUntersberger/neogit",
    "ggandor/lightspeed.nvim",
    "kyazdani42/nvim-web-devicons",
    "liuchengxu/vista.vim",
    "mfussenegger/nvim-dap",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter-context",

    { "akinsho/bufferline.nvim",             config = true },
    { "glepnir/lspsaga.nvim",                config = true },
    { "lewis6991/gitsigns.nvim",             config = true },
    { "lukas-reineke/indent-blankline.nvim", config = true },
    { "numToStr/Comment.nvim",               config = true },
    { "nvim-lualine/lualine.nvim",           config = true },
    { "ray-x/lsp_signature.nvim",            config = true },
    { "stevearc/overseer.nvim",              config = true },
    { "windwp/nvim-autopairs",               config = true },
    { "windwp/nvim-ts-autotag",              config = true },

    require("plugins.lsp"),

    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope.builtin")
            keymap.set("n", "<C-f>", telescope.find_files, { noremap = true })
            keymap.set("n", "<C-t>", vim.cmd.Telescope, { noremap = true })
        end
    },

    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
            keymap.set("n", "<leader>f", "<cmd>NvimTreeToggle<cr>",
                { silent = true, noremap = true }
            )
        end
    },

    {
        "folke/trouble.nvim",
        config = function()
            keymap.set("n", "<leader>d", "<cmd>TroubleToggle quickfix<cr>",
                { silent = true, noremap = true }
            )
        end
    },

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
        end
    },

    {
        "mbbill/undotree",
        config = function()
            keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
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
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },

    {
        "williamboman/mason.nvim",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("mason").setup()
                    require("mason-lspconfig").setup()
                    require("mason-lspconfig").setup_handlers {
                        function(server_name)
                            require("lspconfig")[server_name].setup {}
                        end,
                    }
                end,
            },
        },
        config = true,
    },

    {
        "p00f/nvim-ts-rainbow",
        config = function()
            require("nvim-treesitter.configs").setup({
                rainbow = {
                    enable = true,
                    extended_mode = true,
                },
            })
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
        "Mofiqul/vscode.nvim",
        config = function()
            local c = require("vscode.colors").get_colors()
            require("vscode").setup({
                group_overrides = {
                    ["@field"] = { fg = c.vscBlueGreen, bg = "NONE" },
                    ["@property"] = { fg = c.vscBlueGreen, bg = "NONE" },
                },
            })
            vim.cmd("colorscheme vscode")
        end,
    },
}
