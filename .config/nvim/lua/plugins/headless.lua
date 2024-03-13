local api = vim.api
local keymap = vim.keymap

return {
    -- Vim
    "terryma/vim-expand-region",
    "tpope/vim-abolish",
    "tpope/vim-repeat",
    "unblevable/quick-scope",

    -- Neovim
    { "numToStr/Comment.nvim", config = true },
    { "windwp/nvim-autopairs", config = true },
    {
        "ggandor/leap.nvim",
        config = function()
            vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
                local focusable_windows_on_tabpage = vim.tbl_filter(
                    function(win) return api.nvim_win_get_config(win).focusable end,
                    api.nvim_tabpage_list_wins(0)
                )
                require("leap").leap({ target_windows = focusable_windows_on_tabpage })
            end, { desc = "Leap" })
        end,
    },
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup()
            require("mini.align").setup()
            require("mini.basics").setup()
            require("mini.bracketed").setup()
            require("mini.cursorword").setup()
            require("mini.hipatterns").setup()
            require("mini.jump").setup()
            require("mini.move").setup({
                mappings = {
                    left = "<C-M-h>",
                    right = "<C-M-l>",
                    down = "<C-M-j>",
                    up = "<C-M-k>",

                    line_left = "<C-M-h>",
                    line_right = "<C-M-l>",
                    line_down = "<C-M-j>",
                    line_up = "<C-M-k>",
                },
            })
            require("mini.splitjoin").setup()
            require("mini.surround").setup()
            local trailspace = require("mini.trailspace")
            trailspace.setup()
            api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    trailspace.trim()
                    trailspace.trim_last_lines()
                end,
            })

            if IS_STANDALONE then
                require("mini.indentscope").setup()
                require("mini.files").setup({ options = { use_as_default_explorer = false } })
                keymap.set("n", "<Leader>E", MiniFiles.open,
                    { silent = true, noremap = true, desc = "MiniFiles toggle" })
            end
        end,
    },
}
