return {
    -- Vim
    "editorconfig/editorconfig-vim",
    "mg979/vim-visual-multi",
    "simnalamburt/vim-mundo",
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
    "nvim-telescope/telescope.nvim",

    { "akinsho/bufferline.nvim", config = true },
    { "folke/trouble.nvim", config = true },
    { "kyazdani42/nvim-tree.lua", config = true },
    { "lewis6991/gitsigns.nvim", config = true },
    { "lukas-reineke/indent-blankline.nvim", config = true },
    { "numToStr/Comment.nvim", config = true },
    { "nvim-lualine/lualine.nvim", config = true },
    { "ray-x/lsp_signature.nvim", config = true },
    { "stevearc/overseer.nvim", config = true },
    { "glepnir/lspsaga.nvim", config = true },
    { "windwp/nvim-autopairs", config = true },
    { "windwp/nvim-ts-autotag", config = true },


    require("plugins.cmp"),

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true },
            })
        end,
        build = ":TSUpdate",
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
