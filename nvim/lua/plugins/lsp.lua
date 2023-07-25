local keymap = vim.keymap
local lsp = vim.lsp

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "williamboman/mason.nvim",
            dependencies = {
                "neovim/nvim-lspconfig",
                "simrat39/rust-tools.nvim",
                "williamboman/mason-lspconfig.nvim",
            },
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup()

                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                require("mason-lspconfig").setup_handlers {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    ["rust_analyzer"] = function()
                        require("rust-tools").setup({
                            server = {
                                settings = {
                                    ["rust-analyzer"] = { check = { command = "clippy" } } },
                            }
                        })
                    end,
                }
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
                keymap.set("n", "gd", lsp.buf.definition, { noremap = true })
                keymap.set("n", "gD", lsp.buf.declaration, { noremap = true })
                keymap.set("n", "gi", lsp.buf.implementation, { noremap = true })
                keymap.set("n", "go", lsp.buf.type_definition, { noremap = true })
                keymap.set("n", "gr", lsp.buf.references, { noremap = true })
                keymap.set("n", "gs", lsp.buf.signature_help, { noremap = true })

                keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { noremap = true })
                keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", { noremap = true })
                keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { noremap = true })
                keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { noremap = true })
                keymap.set({ "n", "x" }, "<F4>", "<cmd>Lspsaga code_action<cr>", { noremap = true })
                keymap.set("n", "<F2>", "<cmd>Lspsaga rename<cr>", { noremap = true })
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

                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
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
