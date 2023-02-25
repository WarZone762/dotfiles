local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt

opt.splitright = true
opt.splitbelow = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"

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
        "--branch=stable", -- latest stable release
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
    "kana/vim-textobj-entire",
    "kana/vim-textobj-line",
    "kana/vim-textobj-user",
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
    "windwp/nvim-autopairs",

    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "cmp-buffer",
            "cmp-cmdline",
            "cmp-nvim-lsp",
            "cmp-path",
            "cmp_luasnip",
        },
        config = function()
            local has_words_before = function()
                local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(
                    0, line - 1, line, true
                )[1]:sub(col, col):match("%s") == nil
            end

            local luasnip = require("luasnip")
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c", }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c", }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true, }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s", }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s", }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp", },
                    { name = "luasnip", },
                }, {
                    { name = "buffer", },
                }),

                experimental = {
                    ghost_text = true,
                },
            })

            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer", },
                },
            })

            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path", },
                }, {
                    { name = "cmdline", },
                }),
            })
        end,
    },
    "RRethy/vim-illuminate",
    "neovim/nvim-lspconfig",
    {
        "williamboman/nvim-lsp-installer",
        config = function() require("nvim-lsp-installer").on_server_ready(
                function(server)
                    local function on_attach(client, bufnr)
                        require("illuminate").on_attach(client)
                    end

                    local capabilities = require("cmp_nvim_lsp").update_capabilities(
                        vim.lsp.protocol.make_client_capabilities()
                    )

                    local opts = {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }

                    server:setup(opts)
                end
            )
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function() require("nvim-treesitter.configs").setup({
                -- ensure_installed = "maintained",
                highlight = { enable = true, },
            })
        end,
        build = ":TSUpdate",
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
    "mfussenegger/nvim-dap",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "liuchengxu/vista.vim",
    "kyazdani42/nvim-web-devicons",
    "kyazdani42/nvim-tree.lua",
    "folke/trouble.nvim",
    "akinsho/bufferline.nvim",
    "nvim-lualine/lualine.nvim",
    "lewis6991/gitsigns.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "norcalli/nvim-colorizer.lua",
    "ggandor/lightspeed.nvim",
    "numToStr/Comment.nvim",
    "TimUntersberger/neogit",
    "tami5/lspsaga.nvim",
    "windwp/nvim-ts-autotag",
    "ray-x/lsp_signature.nvim",

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
