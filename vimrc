colorscheme darkblue

winpos 1 0
set number
set tabstop=4
set nohlsearch
set lines=80 columns=84

autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

autocmd WinEnter * call AdjustWindow() 

command Openheader call OpenHeader()

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
      set columns+=84
      wincmd=
    endif
  endif
  if exists('w:created')
    if winwidth(0) > 86
      set columns-=84
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
