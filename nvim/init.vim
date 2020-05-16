" vim: foldmethod=marker
let mapleader = ","

"    Plugins   {{{
""""""""""""""""""
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'andrewradev/splitjoin.vim'
  let g:splitjoin_join_mapping = ''
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_trailing_comma = 1

Plug 'dense-analysis/ale'
  let g:ale_lint_delay=0
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': ['prettier', 'eslint'],
  \   'ruby': ['rubocop'],
  \ }
  let g:ale_linters = {
  \   'ruby': ['rubocop'],
  \ }
  let g:ale_python_auto_pipenv=1
  let g:ale_sign_error='✘'
  let g:ale_sign_warning='‼'
  nmap <Leader>a <Plug>(ale_fix)
  nmap ]a <Plug>(ale_next_wrap)
  nmap [a <Plug>(ale_previous_wrap)

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
  let g:fzf_preview_window = ''
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

Plug 'neovim/nvim-lsp'
  " Node dependencies:
  " npm install -g \
  "   vscode-html-languageserver-bin \
  "   typescript-language-server \
  "   vim-language-server \

  " Brew-available formulae:
  " brew tap dart-lang/dart && \
  " brew install \
  "   dart \
  "   golang

  " Pip dependencies:
  " pip3 install python-language-server

  " Ruby dependencies:
  " gem install solargraph
Plug 'haorenW1025/completion-nvim'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"   let g:coc_global_extensions = [
"     \ 'coc-css',
"     \ 'coc-eslint',
"     \ 'coc-flutter',
"     \ 'coc-html',
"     \ 'coc-json',
"     \ 'coc-markdownlint',
"     \ 'coc-python',
"     \ 'coc-solargraph',
"     \ 'coc-tsserver',
"     \ 'coc-yaml',
"   \ ]
"
"
"   function! s:show_documentation()
"     if (index(['vim','help'], &filetype) >= 0)
"       execute 'h '.expand('<cword>')
"     else
"       call CocAction('doHover')
"     endif
"   endfunction
"
"   inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"   inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"   nmap <Leader>gd <Plug>(coc-definition)
"   nmap <Leader>gi <Plug>(coc-implementation)
"   nmap <Leader>gr <Plug>(coc-references)
"   nmap <Leader>rn <Plug>(coc-rename)
"   nnoremap <silent> K :call <SID>show_documentation()<CR>
"
Plug 'psliwka/vim-smoothie'
  let g:smoothie_base_speed = 32
  let g:smoothie_update_interval = 10

Plug 'rakr/vim-one'
  let g:one_allow_italics = 1

Plug 'sheerun/vim-polyglot'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tomtom/tcomment_vim'
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

" LSP Configuration
if exists('g:nvim_lsp')
lua << EOF
  local nvim_lsp = require'nvim_lsp'
  -- Disable Diagnostcs globally
  vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end

  -- Extensions
  nvim_lsp.dartls.setup{}
  nvim_lsp.gopls.setup{}
  nvim_lsp.html.setup{}
  nvim_lsp.pyls.setup{}
  nvim_lsp.solargraph.setup{}
  nvim_lsp.tsserver.setup{}
  nvim_lsp.vimls.setup{}
EOF

augroup LSP
  autocmd!
  autocmd BufEnter * lua require'completion'.on_attach()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_enable_auto_popup = 0

nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>gr <cmd>lua vim.lsp.buf.references()<CR>
endif
" }}}

"   Interface  {{{
""""""""""""""""""
" Fix vim-specific rendering bug in kitty terminal
" https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''
if has('termguicolors')
  set termguicolors
endif
colorscheme one
set background=light
set colorcolumn=81
set cursorline
set diffopt+=vertical
set guifont=MesloLGS_NF:h13
set list listchars=tab:│\ ,trail:¬,nbsp:·

" Statusline  {{{
augroup CustomColors
  autocmd!
  autocmd VimEnter,ColorScheme * call statusline#SetCustomHighlights()
augroup END

set statusline=\ 
set statusline+=%f\ 
set statusline+=%h%m%r\ 
set statusline+=%<
" set statusline+=%{coc#status()}\ 
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

  augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
  augroup END
endif
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
set path=.,**
set ruler
set scrolloff=2
set shiftround
set shiftwidth=2
set shortmess+=I
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

" }}}

" Project-specific autocommands
if filereadable(expand("~/.config/nvim/projects.vim"))
  source ~/.config/nvim/projects.vim
endif
