if line("$") == 1 && strlen(getline(1)) == 0
    call feedkeys("i_program\<tab>")
endif
set foldmethod=indent
set foldnestmax=2
set foldlevel=1
