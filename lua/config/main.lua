local cmd = vim.cmd
local env = vim.env
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

opt.directory = env.TMP or opt.directory
opt.backupdir = env.TMP or opt.backupdir
opt.undodir = env.TMP or opt.undodir

if env.ComSpec then
    if string.find(env.ComSpec, "cmd.exe") then
        opt.shell = "powershell"
        opt.shellcmdflag = "-Command"
        opt.shellquote = ""
        opt.shellxquote = ""
    end
end

if vim.g.vscode then
    keymap.set({ "n", "o", "x" }, "gc", "<Plug>VSCodeCommentary", {})
    keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine", {})
end
