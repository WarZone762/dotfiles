local keymap = vim.keymap

return {
    -- Vim
    "godlygeek/tabular",
    "jeetsukumaran/vim-indentwise",
    "michaeljsmith/vim-indent-object",
    "terryma/vim-expand-region",
    "tpope/vim-abolish",
    "tpope/vim-repeat",
    "tpope/vim-unimpaired",
    "unblevable/quick-scope",
    "wellle/targets.vim",

    {
        "kana/vim-textobj-user",
        dependencies = {
            "kana/vim-textobj-entire",
            "kana/vim-textobj-line",
        },
    },
    {
        "matze/vim-move",
        init = function()
            vim.g.move_key_modifier = "C-M"
            vim.g.move_key_modifier_visualmode = "C-M"
        end
    },

    -- Neovim
    { "kylechui/nvim-surround", config = true },

    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    },
}
