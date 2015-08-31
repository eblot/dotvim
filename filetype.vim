if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
  " Treat Neotion SDK CMake macro file as a cmake file
  " set verbose=9
  autocmd BufReadPost *.txt setfiletype cmake
augroup END

au BufRead,BufNewFile *.srec set filetype=srecord
au! Syntax srecord source $HOME/.vim/syntax/srecord.vim

