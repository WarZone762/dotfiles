local vim = vim
local opt = vim.opt
local cmd = vim.cmd

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

require("./plugins")
