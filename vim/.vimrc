set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Bundle 'gmarik/Vundle.vim'
Bundle 'vim-scripts/SuperTab--Van-Dewoestine'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'vim-scripts/Gundo'
Bundle 'vim-scripts/The-NERD-Commenter'
Bundle 'jimsei/winresizer'
Bundle 'bling/vim-airline'
Bundle 'plasticboy/vim-markdown'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'vim-pandoc/vim-pandoc-syntax'
Bundle 'tpope/vim-fugitive'
Bundle 'davidhalter/jedi-vim'
Bundle 'lervag/vim-latex'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'nsf/gocode', {'rtp': 'vim/'}
Bundle 'fatih/vim-go'
Bundle 'fatih/molokai'
Bundle 'vim-scripts/Tagbar'
Bundle 'moll/vim-node'
Bundle 'scrooloose/syntastic'
Bundle 'walm/jshint.vim'
Bundle 'ahayman/vim-nodejs-complete'
Bundle 'pangloss/vim-javascript'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mikewest/vimroom'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

nnoremap Q <nop>

" Set mapleader to space
let mapleader="\\"
map <Space> <Leader>

set showcmd
set nu

set clipboard=unnamedplus
set backspace=2

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set cindent

set incsearch

set hidden

filetype plugin indent on
filetype plugin on

syntax enable

set t_Co=256
set background=dark
colorscheme molokai

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>", "&completefunc:<c-x><c-u>"]
let g:SuperTabClosePreviewOnPopupClose = 1
autocmd FileType * 
      \ if &omnifunc != '' |
      \ call SuperTabChain(&omnifunc, "<c-p>") |
      \ call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
      \ endif

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files=0

" NERDTree
map <silent> <C-n> :NERDTreeFocus<CR>

" Eclim
nnoremap <leader>ei :JavaImport<cr>
nnoremap <leader>eo :JavaImportOrganize<cr>
nnoremap <leader>ed :JavaDocSearch -x declarations<cr>
nnoremap <leader>ep :JavaDocPreview<cr>
nnoremap <leader>es :JavaSearchContext<cr>
nnoremap <leader>ec :JavaDocComment<cr>
nnoremap <leader>eb :ProjectBuild<cr>

" Easier window switching
noremap <C-Up> <C-W>W
noremap <C-Down> <C-W>w
noremap <C-Right> <C-W>l
noremap <C-Left> <C-W>h

" Gundo
nnoremap <leader>g :GundoToggle<CR>
let g:gundo_auto_preview = 1
let g:gundo_preview_bottom=1

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just two key bindings.
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)
" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)

" vim-airline
set laststatus=2

" bufexplorer
map <Leader>f <Leader>be

" vim-pandoc
let g:pandoc#modules#enabled = ["formatting", "folding", "command", 
                                \ "menu", "keyboard"]

" spellcheck
nmap <silent> <leader>ze :setlocal spell spelllang=en<CR>
nmap <silent> <leader>zs :setlocal spell spelllang=es<CR>
nmap <silent> <leader>zo :setlocal nospell<CR>

" location key bindings
nmap <silent> <leader>ln :lne<CR>
nmap <silent> <leader>lp :lp<CR>

" Jedi
let g:jedi#popup_on_dot = 0

" Go
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_trailing_whitespace_error = 1

"JsBeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>

"Latex
let g:tex_conceal = ""
