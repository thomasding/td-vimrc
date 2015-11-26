#!/bin/bash

# Step 1: clone the vimrc to local home directory.
git clone https://github.com/thomasding/td-vimrc.git ~/.td-vimrc

# Step 2: link the vimrc to .vimrc file.
ln -s ~/.td-vimrc/vimrc ~/.vimrc

# Step 3: clone vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Step 4: install base plugins.
vim -e +PluginInstall +qa

# Step 5: create .vimrc.before.local .vimrc.after.local and .vimrc.plugin.local
if [ ! -f ~/.vimrc.before.local ]; then
    cat << 'EOF_BEFORE_LOCAL' > ~/.vimrc.before.local
" This file is loaded before the configuration in .vimrc is loaded.
" Modify g:tdvimrc-features to enable more features.
" After enabling or disabling featuers, you need to run :PluginClean and
" :PluginInstall in VIM to remove and add the plugins in the features you enable.
"
" let g:tdvimrc-features = ['golang', 'tmux', 'html']
"
let g:tdvimrc-features = []
EOF_BEFORE_LOCAL
fi

if [ ! -f ~/.vimrc.after.local ]; then
    cat << 'EOF_AFTER_LOCAL' > ~/.vimrc.after.local
" This file is loaded after the configuration in .vimrc is loaded.
" You can override the configurations in .vimrc by editing this file.
"
EOF_AFTER_LOCAL
fi

if [ ! -f ~/.vimrc.bundle.local ]; then
    cat << 'EOF_BUNDLE_LOCAL' > ~/.vimrc.bundle.local
" Configure your plugins in this file so that Vundle manages your plugins.
" After adding or removing your plugins, you need to run :PluginInstall to
" install new plugins and :PluginClean to remove unneeded plugins in VIM.
"
" Plugin 'myplugin/myplugin'
EOF_BUNDLE_LOCAL
fi
