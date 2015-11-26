" vim:foldmethod=marker

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
    let mapleader=','
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
    endif
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
    " Github Flavored Markdown
    Plugin 'jtratner/vim-flavored-markdown'
    " Tagbar
    Plugin 'majutsushi/tagbar'

    if has('lua')
        " Excellent autocompletion.
        Plugin 'Shougo/neocomplete.vim'
    endif

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
        " HTML5 highlighting
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
        let g:airline#extensions#tabline#enabled = 1
    " }}}
    " NerdTree {{{
        "Toogle key binding.
        nnoremap <leader>n :NERDTreeFocus<CR>
        nnoremap <leader>N :NERDTreeToggle<CR>
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
    if index(g:tdvimrc_features, "web") != -1
        " Enable Emmet
        let g:user_emmet_install_global = 1
    endif
    " }}}
    " Tagbar {{{
        nnoremap <leader>t :TagbarToggle<CR>
    " }}}
    " Neocomplete {{{
    if has('lua')
        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }

        " Define keyword.
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>tdvimrc_cr_function()<CR>
        function! <SID>tdvimrc_cr_function()
            return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
            " For no inserting <CR> key.
            "return pumvisible() ? "\<C-y>" : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        " Close popup by <Space>.
        " inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

        " AutoComplPop like behavior.
        "let g:neocomplete#enable_auto_select = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplete#enable_auto_select = 1
        "let g:neocomplete#disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        " For perlomni.vim setting.
        " https://github.com/c9s/perlomni.vim
        let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
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
        " Use codeschool.
        colorscheme Codeschool
    else
        " Use more colors in terminal
        set t_Co=256
        " Use gruvbox because codeschool looks not good in term
        colorscheme Monokai
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
    augroup END
" }}}

" Local customized vimrc {{{
    if filereadable(glob("~/.vimrc.after.local"))
        source ~/.vimrc.after.local
    endif
" }}}
