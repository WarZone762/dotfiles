local keymap = vim.keymap
local lsp = vim.lsp

return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
        "neovim/nvim-lspconfig",
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        "williamboman/mason-lspconfig.nvim",

        "L3MON4D3/LuaSnip",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets"
    },
    config = function()
        local lsp_zero = require("lsp-zero").preset({})

        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)
        lsp_zero.setup()
        keymap.set("n", "<leader>s", lsp.buf.signature_help, { noremap = true })

        local cmp = require("cmp")
        local cmp_action = require("lsp-zero").cmp_action()

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "buffer",  keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
            },
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                ["<C-Space>"] = cmp.mapping.complete(),

                ["<Tab>"] = cmp_action.luasnip_jump_forward(),
                ["<S-Tab>"] = cmp_action.luasnip_jump_backward(),
            }
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end
}
