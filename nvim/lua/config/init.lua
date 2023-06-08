local api = vim.api
local env = vim.env
local fn = vim.fn
local g = vim.g
local keymap = vim.keymap
local lsp = vim.lsp
local opt = vim.opt

opt.relativenumber = true
opt.colorcolumn = "100"
opt.completeopt = "menu,menuone,longest,preview,noselect"

opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.scrolloff = 8

if fn.has("unix") then
    opt.directory = "/tmp/nvim/swap"
    opt.undodir = "/tmp/nvim/undo"
else
    opt.directory = ((env.TMP or env.TEMP) .. "\\swap") or opt.directory
    opt.undodir = ((env.TMP or env.TEMP) .. "\\undo") or opt.undodir
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

api.nvim_create_user_command("WriteWithoutFormatting", "noautocmd w", {})
api.nvim_create_user_command("Wwf", "noautocmd w", {})

api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        lsp.buf.format()
    end
})
