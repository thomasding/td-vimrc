" vim:foldmethod=marker

set nocompatible

" Load the before script.
if filereadable(glob("~/.vimrc.before.local"))
    source ~/.vimrc.before.local
endif

" Language {{{
    " Use English and UTF-8 regardless of the system language.
    let $LANG = 'en'
    set langmenu=en
    set encoding=utf-8

    " Try UTF-8 first and then Chinese gbk.
    set fileencodings=utf-8,gbk
" }}}

" Edit {{{
    " Disable syntax highlighting.
    syntax off

    " Show line number on the left.
    set number

    " Always show the line number and column number in the status bar.
    set ruler

    " Use space instead of tab.
    set expandtab

    " Set indentation to 4 space by default.
    set tabstop=8
    set shiftwidth=4
    set softtabstop=4

    " Show a visual line under the cursor's current line.
    set cursorline

    " Show the matching brackets.
    set showmatch

    " Complete in command.
    set wildmenu
    set wildmode=longest,list,full

    " No backup, no swap.
    set nobackup
    set noswapfile

    " Set leader key to backslash.
    let mapleader='\'

    " Use dark background in color scheme.
    set background=dark

    " Enable case-insensitive incremental search and highlight.
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch

    " Make backspace full functional.
    set backspace=2

    " Do not wrap lines.
    set nowrap

" }}}

" Vundle {{{
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Let Vundle manage Vundle.
    Plugin 'VundleVim/Vundle.vim'

    " Ctrl-P helps finding files faster.
    Plugin 'kien/ctrlp.vim'

    " Helpful undotree
    Plugin 'mbbill/undotree'

    " Load customized plugins
    if filereadable(glob("~/.vimrc.plugin.local"))
        source ~/.vimrc.plugin.local
    endif

    call vundle#end()
    filetype plugin indent on
" }}}

" Plugin settings {{{
    " Ctrl-P {{{
        " Exclude these files in CtrlP.
        set wildignore+=*.pyc
        let g:ctrlp_custom_ignore = 'node_modules'
    " }}}

    " Undotree {{{
        " Key shortcuts for undotree
        function! <SID>tdvimrc_undotree_focus()
            UndotreeToggle
            UndotreeFocus
        endfunction
        nnoremap <leader>u :call <SID>tdvimrc_undotree_focus()<CR>
        " Persistant undo
        if has('persistent_undo')
            silent call system('mkdir -p ~/.vim-undo')
            set undodir=~/.vim-undo
            set undofile
        endif
    " }}}
" }}}

" GUI and console {{{
    if has('gui_running')
        if has('win32')
            " Set font family to Consolas and size to 10.
            set guifont=Consolas:h10
        elseif has('mac')
            set guifont=Menlo:h12
        else
            " Set font family to Monospace and size to 10.
            set guifont=Monospace\ 10
        endif
        " Hide right scroll bar.
        set guioptions-=r
        " Hide left scroll bar.
        set guioptions-=L
        " Hide toolbar.
        set guioptions-=T
        " Hide menubar.
        set guioptions-=m
    else
        " Use more colors in terminal
        set t_Co=256
    endif
" }}}

" Autocmds {{{
    function! <SID>tdvimrc_strip_spaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunction

    augroup vimrc_autocmds
        autocmd!

        " Remove unwanted trailing spaces on save.
        autocmd BufWritePre * :call <SID>tdvimrc_strip_spaces()
    augroup END
" }}}

" Local customized vimrc {{{
    if filereadable(glob("~/.vimrc.after.local"))
        source ~/.vimrc.after.local
    endif
" }}}
