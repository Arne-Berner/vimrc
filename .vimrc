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
"set hlsearch "Highlights den suchbegriff"
set incsearch "sucht Buchstabe für Buchstabe"'
set showcmd "zeigt die cMD unten links an"


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
inoremap [ []<left>
"nicht in studio inoremap {<CR> {<CR>}<C-o>O<Tab>
inoremap " ""<left>
inoremap ' ''<left>
": oder ; + enter setzt es ans ende
inoremap ;<CR> <C-o>$<right>;<CR>
inoremap ;jj <C-o>$<right>;<Esc>
inoremap ;<C-j> <C-o>$<right>;<down>
inoremap :<CR> <C-o>$<right>:<CR><Tab>
"dinge in klammern und ' p[acken]'"'
vnoremap <buffer> [ x:set paste<CR>i[<C-r>"]<esc>:set nopaste<CR>
vnoremap <buffer> ( x:set paste<CR>i(<C-r>")<esc>:set nopaste<CR>

"ctrl c und v fuer copypaste
inoremap <C-v> <Esc>:set paste<CR>"+p:set nopaste<CR>
vnoremap <C-c> "+y

"switch windows"
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"C# aenderung
inoremap #> =>

"copy marks"
nnoremap <leader>mm <esc>:'a,'by +<CR>
nnoremap <leader>MM <esc>`av`b"+y<esc>
