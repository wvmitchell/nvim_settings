"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Sections:
"
" 1. General
" 2. Movement
" 3. Plugins
" 4. Plugins Configuration & Mappings
" 5. Colors and Themes
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map leader to space
let mapleader=" "

" Set relative line numbers by default
set relativenumber

" Having longer updatetime leads to noticeable
" delays and poor user experience
set updatetime=300

" Set up the tab size and indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Set command line height to bottom
set cmdheight=1

" Set scroll offset
set scrolloff=8

" Explore view mappings
nnoremap <leader>e :Ex<cr>
nnoremap <leader>ve :Vex<cr>
nnoremap <leader>se :Sex<cr>

" Save on blur
autocmd BufLeave,FocusLost * silent! wall

" Fast saving
nnoremap <leader>w <cmd>w<CR>

" Fast quitting
nnoremap <leader>q <cmd>q<CR>

" Fast sourcing of the init.vim file
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Escape from insert mode
imap jj <Esc>

" Previous buffer
nmap ,, <C-^>

"Toggle line numbers
nmap nn :set invnumber<CR>

"Toggle relative line numbers
nmap rn :set invrelativenumber<CR>

" Disable highlight when <leader><leader> is pressed
map <silent> <leader><leader> :noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2. Movement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Resizing splits
nmap <Right> <C-w>>
nmap <Left> <C-w><
nmap <Up> <C-w>-
nmap <Down> <C-w>+

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 3. Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
    " Plugins for Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Plugin for Git integration
    Plug 'tpope/vim-fugitive'

    " Plugin for CoC
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Plugin for ALE
    Plug 'dense-analysis/ale'

    " Themes
    Plug 'ellisonleao/gruvbox.nvim'

    " Status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Syntax highlighting
    Plug 'sheerun/vim-polyglot'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4. Plugins Configuration & Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""" Telescope configuration
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
""""""""

"""""""" Coc.nvim configuration
" Have CoC show documentation if available
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Make <CR> accept completion in coc.nvim
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
""""""""

"""""""" ALE configuration
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'javascriptreact': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ 'ruby': ['syntax_tree', 'rubocop'],
      \ }

let g:ale_fix_on_save = 1
""""""""

"""""""" Airline Configuration
let g:airline_theme='base16_gruvbox_dark_hard' 
""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5. Colors and Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the colorscheme and background
colorscheme gruvbox
set background=dark

" Toggle background between light and dark
nnoremap <leader>t :call ToggleBackground()<CR>
function! ToggleBackground()
  if &background == "dark"
    set background=light
    execute 'AirlineTheme base16_gruvbox_light_hard'
  else
    set background=dark
    execute 'AirlineTheme base16_gruvbox_dark_hard'
  endif
endfunction
