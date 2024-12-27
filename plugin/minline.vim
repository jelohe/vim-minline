if exists('g:loaded_statusline')
  finish
endif
let g:loaded_statusline = 1

let g:mode_colors = {
\ 'n':      'StatusLineSection',
\ 'v':      'StatusLineSectionV',
\ "\<c-v>": 'StatusLineSectionV',
\ 'i':      'StatusLineSectionI',
\ 'c':      'StatusLineSectionC',
\ 'r':      'StatusLineSectionR'
\ }

fun! StatusLineRenderer()
  let hl = '%#' . get(g:mode_colors, tolower(mode()), g:mode_colors.n) . '#'

  return hl
        \ . (&modified ? ' + │' : '')
        \ . ' %F %#StatusLine#%='
        \ . hl
        \ . ' %l:%L '
endfun

fun! <SID>StatusLineHighlights()
  hi StatusLine         ctermbg=1 ctermfg=15
  hi StatusLineNC       ctermbg=0 ctermfg=8
  hi StatusLineSection  ctermbg=4 ctermfg=0
  hi StatusLineSectionV ctermbg=5 ctermfg=0
  hi StatusLineSectionI ctermbg=3 ctermfg=0
  hi StatusLineSectionC ctermbg=1 ctermfg=0
  hi StatusLineSectionR ctermbg=2 ctermfg=0
endfun

call <SID>StatusLineHighlights()

augroup statusline_plugin
  au!
  au FocusGained,VimEnter,WinEnter,BufWinEnter *
    \ setlocal statusline=%!StatusLineRenderer()
  au FocusLost,VimLeave,WinLeave,BufWinLeave *
    \ setlocal statusline&
  au Colorscheme * call <SID>StatusLineHighlights()
augroup END
