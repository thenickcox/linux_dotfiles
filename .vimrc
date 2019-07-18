execute pathogen#infect()

set nocompatible
filetype off

" Set , to be leader key
let mapleader = ","

set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

set guifont=Monaco:h13
set guioptions-=T
set hlsearch
let &t_Co=256

set clipboard=unnamedplus

" Make backspace do that thing it's supposed to do
set backspace=2

" Dont ask to re-read files changed outside vim
set autoread

set rnu "relative line numbers

function! g:ToggleNuMode()
if(&rnu == 1)
set nu
else
set rnu
endif
endfunc

nnoremap <C-L> :call g:ToggleNuMode()<cr>

set rtp+=~/.vim/bundle/vundle/

let g:ruby_debugger_progname = 'vim'

syntax enable
filetype plugin indent on


set ignorecase

" New buffer at direction
nmap <leader>sh  :leftabove  vnew<CR>
nmap <leader>sl  :rightbelow vnew<CR>
nmap <leader>sk  :leftabove  new<CR>
nmap <leader>sj  :rightbelow new<CR>

" traverse splits
nnoremap <leader>wh <C-w>h
nnoremap <leader>wl <C-w>l
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k

" arrow keys resize windows
nnoremap <UP>    <C-w>+
nnoremap <DOWN>  <C-w>-
nnoremap <LEFT>  <C-w>>
nnoremap <RIGHT> <C-w><

" Ctrl-P settings
let g:ctrlp_max_height = 20
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("k")':   ['<Tab>'],
    \ }
set wildignore+=*/tmp/*,*/node_modules/*,*/coverage/*,*/vendor/*,*/deps/*,*/source_maps/*
nnoremap <leader>y :tabe<CR>:CtrlP<CR>
nnoremap <leader>t :CtrlP<CR>

" Toggle line number Ctrl-N
nmap <C-N><C-N> :set invnumber<CR>

" Turn highlighting off after search
nmap <C-h> :nohl<CR>

set foldmethod=indent
set foldlevelstart=99


" Random Leader Commands
" Some inspired by r00k: https://github.com/r00k/dotfiles/blob/master/vimrc
nnoremap <leader>W :Wipetabs
nnoremap <leader>a :tabe\|:Ack
nnoremap <leader>g :Git
nnoremap <leader>4 :tabclose<CR>
nnoremap <leader>. :!
nnoremap <leader>; :match ExtraWhitespace /\s\s+$/
nnoremap ; :
nnoremap <leader>Q :NoDoubleQuotes<CR>

" Make ack use ag
" let g:ackprg = 'ag --vimgrep'

" highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" function! g:TogglePrettierOnSave()
"   if (exists("prettierMode"))
"     let prettierMode = "off"
"   else
"     let prettierMode = "on"
"   end
"   if (prettierMode == "on")
"     autocmd BufWritePost *.js,*.jsx call prettier#run(1)
"   else
"     autocmd! BufWritePost *.js,*.jsx call prettier#run(1)
"   endif
" endfunc

" could be <leader>pp or anything else
" nnoremap <leader>pp :call g:TogglePrettierOnSave()<cr>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Add thor to syntax
au BufRead,BufNewFile *.thor set filetype=ruby

" Add hamljs to syntax
autocmd BufNewFile,BufRead,BufFilePost *.*.hamljs set filetype=haml

au BufNewFile,BufRead,BufFilePost *.rabl set filetype=ruby
au BufNewFile,BufRead,BufFilePost *.rb set filetype=ruby


" Set tab to 2 spaces
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
au FileType html setlocal shiftwidth=2 tabstop=2
au FileType javascript setlocal shiftwidth=2 tabstop=2
au FileType coffee setlocal shiftwidth=2 tabstop=2
au FileType cucumber setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2

" Change tabs for go files
autocmd FileType go setlocal noexpandtab
au FileType go setlocal shiftwidth=8 tabstop=8

" running rspec from tmux hotness
let s:rspec_tmux_command = "tmux send -t 0.1 'rspec {spec}' Enter"
let g:rspec_command = "!echo " . s:rspec_tmux_command . " && " . s:rspec_tmux_command
nnoremap <leader>rr :silent call RunNearestSpec()<CR><c-L>
nnoremap <leader>rf :silent call RunCurrentSpecFile()<CR><c-L>
nnoremap <leader>rl :silent call RunLastSpec()<CR><c-L>

" let s:ex_tmux_command = "tmux send -t 0.1 'mix test' Enter"
" let g:ex_command = "!echo " . s:ex_tmux_command
" nmap <silent> <leader>ee :TestNearest<CR>
" nmap <silent> <leader>ef :TestFile<CR>
" nmap <silent> <leader>ea :TestSuite<CR>
" nmap <silent> <leader>el :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

nmap <silent> <leader>ee :! tmux send -t 0.1 'mix test' Enter<CR><c-L>
nmap <silent> <leader>ef :! tmux send -t 0.1 'mix test %:p' Enter<CR><c-L>
nmap <silent> <leader>er :exe "!tmux send -t 0.1 'mix test %:p:" . line(".") . "' Enter"<CR><c-L>

" Populate args list with files in the quickfix window. Obtained from.. http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" Function for swapping splits. Obtained from.. http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mn :call MarkWindowSwap()<CR>
nmap <silent> <leader>ms :call DoWindowSwap()<CR>
""" END SWAPPING SPLITS """

""" SYNTASTIC AND STATUSLINE SETTINGS """

" [buffer number] followed by filename:
" set statusline=[%n]\ %f
" for Syntastic messages:
" set statusline+=\ %#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" show line#:column# on the right hand side
" set statusline+=%=%l:%c

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

let g:syntastic_ruby_checkers = ['rubocop']

""" END SYNTASTIC AND STATUSLINE SETTINGS """

let g:jsx_ext_required = 0
