return {
    -- Vim
    "godlygeek/tabular",
    "jeetsukumaran/vim-indentwise",
    "matze/vim-move",
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

    -- Neovim
    { "kylechui/nvim-surround", config = true },
    { "numToStr/Comment.nvim", config = true },

    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    },
}
