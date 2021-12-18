local set = vim.opt

set.number = true
set.relativenumber = true
-- set.t_Co = 256
set.termguicolors = true

set.directory = vim.env.TEMP .. "/nvim//"
set.backupdir = vim.env.TEMP .. "/nvim//"
set.undodir = vim.env.TEMP .. "/nvim//"

if string.find(vim.env.ComSpec, "cmd.exe") then
	set.shell = "powershell"
	set.shellcmdflag = "-Command"
	set.shellquote = ""
	set.shellxquote = ""
end

require("./plugins")
