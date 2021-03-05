" vim: foldmethod=marker
let mapleader = ","

"    Plugins   {{{
""""""""""""""""""
call plug#begin()

Plug 'airblade/vim-gitgutter'
  let g:gitgutter_sign_priority = 9

Plug 'andrewradev/splitjoin.vim'
  let g:splitjoin_trailing_comma = 1

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
  let g:fzf_layout = { 'down': '40%' }
  let g:fzf_preview_window = []
  nnoremap <silent> <Leader>e :Files<CR>
  nnoremap <silent> <Leader>ls :Buffers<CR>
  nnoremap <Leader>f :Rg<Space>
  autocmd! FileType fzf set laststatus=0 noruler
    \| autocmd BufLeave <buffer> set laststatus=2 ruler

Plug 'lifepillar/vim-colortemplate'
  let g:colortemplate_creator = 0

Plug 'lifepillar/vim-solarized8'
Plug 'ludovicchabant/vim-gutentags'
  if executable('rg')
    let g:gutentags_file_list_command = 'rg --files'
  endif

Plug 'neovim/nvim-lspconfig'

Plug 'psliwka/vim-smoothie'
  let g:smoothie_base_speed = 32
  let g:smoothie_update_interval = 10

Plug 'rakr/vim-one'
  let g:one_allow_italics = 1

Plug 'sheerun/vim-polyglot'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
  nnoremap <Leader>s :Obsession<CR>

Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

" Local Plugs
Plug '~/.config/nvim/plugged/vim-execution/'
  xmap @ <Plug>(execution_execute)

Plug '~/.config/nvim/plugged/vim-groovy-theme/'
call plug#end()
" }}}

"   Interface  {{{
""""""""""""""""""
" Fix vim-specific rendering bug in kitty terminal
" https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''
if has('termguicolors')
  set termguicolors
endif
colorscheme one-nvim
set background=light
set colorcolumn=81
set cursorline
set diffopt+=vertical
set guifont=MesloLGS_NF:h13
set list listchars=tab:│\ ,trail:¬,nbsp:·

" Signs
sign define LspDiagnosticsSignError text=✘ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=‼ texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=‼ texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

" Statusline  {{{
augroup CustomColors
  autocmd!
  autocmd VimEnter,ColorScheme * call statusline#SetCustomHighlights()
augroup END

set statusline=\ 
set statusline+=%f\ 
set statusline+=%h%m%r\ 
set statusline+=%<
set statusline+=%{statusline#LSPStatus()}\ 
set statusline+=%=
set statusline+=%<
set statusline+=%#Search#
set statusline+=%{statusline#ALEFixStatus()}
set statusline+=%*
set statusline+=%{statusline#GitBranch()}\ 
set statusline+=%{statusline#SessionStatus()}\ 
set statusline+=☰\ \ %l/%L\ :\ %2c
set statusline+=\ 
" }}}
" }}}

"   Editing  {{{
""""""""""""""""
set autoindent
set backspace=indent,eol,start
set belloff=all
set complete+=i
if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep
  " From https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
  function! Grep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
  endfunction

  command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

  cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
  cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

  augroup GrepQuickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
  augroup END
endif
set expandtab
set hidden
set history=10000
set hlsearch
set ignorecase
if exists('&inccommand')
  set inccommand=nosplit
endif
set incsearch
set laststatus=2
set linebreak
set modelines=1
set mouse=n
set nojoinspaces
set noswapfile
set number
set path=.
if executable('fd')
  let &path = join([&path, system('fd -at d | paste -sd, -')], ',')
else
  set path+=**
endif
set ruler
set scrolloff=2
set shiftround
set shiftwidth=2
set shortmess+=Ic
set smartcase
set smarttab
set splitbelow
set splitright
set startofline
set tabstop=2
set undofile
set updatetime=500
set wildignore+=*/node_modules/*,*/__pycache__/*,.git/
set wildignore+=*.sw[ponm],*.gif,*.jpg,*.jpeg,*.png,*.pdf,tags,tags.*,*.o,*.class,*.java.html,*.pyc,*.pyo
set wildignorecase
set wildmenu
set wildmode=list:full
" }}}

"   Mappings  {{{
"""""""""""""""""
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
inoremap <C-r> <C-r><C-o>
nnoremap c* *Ncgn
nnoremap Q q

" Buffers / Windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
let terminal_event = has('nvim') ? 'TermOpen' : 'TerminalOpen'
augroup terminal_escape
  autocmd!
  execute 'autocmd ' . terminal_event . ' * tnoremap <buffer> <Esc> <C-\><C-N>'
  autocmd FileType fzf tunmap <buffer> <Esc>
augroup END
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" Cycle through buffers
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
" Cycle through quickfix list
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
" Cycle through location list
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>

" Leader mappings
nnoremap <Leader>] :vert winc ]<CR>
nnoremap <Leader>/ :nohlsearch<CR>
nnoremap <Leader>= `[v`]=
nnoremap <Leader>bd :set background=dark<CR>
nnoremap <Leader>bl :set background=light<CR>
nnoremap <Leader>cd :lcd %:h<CR>
" nnoremap <leader>e :e <C-R>=expand("%:.:h") . "/"<CR>
" nnoremap <Leader>f :find *
" }}}

"   Commands / Functions  {{{
"""""""""""""""""""""""""""""
" Search for visual block instances
" Inspiration: https://github.com/nelstrom/vim-visual-star-search/
function! s:VisualSearch(searchcmd)
  let temp = @s
  normal! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:searchcmd.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
xnoremap * :<C-U>call <SID>VisualSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-U>call <SID>VisualSearch('?')<CR>?<C-R>=@/<CR><CR>

command! -nargs=1 -complete=command -bar -range Redir silent
      \ call redir#Redir(<q-args>, <range>, <line1>, <line2>)

command! FlutterRun call flutter#RunWithPID()

" Remove whitespace on empty lines, on :write
function! TrimWhitespace()
  let l:view = winsaveview()
  keeppatterns %s/^\s\+$//e
  call winrestview(l:view)
endfun
augroup AutoFix
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END
" }}}

" Project-specific autocommands
if filereadable(expand("~/.config/nvim/projects.vim"))
  source ~/.config/nvim/projects.vim
endif

if exists(':luafile') > 1
  lua require('lsp-config')
endif
