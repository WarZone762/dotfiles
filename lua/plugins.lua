require("packer").startup(function(use)
  local function default_config(plugin_name)
    return "require('" .. plugin_name .. "').setup()"
  end

  local function no_vscode()
    return vim.fn.exists("g:vscode") == 0
  end

  -- Packer
  use { "wbthomason/packer.nvim" }

  -- Vim
  use { "godlygeek/tabular" }
  use { "kana/vim-textobj-entire" }
  use { "kana/vim-textobj-line" }
  use { "kana/vim-textobj-user" }
  use { "mg979/vim-visual-multi" }
  use { "terryma/vim-expand-region" }
  use { "michaeljsmith/vim-indent-object" }
  use { "tpope/vim-abolish" }
  use { "tpope/vim-eunuch" }
  use { "tpope/vim-repeat" }
  use { "tpope/vim-surround" }
  use { "tpope/vim-unimpaired" }
  use { "wellle/targets.vim" }
  use { "unblevable/quick-scope" }

  -- Neovim

  -- Not VSCode
  local no_vscode_plugins = {}
  local use_original = use

  local function use_no_vscode(...)
    local arg = ...
    arg.opt = true
    table.insert(no_vscode_plugins, arg[1])
    use_original(arg)
  end

  local use = use_no_vscode

  -- Vim
  use { "editorconfig/editorconfig-vim" }
  use { "simnalamburt/vim-mundo" }
  use { "tpope/vim-fugitive" }
  use { "asvetliakov/vim-easymotion" }

  -- Neovim
  use {
    "windwp/nvim-autopairs",
    config = default_config("nvim-autopairs"),
  }

  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-cmdline" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path" }
  use { "L3MON4D3/LuaSnip" }
  use {
    "saadparwaiz1/cmp_luasnip",
    after = {
      "LuaSnip",
      "nvim-cmp",
    }
  }

  use {
    "hrsh7th/nvim-cmp",
    after = {
      "nvim-lspconfig",
      "cmp-buffer",
      "cmp-cmdline",
      "cmp-nvim-lsp",
      "cmp-path",
      "LuaSnip",
    },
    config = function()
      local has_words_before = function()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
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
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),

        experimental = {
          ghost_text = true,
        }
      })

      cmp.setup.cmdline("/", {
        sources = {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end
  }
  use { "RRethy/vim-illuminate" }
  use { "neovim/nvim-lspconfig" }
  use {
    "williamboman/nvim-lsp-installer",
    after = {
      "nvim-cmp",
      "vim-illuminate",
      "nvim-lspconfig",
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
      )
    end
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function() require("nvim-treesitter.configs").setup({
        ensure_installed = "maintained",
        highlight = { enable = true }
      })
    end,
    run = ":TSUpdate"
  }
  use { "mfussenegger/nvim-dap" }
  use { "nvim-lua/plenary.nvim" }
  use {
    "nvim-telescope/telescope.nvim",
    after = {
      "plenary.nvim",
    }
  }
  use { "liuchengxu/vista.vim" }
  use {
    "p00f/nvim-ts-rainbow",
    after = {
      "nvim-treesitter",
    },
    config = function() require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
          extended_mode = true
        } })
    end
  }
  use { "kyazdani42/nvim-web-devicons" }
  use {
    "kyazdani42/nvim-tree.lua",
    after = {
      "nvim-web-devicons",
    },
    config = default_config("nvim-tree"),
  }
  use {
    "nvim-lualine/lualine.nvim",
    config = default_config("lualine"),
  }
  use {
    "lewis6991/gitsigns.nvim",
    after = {
      "plenary.nvim",
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
  use { "ggandor/lightspeed.nvim" }
  use {
    "numToStr/Comment.nvim",
    config = default_config("Comment"),
  }
  use {
    "folke/trouble.nvim",
    after = {
      "nvim-web-devicons",
    },
    config = default_config("trouble"),
  }
  use {
    "TimUntersberger/neogit",
    after = {
      "plenary.nvim",
    }
  }
  use {
    "tami5/lspsaga.nvim",
    config = default_config("lspsaga"),
  }
  use {
    "akinsho/bufferline.nvim",
    after = {
      "nvim-web-devicons",
    },
    config = default_config("bufferline")
  }
  use {
    "windwp/nvim-ts-autotag",
    after = { "nvim-treesitter" },
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
      vim.cmd("colorscheme material")
    end
  }


end)
