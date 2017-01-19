execute pathogen#infect('plugins/{}')

set laststatus=2

set guifont=Cousine\ 12

" Command to turn on writing mode
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,txt} call WritingMode()

" Solarized config
syntax enable
set background=dark
colorscheme solarized

set cursorline

winpos 1 0
set number
set tabstop=4
set nohlsearch
set lines=50 columns=84

autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

autocmd WinEnter * call AdjustWindow() 

command Openheader call OpenHeader()

" Configure Lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Configure Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

" Python
let g:syntastic_python_checkers=['pyflakes']

" C
let g:syntastic_c_include_dirs=['../include']

" Global var containing lowercase-uppercase command pairs
let g:command_line_substitutes = [
  \ ['^hdr', 'Openheader'],
\]

" Global var containing include dirs
let g:include_dirs = [
  \ ['/usr/include/'],
  \ ['/usr/local/include/'],
  \ ['/usr/lib/syslinux/com32/include/'],
  \ ['/usr/include/x86_64-linux-gnu/'],
\]

" Remap enter key to call CommandLineSubstitute
cnoremap <enter> <c-\>eCommandLineSubstitute()<enter><enter>

function AdjustWindow()
  if !exists('w:created')
    if winwidth(0) < 84
      set columns+=85
      wincmd=
    endif
  endif
  if exists('w:created')
    if winwidth(0) > 84
      set columns-=85
      wincmd=
    endif
  endif
endfunction

" Opens the .h file that corresponds to a src file name
function OpenHeader()
  
  " Parse header name
  let line = split(getline("."))
  if len(line) > 0
    if string(line[0]) =~ "#include"
      let hname = line[1][1:len(line[1])-2]
    else
      let hname = expand('%:t:r') . '.h'
    endif
  else
    let hname = expand('%:t:r') . '.h'
  endif

  " Search one directory up
  let k = expand('%:p:h:h') . '/include/'
  if AttemptOpen(k,hname)
    return
  endif

  " Search in the default dirs
  for [k] in g:include_dirs
    if AttemptOpen(k,hname)
      return
    endif
  endfor

  echo 'File ' . hname . ' not found'

endfunction

function AttemptOpen(k,hname)
  let fullpath = a:k . a:hname
  if filereadable(fullpath)
    if !match(@%,fullpath)
      echo 'File ' . a:hname . ' already open'
      return 1
    endif
    execute 'sp ' . fullpath
    return 1
  else
    return 0
  endif
  return 1
endfunction

" Looks for substitutions for lowercase user-defined commands
function CommandLineSubstitute()
  let cl = getcmdline()
  if exists('g:command_line_substitutes')
    for [k, v] in g:command_line_substitutes
      if match(cl,k) == 0
        let cl = substitute(cl, k, v, '')
        break
      endif
    endfor
  endif
  return cl
endfunction

" Special writing mode for certain extensions
function WritingMode()
  set background=light
  set lines=40 columns=100
  set guioptions-=r
  set laststatus=0
  set noruler
  set linebreak
  set cursorline!
  set number!
  %le10
  %re10
endfunction
