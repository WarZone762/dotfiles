local api = vim.api

return {
    -- Vim
    "terryma/vim-expand-region",
    "tpope/vim-abolish",
    "tpope/vim-repeat",
    "unblevable/quick-scope",

    -- Neovim
    { "numToStr/Comment.nvim", config = true },
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup()
            require("mini.align").setup()
            require("mini.basics").setup()
            require("mini.bracketed").setup()
            require("mini.cursorword").setup()
            require("mini.hipatterns").setup()
            if IS_STANDALONE then
                require("mini.indentscope").setup()
            end
            require("mini.jump").setup()
            require("mini.jump2d").setup()
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
                }
            })
            require("mini.pairs").setup()
            require("mini.splitjoin").setup()
            require("mini.surround").setup()
            local trailspace = require("mini.trailspace")
            trailspace.setup()
            api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    trailspace.trim()
                    trailspace.trim_last_lines()
                end
            })
        end
    },
}
