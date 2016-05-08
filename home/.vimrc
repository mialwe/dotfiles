execute pathogen#infect()

let mapleader=","
syntax on
filetype plugin on
filetype indent on

set encoding=utf8               " default encoding
set wildmenu                    " autocomplete for command menu
set ttimeoutlen=50
set laststatus=2
set mouse=a

set noshowmode
set nocompatible

"set list
"set list listchars=tab:▸\ ,eol:¬
"set list lcs=trail:·,tab:»·
set clipboard+=unnamedplus
set backupdir=~/.backup,/tmp
set directory=~/.backup,/tmp

set number                      " show line numbers
"set colorcolumn=80              " highlight column 80
set cursorline                  " highlight current line
set showmatch                   " highlight matching )]}
set mat=2                       " blinking matching )]} in seconds

" Indenting
set smartindent
set expandtab                   " TAB key expands to spaces
set tabstop=4                   " <TAB> in file expands to 4 spaces
set softtabstop=4               " number of spaces for TAB key
set shiftwidth=4
set smarttab

" Split separator without background color:
set fillchars+=vert:│
hi VertSplit cterm=NONE ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" Wrapping
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

" Buffers
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za

" Search
set hlsearch                    " highlight search results
set incsearch                   " search as chars are entered
nnoremap <leader><space> :nohlsearch<CR>
set ignorecase                  " ignore case when searching

" Status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" REDCODE HIGHLIGHTING
let redcode_highlight_numbers=1
let redcode_94_only = 1
"let redcode_88_only = 1

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn

    autocmd BufRead, BufNewFile *.ctp set filetype=php

    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4

    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4

    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s

    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2

    autocmd FileType html,css,scss,python,sh,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

" Refresh browser via keypress
noremap <silent> <F5> :<C-u>call system('xdotool windowactivate --sync $(xdotool search --onlyvisible --class Chromium-browser\|head -1) && xdotool key ctrl+r')<CR>

" Spell checking
au BufNewFile,BufRead,BufEnter   *.wiki    setlocal spell    spelllang=de_de,en_us
au BufNewFile,BufRead,BufEnter   *.md      setlocal spell    spelllang=de_de,en_us
au BufNewFile,BufRead,BufEnter   *.txt     setlocal spell    spelllang=de_de,en_us
au BufNewFile,BufRead,BufEnter   README    setlocal spell    spelllang=en_us

" Copy/paste via xclip
nnoremap <leader> c:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nnoremap <leader> v:call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

hi CursorLineNR cterm=bold ctermfg=220
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermfg=220
augroup END

" Cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Theme
set t_Co=256                    " terminal colors
set t_ZH=[3m
set t_ZR=[23m
set background=dark             " solarized type
let g:solarized_termcolors=16   " solarized colors
colorscheme solarized           " set color scheme

function! BgToggleSol()
  if &background == "light"
    execute ":set background=dark"
  else
    execute ":set background=light"
  endif
endfunction

nnoremap <F10> :call BgToggleSol()<cr>


" Plugin vim-markdown:
let g:vim_markdown_frontmatter=1        " highlight frontmatter
let g:vim_markdown_folding_disabled=1   " disable folding

" Plugin airline
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = '%{getcwd()}'     " show current working dir
"let g:airline_left_sep=''
"let g:airline_right_sep=''

" make Esc happen without waiting for timeoutlen
" fixes Powerline delay
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

" Plugin syntastic
let g:syntastic_check_on_open = 1

" Plugin neocomplete
let g:neocomplete#enable_at_startup = 1

" Plugin gundo
nnoremap <F4> :GundoToggle<CR>

" Plugin tagbar
nmap <F3> :TagbarToggle<CR>
nnoremap t <C-]>

" Plugin nerdtree
nmap <F2> :NERDTreeToggle<CR>
"let NERDTreeQuitOnOpen = 1

" Plugin Syntasic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Plugin CtrlP
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g "" --nogroup --ignore "\Android\|\.git$\|\.hg$\|\.svn$"'
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window ='results:50'

" Plugin PHP Documentor
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
"nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>
autocmd BufRead,BufNewFile *.php nnoremap <buffer> <leader>d :call pdv#DocumentWithSnip()<CR>
autocmd BufRead,BufNewFile *.ctp nnoremap <buffer> <leader>d :call pdv#DocumentWithSnip()<CR>


" Plugin ag
set runtimepath^=~/.vim/bundle/ag

" From https://amix.dk/vim/vimrc.html: Return to last edit position
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

set tags=tags;

" Highlight trailing whitespace
"highlight ws ctermbg=red guibg=red
"match ws /\s\+$/
"autocmd BufWinEnter * match ws / \+$/

set list listchars=tab:▸·,trail:·
set backspace=indent,eol,start
" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
echohl ErrorMsg
echomsg a:msg
echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
if empty(a:buffer)
let btarget = bufnr('%')
elseif a:buffer =~ '^\d\+$'
let btarget = bufnr(str2nr(a:buffer))
else
let btarget = bufnr(a:buffer)
endif
if btarget < 0
call s:Warn('No matching buffer for '.a:buffer)
return
endif
if empty(a:bang) && getbufvar(btarget, '&modified')
call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
return
endif
" Numbers of windows that view target buffer which we will delete.
let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
if !g:bclose_multiple && len(wnums) > 1
call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
return
endif
let wcurrent = winnr()
for w in wnums
execute w.'wincmd w'
let prevbuf = bufnr('#')
if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
buffer #
else
bprevious
endif
if btarget == bufnr('%')
" Numbers of listed buffers which are not the target to be deleted.
let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
" Listed, not target, and not displayed.
let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
" Take the first buffer, if any (could be more intelligent).
let bjump = (bhidden + blisted + [-1])[0]
if bjump > 0
execute 'buffer '.bjump
else
execute 'enew'.a:bang
endif
endif
endfor
execute 'bdelete'.a:bang.' '.btarget
execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')
nnoremap <silent> <Leader>bd :Bclose<CR>
nnoremap <silent> <Leader>bD :Bclose!<CR>













































































































