" vim:foldmethod=marker

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
    let mapleader=','
    " Use dark background in color scheme.
    set background=dark
    " Enable case-insensitive incremental search and highlight.
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch
" }}}

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
    " Emmet
    Plugin 'mattn/emmet-vim'
    " Jinja2 support
    Plugin 'mitsuhiko/vim-jinja'
    " Github Flavored Markdown
    Plugin 'jtratner/vim-flavored-markdown'
    " Enahanced javascript syntax
    Plugin 'pangloss/vim-javascript'
    " JSX language
    Plugin 'mxw/vim-jsx'
    " Tmux status line
    Plugin 'edkolev/tmuxline.vim'
    " Tmux navigation
    Plugin 'christoomey/vim-tmux-navigator'
    " PHP better indent with html
    Plugin 'captbaritone/better-indent-support-for-php-with-html'
    " PHP highlighting
    Plugin 'StanAngeloff/php.vim'
    " HTML5 highlighting
    Plugin 'othree/html5.vim'
    " All-in-one syntax checker
    Plugin 'scrooloose/syntastic'

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
    " }}}
    " NerdTree {{{
        "Toogle key binding.
        nnoremap <leader>n :NERDTreeToggle<CR>
    " }}}
    " Undotree {{{
        " Key shortcuts for undotree
        nnoremap <leader>u :UndotreeToggle<cr>
        " Persistant undo
        if has('persistent_undo')
            silent call system('mkdir -p ~/.vim-undo')
            set undodir=~/.vim-undo
            set undofile
        endif
    " }}}
    " Emmet {{{
        " Enable Emmet only in HTML and CSS
        let g:user_emmet_install_global = 1
    " }}}
    " JSX {{{
        let g:jsx_ext_required = 0
    " }}}
    " Syntastic {{{
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        " Auto close, but not auto open.
        let g:syntastic_auto_loc_list = 2
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
    " }}}
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
        " Hide menubar.
        set guioptions-=m
        " Use codeschool.
        colorscheme codeschool
    else
        " Use more colors in terminal
        set t_Co=256
        " Use gruvbox because codeschool looks not good in term
        colorscheme Monokai
    endif
" }}}

" Autocmds {{{
    augroup vimrc_autocmds
        autocmd!
        " Set the indentation in HTML and javascript to 2 spaces.
        autocmd FileType html,javascript,jinja,php setlocal shiftwidth=2 tabstop=2 softtabstop=2
        " Highlight characters past column 80 in Python.
        autocmd FileType python highlight Excess ctermbg=Red guibg=Red
        autocmd FileType python match Excess /\%80v.*/
        " Do not wrap lines in Python.
        autocmd FileType python set nowrap
        " Enable Emmet in HTML and CSS
        " Close Preview window after autocompletion
        autocmd CompleteDone * pclose
        " Use GFM instead of standard markdown
        autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
    augroup END
" }}}

" Local .vimrc {{{
    if filereadable(glob("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }}}
