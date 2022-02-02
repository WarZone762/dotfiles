return require("packer").startup(function(use)
	-- Packer
	use {"wbthomason/packer.nvim"}

	-- Vim
	use {"tpope/vim-fugitive"}
	use {"tpope/vim-surround"}
	use {"majutsushi/tagbar"}
	use {"tpope/vim-repeat"}

	use {"mg979/vim-visual-multi"}
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
			lspconfig.sumneko_lua.setup({cmd = {"cmd.exe", "/C", "lua-language-server"}})
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
      {
        "ms-jpq/coq.artifacts",
        branch = "artifacts"
      },
      {
        "ms-jpq/coq.thirdparty",
        branch = "3p",
        config = function() require("coq_3p") {{
          src = "nvimlua",
          short_name = "nLUA",
          conf_only = true
        }} end
      }
    },
    run = ":COQdeps",
    config = [[
      vim.defer_fn(function() vim.api.nvim_command("COQnow --shut-up") end, 0)
    ]]
  }
	use {"mfussenegger/nvim-dap"}
	use {
		"nvim-telescope/telescope.nvim",
		requires = {"nvim-lua/plenary.nvim"}
	}
	use {"liuchengxu/vista.vim"}
	use {
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
		config = function() require("nvim-treesitter.configs").setup({
			rainbow = {
				enable = true,
				extended_mode = true
			}}) end
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
	use {"ggandor/lightspeed.nvim"}
  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup() end
  }
	use {
		"TimUntersberger/neogit",
		requires = {"nvim-lua/plenary.nvim"}
	}
  use {
    "tami5/lspsaga.nvim",
    config = function() require("lspsaga").setup() end
  }

  use {
    "marko-cerovac/material.nvim",
    config = [[
      vim.g.material_style = "darker"
      vim.cmd('colorscheme material')
    ]]
  }

end)

