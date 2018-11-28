# neovim.conf

Personal neovim installation and configuration instructions to hedge against the fallout from a Macbook explosion.

## Installing

1. Install `neovim` with Homebrew: `brew install neovim`
2. Install [vim-plug](https://github.com/junegunn/vim-plug):
    ```
    $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
3. Clone the `init.vim` file from this repo:
    ```
    $ curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/rnevius/neovim.conf/master/init.vim
    ```
4. Start `nvim` and install plugins via `:PlugInstall`
