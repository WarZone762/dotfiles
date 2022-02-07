return require("packer").startup(function(use)
  vim = vim
  local function default_config(plugin_name)
    require(plugin_name).setup()
  end

	-- Packer
	use {"wbthomason/packer.nvim"}

	-- Vim
	use {"editorconfig/editorconfig-vim"}
	use {"godlygeek/tabular"}
	use {"kana/vim-textobj-entire"}
	use {"kana/vim-textobj-line"}
	use {"kana/vim-textobj-user"}
	use {"kkoomen/vim-doge"}
	use {"majutsushi/tagbar"}
	use {"mg979/vim-visual-multi"}
	use {"michaeljsmith/vim-indent-object"}
	use {"sjl/gundo.vim"}
	use {"terryma/vim-expand-region"}
	use {"tpope/vim-abolish"}
	use {"tpope/vim-eunuch"}
	use {"tpope/vim-fugitive"}
	use {"tpope/vim-repeat"}
	use {"tpope/vim-sensible"}
	use {"tpope/vim-surround"}
	use {"tpope/vim-unimpaired"}
	use {"tpope/vim-vinegar"}
	use {"wellle/targets.vim"}

	-- Neovim
  use {
    "windwp/nvim-autopairs",
    config = default_config("nvim-autopairs"),
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    after = {
      "nvim-autopairs",
    },
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(
          0, line - 1, line, true
        )[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          {name = "nvim_lsp"},
          {name = "luasnip"},
        }, {
          {name = "buffer"},
        }),

        experimental = {
          ghost_text = true,
        }
      })

      cmp.setup.cmdline("/", {
        sources = {
          {name = "buffer"}
        }
      })

      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          {name = "path"}
        }, {
          {name = "cmdline"}
        })
      })
    end
  }
  use {"RRethy/vim-illuminate"}
  use {
    "williamboman/nvim-lsp-installer",
    requires = {
      "neovim/nvim-lspconfig",
    },
    after = {
      "nvim-cmp",
      "vim-illuminate",
    },
    config = function() require("nvim-lsp-installer").on_server_ready(
      function(server)
        local function on_attach(client, bufnr)
          require("illuminate").on_attach(client)
        end

        local capabilities = require("cmp_nvim_lsp").update_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        )

        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

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
		requires = {
      "nvim-lua/plenary.nvim",
    }
	}
	use {"liuchengxu/vista.vim"}
	use {
		"p00f/nvim-ts-rainbow",
		requires = {
      "nvim-treesitter/nvim-treesitter"
    },
		config = function() require("nvim-treesitter.configs").setup({
			rainbow = {
				enable = true,
				extended_mode = true
			}}) end
	}
	use {
		"kyazdani42/nvim-tree.lua",
		requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = default_config("nvim-tree"),
	}
	use {
		"nvim-lualine/lualine.nvim",
    config = default_config("lualine"),
	}
	use {
		"lewis6991/gitsigns.nvim",
		requires = {
      "nvim-lua/plenary.nvim"
    },
    config = default_config("gitsigns"),
	}
	use {
		"lukas-reineke/indent-blankline.nvim",
    config = default_config("indent_blankline"),
	}
	use {
		"norcalli/nvim-colorizer.lua",
    config = default_config("colorizer"),
	}
	use {"ggandor/lightspeed.nvim"}
  use {
    "numToStr/Comment.nvim",
    config = default_config("Comment"),
  }
  use {
    "folke/trouble.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons"
    },
    config = default_config("trouble"),
  }
	use {
		"TimUntersberger/neogit",
		requires = {
      "nvim-lua/plenary.nvim",
    }
	}
  use {
    "tami5/lspsaga.nvim",
    config = default_config("lspsaga"),
  }
  use {
    "akinsho/bufferline.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = require("bufferline").setup()
  }
  use {
    "windwp/nvim-ts-autotag",
    config = default_config("nvim-ts-autotag"),
  }
  use {
    "ray-x/lsp_signature.nvim",
    config = default_config("lsp_signature"),
  }

  use {
    "marko-cerovac/material.nvim",
    config = function()
      vim.g.material_style = "darker"
      vim.cmd('colorscheme material')
    end
  }

end)

