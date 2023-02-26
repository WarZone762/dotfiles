local fn = vim.fn
local loop = vim.loop
local opt = vim.opt

-- Lazy bootstrap
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
    fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
opt.rtp:prepend(lazypath)

-- Plugins
---@type table<integer, string | table>
local plugins = {}

for _, v in pairs(require("plugins.headless")) do
    table.insert(plugins, v)
end

for _, v in pairs(require("plugins.standalone")) do
    if type(v) == "string" then
        v = { v }
    end
    v.cond = function()
        return fn.exists("g:vscode") == 0
    end

    table.insert(plugins, v);
end

require("lazy").setup(plugins)
