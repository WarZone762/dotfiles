local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt

opt.splitright = true
opt.splitbelow = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"

opt.completeopt = { "menu", "menuone", "longest", "preview", "noselect" }

opt.mouse = "a"
cmd("filetype plugin indent on")
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.breakindent = true

opt.ignorecase = true
opt.smartcase = true

opt.backup = true
opt.undofile = true

-- opt.t_Co = 256
opt.termguicolors = true

opt.directory = vim.env.TEMP or ("/tmp" .. "/nvim//")
opt.backupdir = vim.env.TEM or ("/tmp" .. "/nvim//")
opt.undodir = vim.env.TEM or ("/tmp" .. "/nvim//")

if vim.env.ComSpec then
  if string.find(vim.env.ComSpec, "cmd.exe") then
    opt.shell = "powershell"
    opt.shellcmdflag = "-Command"
    opt.shellquote = ""
    opt.shellxquote = ""
  end
end

if vim.fn.exists("g:vscode") == 1 then
  api.nvim_set_keymap("x", "gc", "<Plug>VSCodeCommentary", {})
  api.nvim_set_keymap("n", "gc", "<Plug>VSCodeCommentary", {})
  api.nvim_set_keymap("o", "gc", "<Plug>VSCodeCommentary", {})
  api.nvim_set_keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {})

  api.nvim_command("highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline")
  api.nvim_command("highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")

  vim.g.EasyMotion_do_mapping = 0
  vim.g.EasyMotion_smartcase = 1
  api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s)", {})
end

-- Plugins

require("plugins")
