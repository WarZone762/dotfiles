local vim = vim
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

opt.completeopt = {"menu", "menuone", "longest", "preview", "noselect"}

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

opt.directory = vim.env.TEMP .. "/nvim//"
opt.backupdir = vim.env.TEMP .. "/nvim//"
opt.undodir = vim.env.TEMP .. "/nvim//"

if string.find(vim.env.ComSpec, "cmd.exe") then
	opt.shell = "powershell"
	opt.shellcmdflag = "-Command"
	opt.shellquote = ""
	opt.shellxquote = ""
end

if vim.fn.exists("g:vscode") == 1 then
	api.nvim_set_keymap("x", "gc", "<Plug>VSCodeCommentary", {})
	api.nvim_set_keymap("n", "gc", "<Plug>VSCodeCommentary", {})
	api.nvim_set_keymap("o", "gc", "<Plug>VSCodeCommentary", {})
	api.nvim_set_keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {})

	api.nvim_command("highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline")
	api.nvim_command("highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")
end

-- Plugins

require("plugins")

