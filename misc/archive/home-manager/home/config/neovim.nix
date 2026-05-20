{ config, pkgs, ... }:

{
  #home.sessionVariables = {
  #  EDITOR = "nvim";
  #};

  home.packages = with pkgs; [
    neovim-remote
  ];

  programs.neovim = {
    enable = true;

    extraConfig = ''
      set clipboard+=unnamedplus
      set mouse=a

      set nowrap
      set nojoinspaces

      set completeopt=menu,preview,longest
      set wildmode=longest:full

      let g:netrw_keepdir=0

      autocmd TermOpen * startinsert
      autocmd WinEnter term://* startinsert
      tnoremap <C-W> <C-\><C-N><C-W>

      set splitbelow
      set splitright
      highlight VertSplit cterm=NONE
    '';
  };

  programs.zsh = {
    shellAliases = {
      vim = "nvim";
      neovim-init = "tail -1 $(which nvim) | sed 's:.*-u \(/.*\.vim\).*:\1:'";
    };
  };
}

# TODO:
# - :tabnew and :Man start in insert mode; can they start in normal mode instead?
#   - Does this have anything to do with my current autocmds?
# - count number of matches in a search
# - interactive search and replace?
# - netrw goes to source of symlinked directories, which makes it impossible to
#   navigate back. What are some alternatives to netrw?
# - automatically update colorscheme based on terminal?
# - colors/styles (can these colors be somehow coordinated with the terminal color scheme?):
#   - highlighted search results
#   - status bar and completion menu styling
# - single session? Try nvr?
#   - edit files in current session from terminal buffer?
#   - maybe alias vi and vim to use a new nvim session? (and set EDITOR to vi or vim)
# - LSP?
# - treesitter?
# - which-key (whatever is used by spacevim)
# - neoterm?
