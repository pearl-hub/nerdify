
function post_install(){
    info "Installing or updating the ranger_devicons git repository..."
    local plugin_dir=${HOME}/.config/ranger/plugins
    mkdir -p ${plugin_dir}
    install_or_update_git_repo https://github.com/alexanderjeurissen/ranger_devicons.git "${plugin_dir}/ranger_devicons" ""
    apply "default_linemode devicons" $HOME/.config/ranger/rc.conf false

    local pluginname=vim-devicons
    local giturl=https://github.com/ryanoasis/vim-devicons.git

    info "Installing or updating the $pluginname git repository..."
    local plugin_root="${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    mkdir -p "$plugin_root"
    install_or_update_git_repo $giturl "$plugin_root/$pluginname" ""
    [[ -e "$plugin_root/$pluginname/doc" ]] && \
        vim -c "helptags $plugin_root/$pluginname/doc" -c q

    info "Setting powerline configurations..."
    warn "This will override the content in ~/.config/powerline"
    if ask "Do you want to proceed?" "Y"
    then
        [[ -e $HOME/.config/powerline ]] && rm -rf "$HOME/.config/powerline"
        cp -r "${PEARL_PKGDIR}/powerline" "$HOME/.config/"
        info "Set powerline configuration successfully"
    fi

    if ask "Do you want to setup Tmux status bar for dot-tmux?" "Y"
    then
        link tmux "$PEARL_PKGDIR/tmux-statusbar-common.conf"

        if osx_detect
        then
            link tmux "$PEARL_PKGDIR/tmux-statusbar-osx.conf"
        else
            link tmux "$PEARL_PKGDIR/tmux-statusbar-linux.conf"
        fi
    else
        _unlink_statusbar
    fi

    info "Press 'prefix + I' inside a tmux session to enable the TMUX plugins used by nerdify"

    return 0
}

function post_update(){
    post_install
}

function pre_remove(){
    _unlink_statusbar

    rm -rf "${PEARL_PKGVARDIR}/plugins"

    unapply "default_linemode devicons" $HOME/.config/ranger/rc.conf
    rm -rf ${HOME}/.config/ranger/plugins/ranger_devicons

    [[ -e $HOME/.config/powerline ]] && rm -rf "$HOME/.config/powerline"

    return 0
}

_unlink_statusbar() {
    unlink tmux "$PEARL_PKGDIR/tmux-statusbar-common.conf"
    unlink tmux "$PEARL_PKGDIR/tmux-statusbar-linux.conf"
    unlink tmux "$PEARL_PKGDIR/tmux-statusbar-osx.conf"
}
