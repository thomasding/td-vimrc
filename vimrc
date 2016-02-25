" vim:foldmethod=marker

set nocompatible

if filereadable(glob("~/.vimrc.before.local"))
    source ~/.vimrc.before.local
endif

if !exists("g:tdvimrc_features")
    let g:tdvimrc_features = []
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
    " Show line number on the left.
    set number
    set relativenumber
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
    " Set leader key to comma.
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
    " Show a vertical line in Column 80.
    set colorcolumn=80
    " Do not wrap lines.
    set nowrap

    " If tmux feature is not enabled, we support window switching shortcuts
    " manually.
    if index(g:tdvimrc_features, "tmux") == -1
        nnoremap <C-h> :wincmd h<CR>
        nnoremap <C-l> :wincmd l<CR>
        nnoremap <C-j> :wincmd j<CR>
        nnoremap <C-k> :wincmd k<CR>
    endif
" }}}

" Vundle {{{
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
    " Parenthesizing and quoting plugin.
    Plugin 'tpope/vim-surround'
    " A colorscheme pack.
    Plugin 'flazz/vim-colorschemes'
    " NerdTree.
    Plugin 'scrooloose/nerdtree'
    " Git plugin for NerdTree.
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    " Show a git diff in the gutter.
    Plugin 'airblade/vim-gitgutter'
    " Helpful undotree
    Plugin 'mbbill/undotree'
    " Github Flavored Markdown
    Plugin 'jtratner/vim-flavored-markdown'
    " Tagbar
    Plugin 'majutsushi/tagbar'
    " Tabular
    Plugin 'godlygeek/tabular'
    " Indent guide
    Plugin 'nathanaelkane/vim-indent-guides'
    " Python style checker
    Plugin 'nvie/vim-flake8'
    " YCM
    Plugin 'Valloric/YouCompleteMe'

    if index(g:tdvimrc_features, "web") != -1
        " Emmet
        Plugin 'mattn/emmet-vim'
        " Enahanced javascript syntax
        Plugin 'pangloss/vim-javascript'
        " HTML5 syntax
        Plugin 'othree/html5.vim'
    endif

    if index(g:tdvimrc_features, "tmux") != -1
        " Tmux status line
        Plugin 'edkolev/tmuxline.vim'
        " Tmux navigation
        Plugin 'christoomey/vim-tmux-navigator'
    endif

    if index(g:tdvimrc_features, "golang") != -1
        " Go Plugin
        Plugin 'fatih/vim-go'
    endif

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
    " Fugitive {{{
        nnoremap <leader>gs :Gstatus<CR>
        nnoremap <leader>gc :Gcommit<CR>
        nnoremap <leader>gw :Gwrite<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gb :Gblame<CR>
    " }}}
    " Airline {{{
        " Always show the airline.
        set laststatus=2
        " Show the buffer line on the top.
        let g:airline#extensions#tabline#enabled = 1
    " }}}
    " NerdTree {{{
        "Toogle key binding.
        nnoremap <leader>n :NERDTreeFocus<CR>
        nnoremap <leader>N :NERDTreeToggle<CR>
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
    " Emmet {{{
    if index(g:tdvimrc_features, "web") != -1
        " Enable Emmet
        let g:user_emmet_install_global = 1
    endif
    " }}}
    " Tagbar {{{
        nnoremap <leader>t :TagbarToggle<CR>
    " }}}
    " Indent Guide {{{
        let g:indent_guides_guide_size = 1
        let g:indent_guides_start_level = 2
    " }}}
    " Tmuxline {{{
    if index(g:tdvimrc_features, "tmux") != -1
        let g:tmuxline_powerline_separators = 0
        let g:tmuxline_separators = {
            \ 'left'      : '',
            \ 'left_alt'  : '>',
            \ 'right'     : '',
            \ 'right_alt' : '<',
            \ 'space'     : ' '}
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
        " Use codeschool. It will cause errors before the colorscheme plugin
        " is installed, so ignore the errors by silent!.
        silent! colorscheme Codeschool
    else
        " Use more colors in terminal
        set t_Co=256
        " Use gruvbox because codeschool looks ugly in terminal.
        silent! colorscheme gruvbox
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
        " Set the indentation in HTML and javascript to 2 spaces.
        autocmd FileType html,javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
        " Enable Emmet in HTML and CSS
        " Use GFM instead of standard markdown
        autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
        " Remove unwanted trailing spaces on save.
        autocmd BufWritePre * :call <SID>tdvimrc_strip_spaces()
        " Map \p to flake8 in python
        autocmd FileType python map <buffer> <leader>p :call Flake8()<cr>
    augroup END
" }}}

" Local customized vimrc {{{
    if filereadable(glob("~/.vimrc.after.local"))
        source ~/.vimrc.after.local
    endif
" }}}
