" More information about how this config has been setup here:
" - https://github.com/ryanoasis/powerline-extra-symbols
" - https://github.com/ryanoasis/dotfiles

let g:airline_left_sep = "\uE0C6"
let g:airline_right_sep = "\uE0C7"


let g:syntastic_style_error_symbol = ''
let g:syntastic_error_symbol = ''
let g:syntastic_warning_symbol = ''
" Other cool characters:
" '⚡' '😱' '✗' '➽'
" ⚑ ⚐ ♒ ⛢ ❕ ❗


let g:gitgutter_sign_added = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_modified = 'ﰣ'
let g:gitgutter_sign_removed_first_line = ''
" or '≃' but it is not available for all fonts
let g:gitgutter_sign_modified_removed = '≈'

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

set encoding=UTF-8

" This will look for directories containing 'pack/*/start'
set packpath+=$PEARL_PKGVARDIR/plugins

" The following is required in order to show the folder symbol:
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

