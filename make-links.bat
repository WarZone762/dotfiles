rmdir /S /Q out
mkdir out
mklink "out/settings.json" "%cd%/settings.json"
mklink "out/keybindings.json" "%cd%/keybindings.json"
mklink /D "out/nvim" "%cd%/nvim"
