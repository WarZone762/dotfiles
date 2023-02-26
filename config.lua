local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt

opt.splitright = true
opt.splitbelow = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"

opt.completeopt = { "menu", "menuone", "longest", "preview", "noselect", }

opt.mouse = "a"
cmd("filetype plugin indent on")
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.breakindent = true

opt.ignorecase = true
opt.smartcase = true

opt.backup = true
opt.undofile = true

-- opt.t_Co = 256
opt.termguicolors = true

opt.directory = vim.env.TEMP or ("/tmp" .. "/nvim//")
opt.backupdir = vim.env.TEM or ("/tmp" .. "/nvim//")
opt.undodir = vim.env.TEM or ("/tmp" .. "/nvim//")

if vim.env.ComSpec then
    if string.find(vim.env.ComSpec, "cmd.exe") then
        opt.shell = "powershell"
        opt.shellcmdflag = "-Command"
        opt.shellquote = ""
        opt.shellxquote = ""
    end
end

if vim.fn.exists("g:vscode") == 1 then
    api.nvim_set_keymap("x", "gc", "<Plug>VSCodeCommentary", {})
    api.nvim_set_keymap("n", "gc", "<Plug>VSCodeCommentary", {})
    api.nvim_set_keymap("o", "gc", "<Plug>VSCodeCommentary", {})
    api.nvim_set_keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {})

    api.nvim_command("highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline")
    api.nvim_command("highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")

    vim.g.EasyMotion_do_mapping = 0
    vim.g.EasyMotion_smartcase = 1
    api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s)", {})
end

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins

---@type table<integer, string | table>
local plugins = {
    -- Vim
    "asvetliakov/vim-easymotion",
    "godlygeek/tabular",
    "jeetsukumaran/vim-indentwise",
    {
        "kana/vim-textobj-user",
        dependencies = {
            "kana/vim-textobj-entire",
            "kana/vim-textobj-line",
        },
    },
    "matze/vim-move",
    "michaeljsmith/vim-indent-object",
    "terryma/vim-expand-region",
    "tpope/vim-abolish",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "unblevable/quick-scope",
    "wellle/targets.vim",

    -- Neovim
}

local non_vscode_plugins = {
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

    { "akinsho/bufferline.nvim", config = true, },
    { "folke/trouble.nvim", config = true, },
    { "kyazdani42/nvim-tree.lua", config = true, },
    { "lewis6991/gitsigns.nvim", config = true, },
    { "lukas-reineke/indent-blankline.nvim", config = true, },
    { "numToStr/Comment.nvim", config = true, },
    { "nvim-lualine/lualine.nvim", config = true, },
    { "ray-x/lsp_signature.nvim", config = true, },
    { "tami5/lspsaga.nvim", config = true, },
    { "windwp/nvim-autopairs", config = true, },
    { "windwp/nvim-ts-autotag", config = true, },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- TODO: doesn't work
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true, }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true, })
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            cmp.complete()
                        end
                    end),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp", },
                    { name = "luasnip", },
                }, {
                    { name = "buffer", },
                }),
            })

            cmp.setup.cmdline({ "/", "?", }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer", },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path", },
                }, {
                    { name = "cmdline", },
                }),
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function() require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true, },
            })
        end,
        build = ":TSUpdate",
    },

    {
        "williamboman/mason.nvim",
        dependencies = {
            "nvim-lspconfig",
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
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
        config = function() require("nvim-treesitter.configs").setup({
                rainbow = {
                    enable = true,
                    extended_mode = true,
                },
            })
        end,
    },

    {
        "marko-cerovac/material.nvim",
        config = function()
            vim.g.material_style = "darker"
            vim.cmd("colorscheme material")
        end,
    },
}

for _, v in pairs(non_vscode_plugins) do
    if type(v) == "string" then
        v = {
            v,
        }
    end
    v.cond = function()
        return vim.fn.exists("g:vscode") == 0
    end

    table.insert(plugins, v);
end

require("lazy").setup(plugins)
