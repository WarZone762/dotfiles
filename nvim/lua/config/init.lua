local api = vim.api
local cmd = vim.cmd
local env = vim.env
local fn = vim.fn
local g = vim.g
local keymap = vim.keymap
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"

opt.completeopt = { "menu", "menuone", "longest", "preview", "noselect" }

opt.mouse = "a"
cmd("filetype plugin indent on")

opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.smartindent = true
opt.breakindent = true

opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 8

opt.termguicolors = true

opt.backup = true
opt.undofile = true

if fn.has("unix") then
    opt.directory = "/tmp/nvim"
    opt.backupdir = "/tmp/nvim"
    opt.undodir = "/tmp/nvim"
else
    opt.directory = env.TMP or env.TEMP or opt.directory
    opt.backupdir = env.TMP or env.TEMP or opt.backupdir
    opt.undodir = env.TMP or env.TEMP or opt.undodir

    opt.shell = "powershell"
    opt.shellcmdflag = "-Command"
    opt.shellquote = ""
    opt.shellxquote = ""
end

g.mapleader = " "

keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set({ "n", "v" }, "<leader>p", [["+p]])
keymap.set("n", "<leader>P", [["+P]])

keymap.set("n", "<C-k>", "<cmd>cnext<CR>")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>")

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- save without formatting
vim.api.nvim_create_user_command("Wnf", "noautocmd w", {})

api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        cmd([[%s/\s\+$//e]])
        vim.lsp.buf.format()
    end
})

if g.vscode then
    keymap.set({ "n", "o", "x" }, "gc", "<Plug>VSCodeCommentary", {})
    keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine", {})
end
