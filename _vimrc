"
" *** NOTE ***
"
" Sometimes settings mysteriously don't work, for example, after :set nobackup
" Settings still set to 'backup'.
" To figure out where this gets set
" :verbose set backup?
"
" Help came from:
" * Damian Conway, "More Instantly Better Vim" - OSCON 2013
" * Steve Losh - "Learn Vimscript the Hard Way"
" * Eric Andreychek's .vimrc
"
" David Bradford's .vimrc VERSION=3.93
"

" behave mswin " I don't know exactly what this does but I'm leaving it here
" to remind myself in case not having it screws something up

set statusline=%f%m\ %=Current:\ %-4l\ Total:\ %-4L

let loaded_matchparen = 1 " disable matching parens

cnoremap jk <c-c>
cnoremap <esc> <nop>
inoremap jk <esc>
inoremap <esc> <nop>
vnoremap jk <esc>
"vnoremap <esc> <nop> " this breaks shift tab to go back an indent level
noremap : ;
noremap ; :
nmap <space> <c-space>
nnoremap <silent> <space> ma:s/^\[ \] /[C] /e<CR>:s/^\[X\] /[ ] /e<CR>:s/^\[C\] /[X] /e<CR>:s/^\([^[]\)/[ ] \1/e<CR>`a
vnoremap <silent> <space> ma:s/^\[ \] /[C] /e<CR>:'<,'>s/^\[X\] /[ ] /e<CR>:'<,'>s/^\[C\] /[X] /e<CR>:'<,'>s/^\([^[]\)/[ ] \1/e<CR>`a

map z @az

" change single quotes to double, but there should be a better way, like a
" toggle
noremap <F6> maF'r"f'r"`a

" copy the current line and comment it out so we can save it while changing
" the copy
noremap <F7> yypkI#<ESC>j

" map tab to indent one level
nnoremap <tab> I<tab><esc>
nnoremap <s-tab> ^i<bs><esc>

vnoremap <tab> >gv
vnoremap <s-tab> <gv

" this would be cool but not working for some reason
iabbrev #!p #!/usr/bin/perl -w<CR><BS><CR>use strict;<CR><ESC>:filetype detect<CR>i

set autoindent
set ut=2000
set backspace=2
set bg=light
set comments=b:#,:%,fb:-,n:>,n:)
set complete-=i
set textwidth=78
set keywordprg=:help
set laststatus=2
set list
set listchars=tab:>-,trail:.
set backup
set writebackup
set nocompatible
set nohlsearch
set swapfile
set nonumber
set ruler
set scrolloff=3
set shiftwidth=4
set noshowmatch
set ignorecase
set smartcase
set smartindent
set softtabstop=4
set t_vb=
set title
set tabstop=4
set novisualbell
set whichwrap=<,>,h,l
set wildmenu
set wildmode=list:longest,full
set wrapmargin=3
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

set titleold=

set autowrite       "Save buffer automatically when changing files
set autoread        "Always reload buffer when external changes detected

set backspace=indent,eol,start      "BS past autoindents, line boundaries,
                                    "     and even the start of insertion

set fileformats=unix,mac,dos        "Handle Mac and DOS line-endings
                                    "but prefer Unix endings


set wildmode=list:longest,full      "Show list of completions
                                    "  and complete as much as possible,
                                    "  then iterate full completions

set noshowmode                      "Suppress mode change messages

set updatecount=10                  "Save buffer every 10 chars typed

" Keycodes and maps timeout in 3/10 sec...
set timeout timeoutlen=1000 ttimeoutlen=1000

set ruler                           "Show cursor location info on status line

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 50 files
"           | |   +--Remember up to 10000 lines in each register
"           | |   |      +--Remember up to 1MB in each register
"           | |   |      |     +--Remember last 1000 search patterns
"           | |   |      |     |     +---Remember last 1000 commands
"           | |   |      |     |     |
"           v v   v      v     v     v
set viminfo=h,'50,<10000,s1000,/1000,:1000

"====[ Use persistent undo ]=================

if has('persistent_undo')
    let undo_dir = $HOME.'/tmp/.VIM_UNDO_FILES'
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    if !isdirectory(undo_dir)
        silent execute '!mkdir "'.undo_dir.'"'
    endif
    set undolevels=5000
    set undofile
endif

let required_dir = $HOME.'/temp'
if !isdirectory(required_dir)
    silent execute '!mkdir "'.required_dir.'"'
endif
set backupdir=$HOME/temp//
set directory=$HOME/temp//

" I have no idea what makes vim search through every Perl file in existence
" due to the following line, but it SUCKS and I haven't yet found functionality
" that doesn't work because of this not being here.
"filetype plugin on
syntax on

" Windows-specific commands can go here
"if has("win32") || has("win16")
"    syntax on
"else
"    syntax off
"endif

autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

let mapleader = ';'
"vim_please_jump_to_this_location
nnoremap <silent> <leader>o :set noautoindent<CR>:set nosmartindent<CR>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nnoremap <silent> Q :q!<CR>
nnoremap <silent> <leader>x :!x r<CR>
nnoremap <silent> <leader>h :call <SID>ListMappings()<CR>
set guicursor=a:block-Cursor
nmap ,c 0f]0 j,c

" allow toggling between local and default mode
function TabToggle()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
endfunction

au GUIEnter * hi Cursor guibg=white
au InsertLeave * set guicursor=a:block-Cursor
au InsertEnter * set guicursor=a:hor20-Cursor
" set guifont=Lucida_Console:h11:cDEFAULT

" note that in order for MYVIMRC to be set correctly, it MATTERS where you
" have put your vimrc file. Note in the following "system" vs "user":
" :version
" VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Aug 10 2013 14:38:33)
" [...]
"  system vimrc file: "$VIM\vimrc"
"    user vimrc file: "$HOME\_vimrc"
nnoremap <silent> <leader>v :vsplit $MYVIMRC<cr>

let g:vimwiki_list = [{'path': '~/vimwiki/', 'path_html': '~/public_html/'},
    \ {'path': 'c:\dropbox\other\wiki' }]

"colorscheme dmb

" Rating: A-
"colorscheme torte
"colorscheme elflord
"colorscheme darkblue " very good
colorscheme spiderhawk " very good... maybe just annoyed about no ahk
"colorscheme adrian " good, plus default color is green
"colorscheme baycomb " maybe best so far, blues may be too similar in ahk
"colorscheme greens " pretty damn good but the greys have to go
"colorscheme wintersday " great but don't like in perl
"colorscheme synic " another good one
"colorscheme dante
"colorscheme xterm16 " I like it a lot

" Rating: A? - None of these are dark bg, yet not light. Not sure if useful
"colorscheme Blue2
"colorscheme astronaut
"colorscheme darkblue
"colorscheme adaryn
"colorscheme blue

" Rating: B
"colorscheme koehler " nice and bright, normal is white on black - boring
"colorscheme murphy
"colorscheme pablo
"colorscheme ron
"colorscheme desert
"colorscheme understated " maybe too chill
"colorscheme spectro "maybe too dim
"colorscheme vividchalk " perl colors are orange / yellow too close
"colorscheme distinguished " maybe too much bold?
"colorscheme blugrine " maybe not enough difference between colors
"colorscheme darkzen " maybe not enough difference between colors in perl
"colorscheme desert256 " starting to not dig bolds too much either
"colorscheme Dim " dim but bold
"colorscheme fruity " meh
"colorscheme vibrantink " pretty good, purple too dark

" Rating: C
"colorscheme 3dglasses " too blue
"colorscheme evening
"colorscheme slate

" Rating: F
"colorscheme 256-jungle " bright white bg wtf
"colorscheme bluez " bright white bg wtf
"colorscheme default
"colorscheme delek
"colorscheme morning
"colorscheme peachpuff
"colorscheme shine
"colorscheme zellner


function! FindeyFind ()
    /[v]im_please_jump_to_this_location
endfunction

autocmd BufRead  *   :silent! call FindeyFind()

" Mmmmm... tab completetion
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

" Right now I want to use tab for indent, but this is still a great idea
"inoremap <S-tab> <c-r>=InsertTabWrapper ("backward")<cr>
"inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>

" BEGIN These are all just playing around vim functions:
function! DisplayName(name)
    echom "Hello! My name is:"
    echom a:name
endfunction

function! Varg(...)
  " if called via :call Varg("a","b")
  " 2 (# of args)
  echom a:0
  " a (first arg)
  echom a:1
  " ['a', 'b'] (list of all args)
  echo a:000
endfunction
" END These are all just playing around vim functions:

" au GUIEnter * simalt ~x

runtime plugin/dragvisuals.vim

vmap  <expr>  <C-LEFT>   DVB_Drag('left')
vmap  <expr>  <C-RIGHT>  DVB_Drag('right')
vmap  <expr>  <C-DOWN>   DVB_Drag('down')
vmap  <expr>  <C-UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 0

" Damian Conway's vimrc starts here (not really as I have moved some of it
" above this line to keep it organized my way --dbradford)

"====[ Ensure autodoc'd plugins are supported ]===========

runtime plugin/autodoc.vim

"====[ Work out what kind of file this is ]========

" I have no idea what makes vim search through every Perl file in existence
" due to the following line, but it SUCKS and I haven't yet found functionality
" that doesn't work because of this not being here.
"filetype plugin on

" .t bilong perl!!!

autocmd BufNewFile,BufRead  .vimrc setfiletype vim
autocmd BufNewFile,BufRead  *.t    setfiletype perl
autocmd BufNewFile,BufRead  *.pl   setfiletype perl
autocmd BufNewFile,BufRead  *.txt  setfiletype text

"=====[ Enable Nmap command for documented mappings ]================

runtime plugin/documap.vim

"=====[ Edit files in local bin directory ]========

"screws up my run macro
"Nnoremap ;b  [Edit ~/bin/...]  :next ~/bin/

"====[ Goto last location in non-empty files ]=======

"autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
"                   \|     exe "normal! g`\""
"                   \|  endif


"====[ I'm sick of typing :%s/.../.../g ]=======

Nnoremap s  [Shortcut for :s///g]  :%s//g<LEFT><LEFT>
vnoremap s                         :s//g<LEFT><LEFT>

"====[ Handle encoding issues ]============

set encoding=latin1

Nnoremap <silent> ,u [Toggle UTF8]  :call ToggleUTF8()<CR>

function! ToggleUTF8 ()
    if &fileencoding =~ 'utf-\?8'
        set fileencoding=latin1
    else
        set fileencoding=utf8
    endif
    echo '[' . &fileencoding . ']'
endfunction

"====[ Set background hint (if possible) ]=============

if $VIMBACKGROUND != ""
    exec 'set background=' . $VIMBACKGROUND
else
    set background=dark
endif

"======[ Magically build interim directories if necessary ]===================

function! AskQuit (msg, options, quit_option)
    if confirm(a:msg, a:options) == a:quit_option
        exit
    endif
endfunction

function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
             \       "&Create it\nor &Quit?", 2)

        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
        endtry
    endif
endfunction

augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

" TODO figure out what this does
inoremap # X<C-H>#|                         "And no magic outdent for comments
nnoremap <silent> >> :call ShiftLine()<CR>| "And no shift magic on comments

function! ShiftLine()
    set nosmartindent
    normal! >>
    set smartindent
endfunction

"====[ I hate modelines ]===================

set modelines=0

"=====[ Toggle syntax highlighting ]==============================

Nnoremap <silent> ;y [Toggle syntax highlighting]
                 \ : if exists("syntax_on") <BAR>
                 \    syntax off <BAR>
                 \ else <BAR>
                 \    syntax enable <BAR>
                 \ endif<CR>

" Re-factored .vimrc to this point so far.

" Forward/back one file...
nnoremap aj :next<CR>0
nnoremap ak :rew<CR>0

" Indent/outdent current block...
nmap %% $>i}``
nmap $$ $<i}``

" Format file with perltidy...
Nnoremap ;p [Perltidy the current buffer]  1G!Gperltidy<CR>

" Show what changes perltidy would make...
Nnoremap ;pp [Perltidy to the current buffer (as a diff)]  :call Perltidy_diff()<CR>

function! Perltidy_diff ()
    " Work out what the tidied file will be called...
    let perl_file = expand( '%' )
    let tidy_file = perl_file . '.tdy'

    call system( 'perltidy -nst ' . perl_file . ' -o ' . tidy_file )

    " Add the diff to the right of the current window...
    set splitright
    exe ":vertical diffsplit " . tidy_file

    " Clean up the tidied version...
    call delete(tidy_file)
endfunction

" Run perldoc with smarter completion...
Nnoremap <expr> ?? [Go to documentation] CallPerldoc()
" set keywordprg=pd

function! CallPerldoc ()
    " When editing Vim files, revert to :help...
    if &filetype == 'vim' || &buftype == 'help'
        return ":help "

    " Otherwise use Perldoc...
    else
        let target = matchstr(expand('<cfile>'), '\w\+\(::\w\+\)*')
        set wildmode=list:full
        return ":Perldoc "
    endif
endfunction

"Complete perldoc requests with names of installed Perl modules
command! -nargs=? -complete=customlist,CompletePerlModuleNames Perldoc  call Perldoc_impl(<q-args>)

"Undo the special wildmoding and then execute the requested perdoc lookup...
function! Perldoc_impl (args)
    set wildmode=list:longest,full
    if empty(a:args)
        exec '!pd %'
    else
        exec '!pd ' . a:args
    endif
endfunction

" Handle Perl include files better...

set include=^\\s*use\\s\\+\\zs\\k\\+\\ze
set includeexpr=substitute(v:fname,'::','/','g')
set suffixesadd=.pm
execute 'set path+=' . substitute($PERL5LIB, ':', ',', 'g')

" Insert common Perl code structures...

iab udd use Data::Dumper 'Dumper';<CR>warn Dumper([]);jk
iab uds use Data::Show;<CR>show
iab ubm use Benchmark qw( cmpthese );<CR><CR>cmpthese -10, {<CR>};<ESC>O
iab usc use Smart::Comments;<CR>###
iab uts use Test::Simple 'no_plan';
iab utm use Test::More 'no_plan';
iab dbs $DB::single = 1;<ESC>


"=====[ Emphasize typical mistakes in Vim and Perl files ]=========

" Add a new high-visibility highlight combination...
highlight WHITE_ON_RED    ctermfg=white  ctermbg=red

" Emphasize undereferenced references...
call matchadd('WHITE_ON_RED', '_ref[ ]*[[{(]\|_ref[ ]*-[^>]')

" Emphasize typical mistakes a Perl hacker makes in .vim files...
let g:VimMistakes = '\_^\s*\zs\%(my\s\+\)\?\%(\k:\)\?\k\+\%(\[.\{-}\]\)\?\s*[+-.]\?==\@!\|\_^\s*elsif\|;\s*\_$\|\_^\s*#.*'
let g:VimMistakesID = 668
augroup VimMistakes
    autocmd!
    autocmd BufEnter  *.vim,*.vimrc   call VimMistakes_AddMatch()
    autocmd BufLeave  *.vim,*.vimrc   call VimMistakes_ClearMatch()
augroup END

function! VimMistakes_AddMatch ()
    try | call matchadd('WHITE_ON_RED',g:VimMistakes,10,g:VimMistakesID) | catch | endtry
endfunction

function! VimMistakes_ClearMatch ()
    try | call matchdelete(g:VimMistakesID) | catch | endtry
endfunction


"=====[ Enable quickfix on Perl programs ]=======================

Nnoremap ;m [Run :make and any tests on a Perl file]  :make<CR><CR><CR>:call PerlMake_Cleanup()<CR>

function! PerlMake_Cleanup ()
    " If there are errors, show the first of them...
    if !empty(getqflist())
        cc

    " Otherwise, run the test suite as well...
    else
        call RunPerlTests()
    endif
endfunction

set makeprg=polyperl\ -vc\ %\ $*

augroup PerlMake
    autocmd!
    autocmd BufReadPost quickfix  setlocal number
                             \ |  setlocal nowrap
                             \ |  setlocal modifiable
                             \ |  silent! %s/^[^|]*\//.../
                             \ |  setlocal nomodifiable
augroup END


" Make it easy to navigate errors (and vimgreps)...

"nmap <silent> <RIGHT>         :cnext<CR>
"nmap <silent> <RIGHT><RIGHT>  :cnf<CR><C-G>
"nmap <silent> <LEFT>          :cprev<CR>
"nmap <silent> <LEFT><LEFT>    :cpf<CR><C-G>


"=====[ Run a Perl module's test suite ]=========================

let g:PerlTests_program       = 'perltests'   " ...What to call
let g:PerlTests_search_height = 5             " ...How far up to search
let g:PerlTests_test_dir      = '/t'          " ...Where to look for tests

augroup Perl_Tests
    autocmd!
    autocmd BufEnter *.p[lm]  Nnoremap <buffer> ;t [Run local test suite] :call RunPerlTests()<CR>
    autocmd BufEnter *.t      Nnoremap <buffer> ;t [Run local test suite] :call RunPerlTests()<CR>
augroup END

function! RunPerlTests ()
    " Start in the current directory...
    let dir = expand('%:h')

    " Walk up through parent directories, looking for a test directory...
    for n in range(g:PerlTests_search_height)
        " When found...
        if isdirectory(dir . g:PerlTests_test_dir)
            " Go there...
            silent exec 'cd ' . dir

            " Run the tests...
            exec ':!' . g:PerlTests_program

            " Return to the previous directory...
            silent cd -
            return
        endif

        " Otherwise, keep looking up the directory tree...
        let dir = dir . '/..'
    endfor

    " If not found, report the failure...
    echohl WarningMsg
    echomsg "Couldn't find a suitable" g:PerlTests_test_dir '(tried' g:PerlTests_search_height 'levels up)'
    echohl None
endfunction

" =====[ Smart completion via <TAB> and <S-TAB> ]=============

runtime plugin/smartcom.vim

" Add extra completions (mainly for Perl programming)...

let ANYTHING = ""
let NOTHING  = ""
let EOL      = '\s*$'

                " Left     Right      Insert                             Reset cursor
                " =====    =====      ===============================    ============
call SmartcomAdd( '<<',    ANYTHING,  '>>',                              {'restore':1} )
call SmartcomAdd( '<<',    '>>',      "\<CR>\<ESC>O\<TAB>"                             )
call SmartcomAdd( 'Â«',     ANYTHING,  'Â»',                               {'restore':1} )
call SmartcomAdd( 'Â«',     'Â»',       "\<CR>\<ESC>O\<TAB>"                             )
call SmartcomAdd( '{{',    ANYTHING,  '}}',                              {'restore':1} )
call SmartcomAdd( '{{',    '}}',      NOTHING,                                         )
call SmartcomAdd( 'qr{',   ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'qr{',   '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>"                 )
call SmartcomAdd( 'm{',    ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'm{',    '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( 's{',    ANYTHING,  '}{}xms',                          {'restore':1} )
call SmartcomAdd( 's{',    '}{}xms',  "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( '\*\*',  ANYTHING,  '**',                              {'restore':1} )
call SmartcomAdd( '\*\*',  '\*\*',    NOTHING,                                         )

" In the middle of a keyword: delete the rest of the keyword before completing...
                " Left     Right                    Insert
                " =====    =====                    =======================
"call SmartcomAdd( '\k',    '\k\+\%(\k\|\n\)\@!',    "\<C-O>cw\<C-X>\<C-N>",           )
"call SmartcomAdd( '\k',    '\k\+\_$',               "\<C-O>cw\<C-X>\<C-N>",           )

                " Left         Right   Insert                                  Where
                " ==========   =====   =============================           ===================
" Vim keywords...
call SmartcomAdd( '^\s*func',  EOL,    "tion!\<CR>endfunction\<UP> ",          {'filetype':'vim'}  )
call SmartcomAdd( '^\s*for',   EOL,    " ___ in ___\n___\n\<C-D>endfor\n___",  {'filetype':'vim'} )
call SmartcomAdd( '^\s*if',    EOL,    " ___ \n___\n\<C-D>endif\n___",         {'filetype':'vim'} )
call SmartcomAdd( '^\s*while', EOL,    " ___ \n___\n\<C-D>endwhile\n___",      {'filetype':'vim'} )
call SmartcomAdd( '^\s*try',   EOL,    "\n\t___\n\<C-D>catch\n\t___\n\<C-D>endtry\n___", {'filetype':'vim'} )

" Perl keywords...
call SmartcomAdd( '^\s*for',   EOL,    " my $___ (___) {\n___\n}\n___",        {'filetype':'perl'} )
call SmartcomAdd( '^\s*if',    EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*while', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*given', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*when',  EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )

" Complete Perl module loads with the names of Perl modules...
call SmartcomAddAction( '^\s*use\s\+\k\+', "",
\                       'set complete=k~/.vim/perlmodules|set iskeyword+=:'
\)


"=====[ General programming support ]===================================

" Insert various shebang lines...
iab hbc #! /bin/csh
iab hbs #! /bin/sh
iab hbp #! /usr/bin/env polyperl<CR>use 5.014; use warnings; use autodie;<CR>
iab hbr #! /Users/damian/bin/rakudo*<CR>use v6;


" Execute current file polymorphically...
"Nnoremap ,, [Execute current file] :w<CR>:!clear;echo;echo;run %<CR>
"Nnoremap ,,, [Debug current file]  :w<CR>:!clear;echo;echo;run -d %<CR>


"=====[ Show help files in a new tab, plus add a shortcut for helpg ]==============

"Only apply to .txt files...
augroup HelpInTabs
    autocmd!
    autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

"Only apply to help files...
function! HelpInNewTab ()
    if &buftype == 'help'
        "Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction

"Simulate a regular cmap, but only if the expansion starts at column 1...
function! CommandExpandAtCol1 (from, to)
    if strlen(getcmdline()) || getcmdtype() != ':'
        return a:from
    else
        return a:to
    endif
endfunction

"Expand hh -> helpg...
cmap <expr> hh CommandExpandAtCol1('hh','helpg ')

"=====[ Convert file to different tabspacings ]=====================

function! InferTabspacing ()
    return min(filter(map(getline(1,'$'),'strlen(matchstr(v:val, ''^\s\+''))'),'v:val != 0'))
endfunction

function! NewTabSpacing (newtabsize)
    " Determine apparent tabspacing, if necessary...
    if &tabstop == 4
        let &tabstop = InferTabspacing()
    endif

    " Preserve expansion, if expanding...
    let was_expanded = &expandtab

    " But convert to tabs initially...
    normal TT

    " Change the tabsizing...
    execute "set ts="  . a:newtabsize
    execute "set sw="  . a:newtabsize

    " Update the formatting commands to mirror than new tabspacing...
    execute "map          F !Gformat -T" . a:newtabsize . " -"
    execute "map <silent> f !Gformat -T" . a:newtabsize . "<CR>"

    " Re-expand, if appropriate...
    if was_expanded
        normal TS
    endif
endfunction

"=====[ Tab handling ]======================================

set shiftround     "Always indent/outdent to nearest tabstop
set smarttab       "Use shiftwidths at left margin, tabstops everywhere else


" Make the completion popup look menu-ish on a Mac...
highlight  Pmenu        ctermbg=white   ctermfg=black
highlight  PmenuSel     ctermbg=blue    ctermfg=white   cterm=bold
highlight  PmenuSbar    ctermbg=grey    ctermfg=grey
highlight  PmenuThumb   ctermbg=blue    ctermfg=blue


"=====[ Extra completions for VimPoint files ]==========================

autocmd BufNewFile,BufRead  *.vpt   :call AddVimPointKeywords()

function! AddVimPointKeywords ()
    call SmartcomAddAction(
    \   '^=\k*', "", 'set complete=k~/.vim/VimPointKeywords|set iskeyword+=='
    \)
endfunction

"=====[ Add or subtract comments ]===============================

" Work out what the comment character is, by filetype...
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : ''
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             autohotkey                        let b:cmt = exists('b:cmt') ? b:cmt : ';'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'

au BufNewFile *.pl 0r ~/.perl.skel | let IndentStyle = "perl"

" Work out whether the line has a comment then reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

" Toggle comments down an entire visual selection of lines...
function! ToggleBlock () range
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Start at the first line...
    let linenum = a:firstline

    " Get all the lines, and decide their comment state by examining the first...
    let currline = getline(a:firstline, a:lastline)
    if currline[0] =~ '^' . comment_char
        " If the first line is commented, decomment all...
        for line in currline
            let repline = substitute(line, '^' . comment_char, "", "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    else
        " Otherwise, encomment all...
        for line in currline
            let repline = substitute(line, '^\('. comment_char . '\)\?', comment_char, "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    endif
endfunction

" Set up the relevant mappings
Nnoremap <silent> ;a [Toggle display tabs]  :set invlist<CR>
Nnoremap <silent> ;b [Execute current file]  :!chmod 700 %;./%<CR>
Nnoremap <silent> ;c [Compile current Perl program]  :!perl -c %<CR>
Nnoremap <silent> ;d [Double underline]  mzYp:s/./=/g<CR>`z
Nnoremap <silent> ;r [Begin paste to current location]  :r!cat<CR>
Nnoremap <silent> ;f [Find permanent mark]  :silent! call FindeyFind()<cr>
Nnoremap <silent> ;g [Toggle use tabs]  mz:execute TabToggle()<CR>`z
Nnoremap <silent> ;s [Source .vimrc]  :source $MYVIMRC<CR>
Nnoremap <silent> ;w [Write file]  :w<CR>
Nnoremap <silent> ;u [Underline]  mzYp:s/./-/g<CR>`z
Nnoremap <silent> ;o [Fix module name]  :s!/!::!g<CR>:s!\.pm\>!!g<CR>
Nnoremap <silent> ;i [Tabs to spaces & remove trailing whitespace]  mz:set expandtab<CR>:retab<CR>:%s/\s\+$//<CR>`z

Nnoremap <silent> #  [Toggle Comment]  :call ToggleComment()<CR>j0
vnoremap <silent> # :call ToggleBlock()<CR>

"======[ Order-preserving uniqueness ]=========================

" Normalize the whitespace in a string...
function! TrimWS (str)
    " Remove whitespace fore and aft...
    let trimmed = substitute(a:str, '^\s\+\|\s\+$', '', 'g')

    " Then condense internal whitespaces...
    return substitute(trimmed, '\s\+', ' ', 'g')
endfunction

" Reduce a range of lines to only the unique ones, preserving order...
function! Uniq (...) range
    " Ignore whitespace differences, if asked to...
    let ignore_ws_diffs = len(a:000)

    " Nothing unique seen yet...
    let seen = {}
    let uniq_lines = []

    " Walk through the lines, remembering only the hitherto unseen ones...
    for line in getline(a:firstline, a:lastline)
        let normalized_line = '>' . (ignore_ws_diffs ? TrimWS(line) : line)
        if !get(seen,normalized_line)
            call add(uniq_lines, line)
            let seen[normalized_line] = 1
        endif
    endfor

    " Replace the range of original lines with just the unique lines...
    exec a:firstline . ',' . a:lastline . 'delete'
    call append(a:firstline-1, uniq_lines)
endfunction

" Only in visual mode...
vmap  u :call Uniq()<CR>
vmap  U :call Uniq('ignore whitespace')<CR>


"====[ Make normalized search use NFKC ]=======

runtime plugin/normalized_search.vim
NormalizedSearchUsing ~/bin/NFKC



"====[ Toggle between lists and bulleted lists ]======================

Nnoremap <silent> ;l [Toggle list format (bullets <-> commas)]  vip!list2bullets<CR>
vmap <silent> ;l !list2bullets<CR>


"====[ Make Gundo visualizer more usable ]============================

" Shut visualizer when a state is selected...
let g:gundo_close_on_revert = 1

" Use arrow keys to navigate...
let g:gundo_map_move_older  =  "\<C-DOWN>"
let g:gundo_map_move_newer  =  "\<C-UP>"

" No help required...
let g:gundo_help = 0

" Change the layout...
let g:gundo_right = 1

" Access via a simple mapping...
"Nmap ;u [Show the undo tree]  :GundoToggle<CR>


"====[ Regenerate help tags when directly editing a help file ]=================

augroup HelpTags
    au!
    autocmd BufWritePost ~/.vim/doc/*   :helptags ~/.vim/doc
augroup END

function! VimwikiLinkHandler(link) "{{{ Use Vim to open links with the
    " 'vlocal:' or 'vfile:' schemes.  E.g.:
    "   1) [[vfile:///~/Code/PythonProject/abc123.py]], and
    "   2) [[vlocal:./|Wiki Home]]
    let link = a:link
    if link =~ "vlocal:" || link =~ "vfile:"
"      let link = link[1:]
      let link = link
    else
      return 0
    endif
    let [idx, scheme, path, subdir, lnk, ext, url] =
         \ vimwiki#base#resolve_scheme(link, 0)
    if g:vimwiki_debug
      echom 'LinkHandler: idx='.idx.', scheme=[v]'.scheme.', path='.path.
           \ ', subdir='.subdir.', lnk='.lnk.', ext='.ext.', url='.url
    endif
    if url == ''
      echom 'Vimwiki Error: Unable to resolve link!'
      return 0
    else
      call vimwiki#base#edit_file('open', url, [], 0)
      return 1
    endif
  endfunction " }}}

set formatoptions=cqr

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  let p = '^\s*|.*|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

execute pathogen#infect()

