
function post_install(){
    pearl emerge ${PEARL_PKGREPONAME}/fonts

    info "Installing or updating the ranger_devicons git repository..."
    install_or_update_git_repo https://github.com/alexanderjeurissen/ranger_devicons.git "${PEARL_PKGVARDIR}/ranger_devicons" master
    cd "${PEARL_PKGVARDIR}/ranger_devicons"
    make install

    local pluginname=vim-devicons
    local giturl=https://github.com/ryanoasis/vim-devicons.git

    info "Installing or updating the $pluginname git repository..."
    mkdir -p "${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    install_or_update_git_repo $giturl "${PEARL_PKGVARDIR}/plugins/pack/pearl/start/$pluginname" master

    info "Setting powerline configurations..."
    warn "This will override the content in ~/.config/powerline"
    if ask "Do you want to proceed?" "Y"
    then
        [[ -e $HOME/.config/powerline ]] && rm -rf "$HOME/.config/powerline"
        cp -r "${PEARL_PKGDIR}/powerline" "$HOME/.config/"
        info "Set powerline configuration successfully"
    fi

    return 0
}

function post_update(){
    post_install
}

function pre_remove(){
    rm -rf "${PEARL_PKGVARDIR}/plugins"

    cd "${PEARL_PKGVARDIR}/ranger_devicons"
    make uninstall
    rm -rf "${PEARL_PKGVARDIR}/ranger_devicons"

    [[ -e $HOME/.config/powerline ]] && rm -rf "$HOME/.config/powerline"

    return 0
}
