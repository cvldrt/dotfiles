:syntax on
:set nu
:set relativenumber
:set cursorline
:set list
:set noerrorbells
:set nowrap
:set autoindent
:set tabstop=4
:set softtabstop=4
:set expandtab
:set shiftwidth=4
:set smartindent
:set smarttab
:set incsearch
:set scrolloff=8
:set mouse=a
:set title
:set colorcolumn=80
:set noshowmode
:set encoding=utf-8
:set showtabline=2 " shows tabline even with only one tab open
:set clipboard=unnamedplus

let g:python3_host_prog="/path/to/python/executable/"

" disable warning because of older neovim version
let g:coc_disable_startup_warning = 1

" use arrows to move between tabs
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" switch between header and source file
nnoremap <C-k> :CocCommand clangd.switchSourceHeader<CR>

" use <jj> to return to normal mode
" inoremap jj <Esc>h 

" center screen after moving half a page
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

call plug#begin('~/.config/nvim/plugs')

    " automatically pairs parentheses
    Plug 'tmsvg/pear-tree'

    " completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " statusline config
    Plug 'itchyny/lightline.vim'

    " file explorer tree
    Plug 'https://github.com/preservim/nerdtree'

    " colorschemes
    Plug 'morhetz/gruvbox'
    Plug 'https://github.com/rafi/awesome-vim-colorschemes' 

    " C code family formatter
    Plug 'https://github.com/rhysd/vim-clang-format'

    " Python code formatter
    Plug 'vim-autoformat/vim-autoformat'

    " make vim transparent
    Plug 'tribela/vim-transparent'

    " show indent depth
    Plug 'Yggdroot/indentLine'

    " fuzzy finder
    Plug 'ctrlpvim/ctrlp.vim'

    " highlight yanked text
    Plug 'machakann/vim-highlightedyank'

    " better highlighting for C/C++
    Plug 'jackguo380/vim-lsp-cxx-highlight'

    " working with cmake projects"
    Plug 'cdelledonne/vim-cmake'

call plug#end()	

" set yank highlight duration
let g:highlightedyank_highlight_duration = 500

" colorschemes
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox

" makes cursorline a line
hi clear CursorLine
hi CursorLine gui=underline cterm=underline

" default
let g:transparent_groups = ['Normal', 'Comment', 'Constant', 'Special', 'Identifier',
                            \ 'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
                            \ 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
                            \ 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer']

" coc.nvim
nmap <leader>qf <Plug>(coc-fix-current) 
let g:transparent_groups += ['NormalFloat', 'CocFloating']

augroup transparent
    autocmd VimEnter,ColorScheme * call MyTransparent()
augroup END

function! MyTransparent()
    " Customize the highlight groups for transparency in here.

    " CursorLine
    hi CursorLineNr ctermfg=NONE ctermbg=239 guibg=NONE guibg=#4e4e4e

    " coc.nvim
    hi CocMenuSel ctermbg=239 guibg=#4e4e4e
endfunction

let g:pear_tree_repeatable_expand=0


" pick lightline colorscheme
let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ }

"use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()

" improve netrdtree look
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

" use ctrl - p to invoke CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" default search in cwd
let g:ctrlp_working_path_mode = 'r'
" opens file in new tab by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_custom_ignore = '\v[\/](\.git|Build|Debug)'

" clang format setting
let g:clang_format#style_options = {
            \ "AlignConsecutiveAssignments" : "Consecutive",
            \ "AlignAfterOpenBracket" : "true",
            \ "AllowShortFunctionsOnASingleLine" : "false",
            \ "BreakBeforeBraces": "Custom",
            \ "BraceWrapping" : {"AfterFunction": "true"},
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}


