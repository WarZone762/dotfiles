local keymap = vim.keymap
local lsp = vim.lsp

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "williamboman/mason.nvim",
            dependencies = {
                "neovim/nvim-lspconfig",
                "mrcjkb/rustaceanvim",
                "williamboman/mason-lspconfig.nvim",
                "camilledejoye/nvim-lsp-selection-range",
            },
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup()
                local lsp_selection_range = require("lsp-selection-range")

                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                lsp_selection_range.update_capabilities(capabilities)
                keymap.set("n", "vv", lsp_selection_range.trigger,
                    { noremap = true, desc = "Trigger selection" })
                keymap.set("v", "vv", lsp_selection_range.expand,
                    { noremap = true, desc = "Expand selection" })

                vim.lsp.config("*", { capabilities = capabilities })
                vim.lsp.config("rust-analyzer", {
                    capabilities = capabilities,
                    settings = {
                        ["rust-analyzer"] = {
                            rustfmt = {
                                extraArgs = { "+nightly" },
                            },
                            check = { command = "clippy" },
                            procMacro = {
                                ignored = {
                                    leptos_macro = { "component" },
                                },
                            },
                            rustc = { source = "discover" },
                        },
                    },
                })
            end,
            build = function()
                pcall(vim.cmd.MasonUpdate)
            end,
        },
        {
            "nvimdev/lspsaga.nvim",
            config = function()
                require("lspsaga").setup()

                keymap.set(
                    "n",
                    "<F3>",
                    function() lsp.buf.format({ async = true }) end,
                    { noremap = true }
                )
                keymap.set("n", "gd", lsp.buf.definition,
                    { noremap = true, desc = "Go to definition" })
                keymap.set("n", "gD", lsp.buf.declaration,
                    { noremap = true, desc = "Go to declaration" })
                keymap.set("n", "gi", lsp.buf.implementation,
                    { noremap = true, desc = "Go to implementations" })
                keymap.set("n", "go", lsp.buf.type_definition,
                    { noremap = true, desc = "Go to type definition" })
                keymap.set("n", "gr", lsp.buf.references,
                    { noremap = true, desc = "Go to references" })
                keymap.set("n", "gs", lsp.buf.signature_help,
                    { noremap = true, desc = "Show signature" })

                keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>",
                    { noremap = true, desc = "Hover documentation" })
                keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>",
                    { noremap = true, desc = "Show line diagnostics" })
                keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>",
                    { noremap = true, desc = "Previous diagnostic" })
                keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>",
                    { noremap = true, desc = "Next diagnostic" })
                keymap.set({ "n", "x" }, "<Leader>a", "<cmd>Lspsaga code_action<cr>",
                    { noremap = true, desc = "Code action" })
                keymap.set("n", "<Leader>r", "<cmd>Lspsaga rename<cr>",
                    { noremap = true, desc = "Rename" })
            end,
        },

        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping(function()
                    if not cmp.visible() then
                        cmp.complete()
                    else
                        cmp.select_next_item({
                            behavior = cmp.SelectBehavior.Select })
                    end
                end),
                ["<C-p>"] = cmp.mapping(function()
                    if not cmp.visible() then
                        cmp.complete()
                    else
                        cmp.select_prev_item({
                            behavior = cmp.SelectBehavior.Select })
                    end
                end),

                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = false })
                    else
                        fallback()
                    end
                end),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "luasnip", keyword_length = 2 },
            }, {
                { name = "buffer", keyword_length = 3 },
            }),
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
    end,
}
