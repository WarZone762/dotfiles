return require("packer").startup(function(use)
  vim = vim
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
  use {"RRethy/vim-illuminate"}
  use {"L3MON4D3/LuaSnip"}
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
    config = function() vim.g.coq_settings = {auto_start = 'shut-up'} end
  }
	use {"neovim/nvim-lspconfig"}
  use {
    "williamboman/nvim-lsp-installer",
    after = {"vim-illuminate", "coq_nvim"},
    config = function() require("nvim-lsp-installer").on_server_ready(
      function(server)
        local function on_attach(client, bufnr)
          require("illuminate").on_attach(client)
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport =
          true

        local coq = require("coq")

        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        for key, value in pairs(coq.lsp_ensure_capabilities()) do
          opts[key] = value
        end

        server:setup(opts)
      end
    ) end
  }
	use {
		"nvim-treesitter/nvim-treesitter",
		config = function() require("nvim-treesitter.configs").setup({
			ensure_installed = "maintained",
			highlight = {enable = true}
		}) end,
		run = ":TSUpdate"
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
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = require("bufferline").setup()
  }
  use {
    "windwp/nvim-autopairs",
    after = "coq_nvim",
    config = function() vim.defer_fn(function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({map_bs = false, map_cr = false, check_ts = true})

      _G.AutopairsFunctions = {}

      AutopairsFunctions.CR = function()
        if vim.fn.pumvisible() ~= 0 then
          if vim.fn.complete_info({"selected"}).selected ~= -1 then
            return autopairs.esc("<C-y>")
          else
            return autopairs.esc("<C-e>") ..
              autopairs.autopairs_cr(vim.api.nvim_get_current_buf())
          end
        else
          return autopairs.autopairs_cr(vim.api.nvim_get_current_buf())
        end
      end
      vim.api.nvim_set_keymap(
        "i",
        "<CR>",
        "v:lua.AutopairsFunctions.CR()",
        {expr = true, noremap = true}
      )

      AutopairsFunctions.BS = function()
        if
          vim.fn.pumvisible() ~= 0
          and vim.fn.complete_info({"mode"}).mode == "eval"
        then
          return autopairs.esc("<C-e>") ..
            autopairs.autopairs_bs(vim.api.nvim_get_current_buf())
        else
          return autopairs.autopairs_bs(vim.api.nvim_get_current_buf())
        end
      end
      vim.api.nvim_set_keymap(
        "i",
        "<BS>",
        "v:lua.AutopairsFunctions.BS()",
        {expr = true, noremap = true}
      )
    end, 2500) end
  }
  use {
    "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup() end
  }
  use {
    "ray-x/lsp_signature.nvim",
    config = function() require("lsp_signature").setup() end
  }

  use {
    "marko-cerovac/material.nvim",
    config = function()
      vim.g.material_style = "darker"
      vim.cmd('colorscheme material')
    end
  }

end)

