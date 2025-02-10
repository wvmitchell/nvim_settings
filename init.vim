"""""
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
set number

" Having longer updatetime leads to noticeable
" delays and poor user experience
set updatetime=300

" Set up the tab size and indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

" Set command line height to bottom
set cmdheight=1

" Set scroll offset
set scrolloff=8

" Set foldmethod to syntax
set foldmethod=syntax
set foldlevelstart=99

" Function to close all folds only at top level
function! FoldTopLevelFunctions()
    " Start by opening all folds
    normal! zR

    " Close folds at the highest indent level
    let l:current_line = 1
    while l:current_line <= line('$')
        " Check the indent level of the current line
        let l:indent_level = indent(l:current_line)
        if l:indent_level == 0
            " Close fold at the current line
            if foldlevel(l:current_line) > 0
                execute l:current_line . ' foldclose'
            endif
        endif
        let l:current_line += 1
    endwhile
endfunction

" Create a custom command to call the function
command! FoldTop call FoldTopLevelFunctions()
nnoremap <leader>ft :FoldTop<CR>

" Explore view mappings
nnoremap <leader>e :Ex<cr>
nnoremap <leader>ve :Vex<cr>
nnoremap <leader>se :Sex<cr>

" New Views
nnoremap <leader>sv :vsp<cr>
nnoremap <leader>sh :sp<cr>

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

" Escape from visual mode
vnoremap <leader>jj <Esc>

" Previous buffer
nmap ,, <C-^>

"Toggle line numbers
nmap <leader>ln :set invnumber<CR>

"Toggle relative line numbers
nmap <leader>rn :set invrelativenumber<CR>

" Disable highlight when <leader><leader> is pressed
map <silent> <leader><leader> :noh<cr>

" Ignore case in commands & searches
set ignorecase

" Enable relative line numbers in netrw
augroup netrw_settings
  autocmd!
  autocmd FileType netrw setlocal relativenumber
augroup END

" Yank the current line to the system clipboard
nnoremap <Leader>y "+yy

" Yank the selected text in visual mode to the system clipboard
vnoremap <Leader>y "+y

" Yank the entire buffer to the system clipboard
nnoremap <Leader>Y gg"+yG

" Moving lines up and down & auto-indenting
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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

    " Plugin for Nerdtree
    Plug 'scrooloose/nerdtree'

    " Plugin for Commenting
    Plug 'numToStr/Comment.nvim'

    " Plugin for Git integration
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'

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
    Plug 'prisma/vim-prisma'

    " Window swapping
     Plug 'wesQ3/vim-windowswap'

    " CopilotChat
    Plug 'nvim-lua/plenary.nvim'
    Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }

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
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
""""""""

""""""""" Nerdtree configuration
" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
""""""""""

""""""""" Treesitter configuration

""""""""" Comment.nvim configuration
lua require('Comment').setup()
""""""""""

""""""""" Fugitive Configuration
" Git command remappings
" Git status
nnoremap <leader>gs :G st<CR>

" Git add (waiting for input)
nnoremap <leader>ga :G add 

" Git commit (waiting for message)
nnoremap <leader>gc :G commit -m 

" Git push
nnoremap <leader>gp :G push<CR>
""""""""""

"""""""" Polyglot configuration

"""""""" Coc.nvim configuration
" Have CoC show documentation if available
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocAction('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Have CoC show diagnostics for errors with CocDiagnostics
nnoremap <silent> <leader>cd <cmd>CocDiagnostics<CR>

" Make <CR> accept completion in coc.nvim
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim-0.4.0')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Go to definition
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
""""""""

"""""""" ALE configuration
""" Note: Did one of these stop working?
""" ensure you have the linters/fixers installed
""" and the executables in your PATH. Could be in the project
""" or globally installed.
""" If you've confrimed that, try running :ALEInfo
""" and see if the linters/fixers are detected.
""" If they're not, it could be a permissions issue. Ensure
""" that the executables have the right permissions to be run by ALE.
""" chmod +x <path to executable> should do the trick.
let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'javascriptreact': ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint'],
      \ 'mdx': ['prettier'],
      \ 'ruby': ['remove_trailing_lines', 'rubocop'],
      \ 'eruby': ['htmlbeautifier'],
      \ 'go': ['gofmt', 'gopls'],
      \ }

let g:ale_linters = {
      \ 'go': ['gofmt', 'golangci-lint', 'gopls', 'govet', 'revive'],
      \ }

let g:ale_fix_on_save = 1
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_ruby_use_rbenv = 1

nnoremap <leader>d :ALEDetail<CR>
""""""""

"""""""" Airline Configuration
let g:airline_theme='base16_gruvbox_dark_hard' 
""""""""

"""""""" Window Swap Configuration
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ss :call WindowSwap#EasyWindowSwap()<CR>
""""""""

"""""""" Copilot Configuration
" Copilot keybindings
imap <C-j> <Plug>(copilot-next)
imap <C-k> <Plug>(copilot-previous)
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
""""""""

"""""""" CopilotChat Configuration

lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
EOF

nnoremap <leader>ce <cmd>CopilotChatExplain<cr>
nnoremap <leader>cc <cmd>CopilotChatReset<cr>
nnoremap <leader>cf <cmd>CopilotChatFix<cr>
nnoremap <leader>ct <cmd>CopilotChatTest<cr>
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
