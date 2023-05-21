local cmd = vim.cmd
local env = vim.env
local fn = vim.fn
local g = vim.g
local keymap = vim.keymap
local opt = vim.opt

opt.splitright = true
opt.splitbelow = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"

opt.completeopt = { "menu", "menuone", "longest", "preview", "noselect" }

opt.mouse = "a"
cmd("filetype plugin indent on")
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.breakindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true

opt.backup = true
opt.undofile = true

if fn.has("unix") then
    opt.directory = "/tmp"
    opt.backupdir = "/tmp"
    opt.undodir = "/tmp"
else
    opt.directory = env.TMP or env.TEMP or opt.directory
    opt.backupdir = env.TMP or env.TEMP or opt.backupdir
    opt.undodir = env.TMP or env.TEMP or opt.undodir

    opt.shell = "powershell"
    opt.shellcmdflag = "-Command"
    opt.shellquote = ""
    opt.shellxquote = ""
end

vim.g.mapleader = " "

if g.vscode then
    keymap.set({ "n", "o", "x" }, "gc", "<Plug>VSCodeCommentary", {})
    keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine", {})
end
