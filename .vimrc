" ###############################################################################################
" #
" #  Configuration required for Vundle
" #
" ###############################################################################################
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" Asynchronous Lint Engine
" https://github.com/dmerejkowsky/vim-ale#standard-installation
Plugin 'w0rp/ale'
"
" C-Development related plugins
Plugin 'frazrepo/vim-rainbow'
" gruvbox color scheme
Plugin 'morhetz/gruvbox'
"
" Ansible plugin
Plugin 'pearofducks/ansible-vim'
"
" Nerd Tree
Plugin 'preservim/nerdtree'
nnoremap <C-1> :NERDTreeFocus<CR>
nnoremap <C-`> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-g> :NERDTreeVCS<CR>
"
" Status bar
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_theme='gruvbox'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
"
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty=' '

" let g:airline_theme='term'


" Syntax highlighting Ansible's common filetypes
" https://github.com/pearofducks/ansible-vim
"Plugin 'pearofducks/ansible-vim'
"Plugin 'chase/vim-ansible-yaml'

" YAML syntax/indent support
" Plugin 'tarekbecker/vim-yaml-formatter'
"
" All of your Plugins must be added before the following line
call vundle#end()            " required

" Enable indentaion
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
"

" ###############################################################################################
" #
" #  Put your non-Plugin stuff after this line
" #
" ###############################################################################################
"
set spell spelllang=en_gb
set nospell

" force 256 colors on the terminal
set t_Co=256

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" load the color scheme before anything
" colorscheme desert
" colorscheme elflord
" colorscheme slate
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=0
let g:gruvbox_italicize_comments=1

" A set of VIM colour themes
" https://vimcolorschemes.com/
"
" https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_bold
colorscheme gruvbox

" set dark background mode
set background=dark

" the syntax cmd is when the colorscheme gets parse, I think..
syntax on


" Switch off vim:go version complains
let g:go_version_warning = 0

" Turn on ruler
set ruler

" Turn off paste mode
set nopaste

" Enable the cursorline
set cursorline

" Exit discarding changes pressing 'q' twice
map qq :qa!<cr>

" Clear last search highlight with <Ctrl-h>
map <C-h> :noh<cr>

" Write the file with <Ctrl-w>
map <c-w> :w<cr>

" Inverse 'set paste' mode with <Ctrl-p>
map <c-p> :set paste!<cr>

" Clear trailing spaces
map <c-i> :%s/\s\+$//<cr>

" Replace tabs with spaces
map <c-t> :%s/\t\+/    /g<cr>

" Correct spelling piching the first variant
map <c-l> <Esc>lz=1<cr><cr>

" Highlight whole cursor line
set cursorline
highlight CursorLine cterm=NONE ctermbg=234 guibg=#3c3836
highlight CursorColumn cterm=NONE ctermbg=234 guibg=#3c3836
"hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white

" Change search highlight settings
"highlight Search ctermfg=Black ctermbg=Yellow cterm=NONE
highlight Search cterm=NONE ctermbg=darkred ctermfg=white

" Set list chars
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nolist

" Set tab size
set tabstop=4
set shiftwidth=4
set expandtab


" Workaround for mismatched background color in kitty terminal
let &t_ut=''

" File types management
augroup filetypedetect
"   Add jinja2 filetype
    autocmd! BufNew,BufNewFile,BufRead *.j2,*.jinja,*.jinja2 setfiletype jinja2 | source ~/.vim/syntax/jinja.vim
"   Add json filetype
    autocmd! BufNew,BufNewFile,BufRead *.json set syntax=json | setfiletype json | source ~/.vim/syntax/json.vim
augroup END

