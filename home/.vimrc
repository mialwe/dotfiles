execute pathogen#infect()
set laststatus=2
set nocompatible                                                  
syntax on                                                           
set number  
filetype plugin on
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set mouse=a
set hlsearch
set clipboard+=unnamedplus

set backupdir=~/.backup,/tmp
set directory=~/.backup,/tmp
" Omnicomplete -> SuperTab
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

set t_Co=16
let g:solarized_termcolors=16 
set background=dark 
colorscheme solarized 

" REDCODE HIGHLIGHTING
"let redcode_88_only = 1 
"let redcode_94_only = 1 

" AIRLINE
let redcode_highlight_numbers=1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t' 

filetype indent on
" Tab width to 2 spaces
autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType sass setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType scss setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType haml setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType erb setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 expandtab

nnoremap <silent> <F5> :<C-u>call system('xdotool windowactivate --sync $(xdotool search --onlyvisible --class Chromium-browser\|head -1) && xdotool key ctrl+r')<CR>    

autocmd FileType html,css,scss,python,sh,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

au BufNewFile,BufRead,BufEnter   *.wiki    setlocal spell    spelllang=de_de
au BufNewFile,BufRead,BufEnter   *.md      setlocal spell    spelllang=de_de
au BufNewFile,BufRead,BufEnter   *.txt     setlocal spell    spelllang=de_de
au BufNewFile,BufRead,BufEnter   README    setlocal spell    spelllang=en_us

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jar,*.tar,*.epub,*.azw3,*.mobi
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
