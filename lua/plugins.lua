return require("packer").startup(function(use)
	-- Packer
	use {"wbthomason/packer.nvim"}

	-- Disabled
	-- use {"scrooloose/nerdtree"}
	-- use {"scrooloose/syntastic"}
	-- use {"airblade/vim-gitgutter"}
	-- use {"vim-airline/vim-airline"}
	-- use {"w0rp/ale"}
	-- use {
	-- 	"valloric/youcompleteme",
	-- 	run = "install.py --msvc 17 --cmake-path \"C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe\""
	-- }
	-- use {"yggdroot/indentline"}
	-- use {
	-- 	"ms-jpq/chadtree",
	-- 	branch = "chad",
	-- 	run = {
	-- 		"python3 -m chadtree deps",
	-- 		":CHADdeps"
	-- 	}
	-- }
	-- use {
	-- 	"TimUntersberger/neogit",
	-- 	requires = {"nvim-lua/plenary.nvim"}
	-- }

	-- Vim
	use {"tpope/vim-fugitive"}
	use {"tpope/vim-surround"}
	use {"scrooloose/nerdcommenter"}
	use {"majutsushi/tagbar"}
	use {"tpope/vim-repeat"}

	use {"easymotion/vim-easymotion"}
	use {"mg979/vim-visual-multi"}
	use {"luochen1990/rainbow"}
	use {"tpope/vim-eunuch"}
	use {"editorconfig/editorconfig-vim"}
	use {"tpope/vim-abolish"}
	use {"raimondi/delimitmate"}
	use {"kkoomen/vim-doge"}
	use {"terryma/vim-expand-region"}
	use {"sjl/gundo.vim"}
	use {"godlygeek/tabular"}
	use {"wellle/targets.vim"}
	use {"kana/vim-textobj-user"}
	use {"kana/vim-textobj-line"}
	use {"michaeljsmith/vim-indent-object"}
	use {"kana/vim-textobj-entire"}
	use {"tpope/vim-unimpaired"}
	use {"tpope/vim-vinegar"}
	use {"tpope/vim-sensible"}

	-- Neovim
	use {
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.pyright.setup({})
			lspconfig.sumneko_lua.setup({cmd = {"cmd.exe", "/C","lua-language-server"}})
		end
	}
	use {
		"nvim-treesitter/nvim-treesitter",
		config = function() require("nvim-treesitter.configs").setup({
			ensure_installed = "maintained",
			highlight = {enable = true}
		}) end,
		run = ":TSUpdate"
	}
	use {
		"ms-jpq/coq_nvim",
		branch = "coq",
		requires = {
			"ms-jpq/coq.artifacts",
			branch = "artifacts"
		},
		run = ":COQdeps",
		config = function() vim.defer_fn(function() vim.api.nvim_command("COQnow") end, 1000) end
	}
	use {
		"nvim-telescope/telescope.nvim",
		requires = {"nvim-lua/plenary.nvim"}
	}
	use {
		"liuchengxu/vista.vim"
	}
	use {
		"kyazdani42/nvim-tree.lua",
		requires = {"kyazdani42/nvim-web-devicons"},
		config = function() require("nvim-tree").setup() end
	}
	use {
		"nvim-lualine/lualine.nvim",
		config = function() require("lualine").setup() end
	}
	use {
		"lewis6991/gitsigns.nvim",
		requires = {"nvim-lua/plenary.nvim"},
		config = function() require("gitsigns").setup() end
	}
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function() require("indent_blankline").setup() end
	}
	use {
		"norcalli/nvim-colorizer.lua",
		config = function() require("colorizer").setup() end
	}

end)

