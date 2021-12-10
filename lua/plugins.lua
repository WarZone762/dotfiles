return require("packer").startup(function()
	-- Packer
	use "wbthomason/packer.nvim"

	-- Disabled
	use {"scrooloose/nerdtree", disable = true}
	use {"scrooloose/syntastic", disable = true}
	use {"airblade/vim-gitgutter", disable = true}
	use {"vim-airline/vim-airline", disable = true}
	use {"w0rp/ale", disable = true}
	use {"valloric/youcompleteme", run = "install.py --msvc 17 --cmake-path \"C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe\"", disable = true}
	use {"yggdroot/indentline", disable = true}

	-- Vim
	use "tpope/vim-fugitive"
	use "tpope/vim-surround"
	use "scrooloose/nerdcommenter"
	use "majutsushi/tagbar"
	use "tpope/vim-repeat"
	
	use "easymotion/vim-easymotion"
	use "mg979/vim-visual-multi"
	use "luochen1990/rainbow"
	use "tpope/vim-eunuch"
	use "editorconfig/editorconfig-vim"
	use "tpope/vim-abolish"
	use "raimondi/delimitmate"
	use "kkoomen/vim-doge"
	use "terryma/vim-expand-region"
	use "sjl/gundo.vim"
	use "godlygeek/tabular"
	use "wellle/targets.vim"
	use "kana/vim-textobj-user"
	use "kana/vim-textobj-line"
	use "michaeljsmith/vim-indent-object"
	use "kana/vim-textobj-entire"
	use "tpope/vim-unimpaired"
	use "tpope/vim-vinegar"
	use "tpope/vim-sensible"
		
	-- Neovim
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
		"ms-jpq/chadtree",
		branch = "chad",
		run = {
			"python3 -m chadtree deps",
			":CHADdeps"
		}
	}
	use {
		"nvim-lualine/lualine.nvim",
		config = function() require("lualine").setup() end
	}
	use {
		"TimUntersberger/neogit",
		requires = {"nvim-lua/plenary.nvim"}
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

