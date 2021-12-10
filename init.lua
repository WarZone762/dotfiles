local set = vim.opt

set.number = true
set.relativenumber = true
-- set.t_Co = 256
set.termguicolors = true

set.directory = "F:/Temp/Neovim//"
set.backupdir = "F:/Temp/Neovim//"
set.undodir = "F:/Temp/Neovim//"

if string.find(vim.env.ComSpec, "cmd.exe") then
	set.shell = "powershell"
	set.shellcmdflag = "-Command"
	set.shellquote = ""
	set.shellxquote = ""
end

require("./plugins")
