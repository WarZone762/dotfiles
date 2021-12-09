return require("packer").startup(function()
	use "wbthomason/packer.nvim"

	use "tpope/vim-fugitive"
	use "tpope/vim-surround"
	use "scrooloose/nerdtree"
	use {"scrooloose/syntastic", disable = true}
	use "airblade/vim-gitgutter"
	use "vim-airline/vim-airline"
	use "scrooloose/nerdcommenter"
	use "majutsushi/tagbar"
	-- use "valloric/youcompleteme', {'do': 'install.py --msvc 17 --cmake-path \"C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe\"'"
	use "tpope/vim-repeat"
	use {"w0rp/ale", disble = true}
	
	use "yggdroot/indentline"
	use "easymotion/vim-easymotion"
	use "mg979/vim-visual-multi"
	use "luochen1990/rainbow"
	use "tpope/vim-eunuch"
	use "editorconfig/editorconfig-vim"
	use "tpope/vim-abolish"
	use "raimondi/delimitmate"
	use "kkoomen/vim-doge"
	use "terryma/vim-expand-region"
	use "sjl/gundo.vim"
	use "godlygeek/tabular"
	use "wellle/targets.vim"
	use "kana/vim-textobj-user"
	use "kana/vim-textobj-line"
	use "michaeljsmith/vim-indent-object"
	use "kana/vim-textobj-entire"
	use "tpope/vim-unimpaired"
	use "tpope/vim-vinegar"
	use "tpope/vim-sensible"
		
	use {"ms-jpq/coq_nvim", branch = "coq", requires = {"ms-jpq/coq.artifacts", branch = "artifacts"}, run = ":autocmd VimEnter * COQdeps", config = vim.api.nvim_command("autocmd VimEnter * COQnow")}
	use {"nvim-telescope/telescope.nvim", requires = {"nvim-lua/plenary.nvim"}}

end)

