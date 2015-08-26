" vim:foldmethod=marker

" Vundle {{{
    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Let Vundle manage Vundle.
    Plugin 'VundleVim/Vundle.vim'
    " Ctrl-P helps finding files faster.
    Plugin 'kien/ctrlp.vim'
    " Another powerful status line.
    Plugin 'bling/vim-airline'
    " Git plugin.
    Plugin 'tpope/vim-fugitive'
    " Python in VIM.
    Plugin 'klen/python-mode'
    " Parenthesizing and quoting plugin.
    Plugin 'tpope/vim-surround'
    " A colorscheme pack.
    Plugin 'flazz/vim-colorschemes'
    " NerdTree.
    Plugin 'scrooloose/nerdtree'
    " Git plugin for NerdTree.
    Plugin 'Xuyuanp/nerdtree-git-plugin'

    call vundle#end()
    filetype plugin indent on
" }}}

" Plugin settings {{{
    " Exclude these files in CtrlP.
    set wildignore+=*.pyc
    " Shortcuts for fugitive.
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>gc :Gcommit<CR>
    " Always show the airline.
    set laststatus=2
    " NerdTree settings {{{
        "Toogle key binding.
        nnoremap <C-n> :NERDTreeToggle<CR>
        " Open NerdTree if no arguments are given at startup.
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " }}}
    " Python-mode settings {{{
        " Do not display colorcolumn.
        let g:pymode_options_colorcolumn = 0
        " Search rope project directory in parent directories.
        let g:pymode_rope_lookup_project = 1
        " Autoimport.
        let g:pymode_rope_autoimport = 1
        " Bind shortcuts.
        nnoremap <C-c>la :PymodeLintAuto<CR>
    " }}}
" }}}

" Edit {{{
    " Show line number on the left.
    set number
    " Always show the line number and column number in the status bar.
    set ruler
    " Use syntax highlighting.
    syntax on
    " Remap Escape to more convenient jj.
    inoremap jj <esc>
    " Use space instead of tab.
    set expandtab
    " Set indentation to 4 space by default.
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    " Set leader key to comma.
    let mapleader=','
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
" }}}

" GUI and console {{{
    if has('gui_running')
        " Set font family to Monospace and size to 10.
        set guifont=Monospace\ 10
        " Hide right scroll bar.
        set guioptions-=r
        " Hide left scroll bar.
        set guioptions-=L
        " Hide toolbar.
        set guioptions-=T
        " Use codeschool.
        colorscheme codeschool
    else
        colorscheme Tomorrow
    endif
" }}}

" Languages {{{
    augroup vimrc_autocmds
        autocmd!
        " Set the indentation in HTML and javascript to 2 spaces.
        autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
        autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
        " Highlight characters past column 80 in Python.
        autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
        autocmd FileType python match Excess /\%80v.*/
        " Do not wrap lines in Python.
        autocmd FileType python set nowrap
    augroup END
" }}}

" Local .vimrc {{{
    if filereadable(glob("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }}}
