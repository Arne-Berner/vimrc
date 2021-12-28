"standartstuff"
inoremap jj <Esc>
set number
let mapleader = ","
set tabstop=4 "wie viele leerzeichen sollen angezeigt werden"
set shiftwidth=4 "wie lang ist ein indent"
set softtabstop=4
set expandtab
set autoindent
set syntax
set title "dateiname anzeigen"
set hidden "merkt sich undo history"
set history=50 "behaelt 50 eines"
"sucht alle Gases
set ignorecase
set smartcase
set hlsearch "Highlights den suchbegriff"
set incsearch "sucht Buchstabe für Buchstabe"'
set showcmd "zeigt die cMD unten links an"

"vernuenftige Tab Function"
inoremap <expr><Tab> getline(line(".")) =~ "^<Space>*$" ? '<Tab>' : '<right>'


"spellchecker"
function! English()
    setlocal spell
    setlocal spelllang=en_gb
    inoremap <buffer> <C-[> <C-g>u<Esc>[s1z=`]a<C-g>u
	inoremap <buffer> ue ue
	inoremap <buffer> oe oe
	inoremap <buffer> ae ae
    inoremap <buffer> ' '
endfunction

function! Deutsch()
    setlocal spell
    setlocal spelllang=de
    inoremap <buffer> <C-[> <C-g>u<Esc>[s1z=`]a<C-g>u
	"Umlaute"
	inoremap <buffer> ue<Tab> ü
	inoremap <buffer> oe<Tab> ö
	inoremap <buffer> ae<Tab> ä
	endfunction

command! En call English()
command! De call Deutsch()

"Suchen und Ersetzen
nnoremap <C-f> :%s/

"mit ctrl hjkl sich in insert bewegen"
inoremap <C-j> <down>
inoremap <C-h> <left>
inoremap <C-k> <up>
inoremap <C-l> <right>

"neue Zeile und Klammernspass"
inoremap <A-o> <C-o>o
inoremap ( ()<left>
inoremap (<CR> ()<C-o>$<CR>
inoremap [ []<left>
inoremap [<CR> []<C-o>$<CR>
inoremap {<CR> {<CR>}<C-o>O<Tab>
inoremap " ""<left>
inoremap ' ''<left>
": oder ; + enter setzt es ans ende
inoremap ;<CR> <C-o>$;<CR>
inoremap :<CR> <C-o>$:<CR><Tab>
"dinge in klammern und ' p[acken]'"'
vnoremap <buffer> [ x:set paste<CR>i[<C-r>"]<esc>:set nopaste<CR>
vnoremap <buffer> ( x:set paste<CR>i(<C-r>")<esc>:set nopaste<CR>

"ctrl c und v fuer copypaste
inoremap <C-v> <Esc>:set paste<CR>"+p:set nopaste<CR>
vnoremap <C-c> "+y

"execute python"
autocmd FileType python map <buffer> <F9> :w<CR>:execute '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:execute '!python3' shellescape(@%, 1)<CR>

"tex commands"
augroup texcmds
    autocmd!
    autocmd FileType tex inoremap <buffer> ,en <esc>yyPj:.s/begin/end/g<CR>O
    autocmd Filetype tex inoremap <buffer> ,be \begin{}<esc>i
    autocmd Filetype tex inoremap <buffer> ,eq \begin{equation}<CR>\end{equation}<esc><<O
    autocmd Filetype tex inoremap <buffer> ,al \begin{align}<CR>\end{align}<esc><<O
    autocmd Filetype tex inoremap <buffer> ,fla \begin{flalign}<CR>\end{flalign}<esc><<O
    autocmd bufnewfile *.tex source ~/.vim/tex_header.
    autocmd bufnewfile *.tex exe "1," . 11 . "g/DATE/s//" .strftime("%c")
augroup END

augroup ccmds
    autocmd!
    autocmd Filetype c map <buffer> <F9> :w<CR> :!clear; gcc % -o ./%<<CR> :!./%<<CR>
    autocmd Filetype c imap <buffer> <F9> :w<CR> :!clear; gcc % -o ./%<<CR> :!./%<<CR>
    autocmd bufnewfile *.c source ~/.vim/c_header.
    autocmd bufnewfile *.c exe "1," . 10 . "g/Dateiname: /s//Dateiname: " .expand("%")
    autocmd bufnewfile *.c exe "1," . 11 . "g/Datum:/s/Datum:/Datum: " .strftime("%c")
augroup END 

"switch windows"
nnoremap <C-J> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"copy marks"
nnoremap <leader>mm <esc>:'a,'by +<CR>
nnoremap <leader>MM <esc>`av`b"+y<esc>

"Jupyter marks"
"sucht die oberen ##;springt in den block; yanked bis ## ins reg +; geht zum letzten edit"
inoremap <leader>jm <esc>?##<CR>:.+1,/##/-1y +<CR>`.a
nnoremap <leader>jm ?##<CR>:.+1,/##/-1y +<CR>

"vimrc sourcen und im split aufrufen"
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

"MathJaxMode"
inoremap <leader>ma <esc>:Math<CR>a
nnoremap <leader>ma :Math<CR>a
function! SkipAhead()
    normal l"zy$
    if @z =~ ".*{.*"
        normal f{l
        startinsert
    elseif @z =~ "}.*"
        normal f}l
        startinsert
    elseif @z =~ ".*)..+"
        normal f)l
        startinsert
    elseif @z =~ ".*}$"
        startinsert!
    elseif @z =~ ".*\right)"
        startinsert!
    elseif @z =~ ".*)$"
        startinsert!
    else
        echo "empty"
        startinsert!
    endif
endfunction
command! Skip call SkipAhead()



let math = 0
"TODO: Dollarzeichen und das Matheabschnitt ding einfuegen" 
function! MathJaxMode() 
    if (g:math==0) 
        let g:math=1
        inoremap <buffer> int<Space> \int_{}^{}<esc>3hi
        inoremap <buffer> sum<Space> \sum_{}^{}<esc>3hi
        inoremap <buffer> sqrt<Space> \sqrt[]{}<esc>i
        inoremap <buffer> <Tab> <esc>:Skip<CR>
        "if Zeile leer mache tab else if { dann mach das, else if } springe zum Ende davon else if ) springe dorthin else springe zum Ende)"
        inoremap <buffer> / \frac{}{}<esc>2hi
        inoremap <buffer> ho ^{}<esc>i
        inoremap <buffer> ti _{}<esc>i
        inoremap <buffer> qu ^2
        inoremap <buffer> cu ^3
        inoremap <buffer> <CR> <esc>A\\<CR>
        inoremap <buffer> (<Space> \left(\right)<esc>6hi
        inoremap <buffer> [<Space> \left[\right]<esc>6hi
        inoremap <buffer> \[ \[\]<left><left>
        inoremap <buffer> \( \(\)<left><left>
        inoremap <buffer> ' '
        inoremap <buffer> lim<Space> \lim \limits_{x \to}<esc>i
        vnoremap <buffer> [ x:set paste<CR>i\left[<C-r>"\right]<esc>:set nopaste<CR>
        vnoremap <buffer> ( x:set paste<CR>i\left(<C-r>"\right)<esc>:set nopaste<CR>
		iabbrev <buffer> orth \perp
        iabbrev <buffer> und \wedge
        iabbrev <buffer> oder \vee
        iabbrev <buffer> * \cdot
        iabbrev <buffer> tan \tan
        iabbrev <buffer> sin \sin
        iabbrev <buffer> cos \cos
        iabbrev <buffer> sinh \sinh
        iabbrev <buffer> cosh \cosh
        iabbrev <buffer> tanh \tanh
        iabbrev <buffer> vec \vec
        iabbrev <buffer> vert \vert
        iabbrev <buffer> neq \neq
        iabbrev <buffer> lt \lt
        iabbrev <buffer> le \le
        iabbrev <buffer> gt \gt
        iabbrev <buffer> ge \ge
        iabbrev <buffer> inf \infty
        iabbrev <buffer> cross \times
        iabbrev <buffer> pm \pm
        iabbrev <buffer> mp \mp
        iabbrev <buffer> alp \alpha
        iabbrev <buffer> bet \beta
        iabbrev <buffer> gam \gamma
        iabbrev <buffer> del \Delta
        iabbrev <buffer> the \theta
        iabbrev <buffer> lam \lambda
        iabbrev <buffer> mu \mu
        iabbrev <buffer> pi \pi
        iabbrev <buffer> sig \sigma
        iabbrev <buffer> phi \varphi
        iabbrev <buffer> Phi \Phi
        iabbrev <buffer> psi \psi
        iabbrev <buffer> ome \omega
        iabbrev <buffer> right \Rightarrow
    else
        let g:math=0
        iunmap <buffer> int<Space>
        iunmap <buffer> sum<Space>
        iunmap <buffer> sqrt<Space>
        inoremap <expr><Tab> getline(line(".")) =~ "^<Space>*$" ? '<Tab>' : '<right>'
        inoremap <buffer> / /
        inoremap <buffer> ho ho
        inoremap <buffer> ti ti
        inoremap <buffer> qu qu
        inoremap <buffer> cu cu
        inoremap <buffer> <CR> <CR>
        inoremap <buffer> (<Space> (<Space>
        inoremap <buffer> [<Space> [<Space>
        inoremap <buffer> \( \(
        inoremap <buffer> \[ \[
        inoremap <buffer> ' ''<left>
        inoremap <buffer> lim<Space> lim<Space>
        vnoremap <buffer> [ [
        vnoremap <buffer> ( (
        iunabbrev <buffer> orth 
        iunabbrev <buffer> und 
        iunabbrev <buffer> oder 
        iunabbrev <buffer> * 
        iunabbrev <buffer> tan 
        iunabbrev <buffer> sin
        iunabbrev <buffer> cos
        iunabbrev <buffer> sinh
        iunabbrev <buffer> cosh
        iunabbrev <buffer> tanh
        iunabbrev <buffer> vec
        iunabbrev <buffer> vert
        iunabbrev <buffer> neq
        iunabbrev <buffer> lt 
        iunabbrev <buffer> le
        iunabbrev <buffer> gt 
        iunabbrev <buffer> ge 
        iunabbrev <buffer> inf 
        iunabbrev <buffer> cross 
        iunabbrev <buffer> pm 
        iunabbrev <buffer> mp
        iunabbrev <buffer> alp 
        iunabbrev <buffer> bet
        iunabbrev <buffer> gam
        iunabbrev <buffer> del 
        iunabbrev <buffer> the
        iunabbrev <buffer> lam 
        iunabbrev <buffer> mu 
        iunabbrev <buffer> pi
        iunabbrev <buffer> sig 
        iunabbrev <buffer> phi
        iunabbrev <buffer> Phi 
        iunabbrev <buffer> psi
        iunabbrev <buffer> ome 
        iunabbrev <buffer> right 
    endif
endfunction
nnoremap <silent> <Leader>m :call MathJaxMode()<CR>
command! Math call MathJaxMode()

"vim-plug" 
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_view = 'latexrun'
let g:vimtex_quickfix_mode=0

call plug#end()
