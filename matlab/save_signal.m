
function signal_int = save_signal(file, signal, format = 'binary')

    fd = fopen(file, 'w');

    signal_int = floor(32768*(signal + 2*(signal < 0)));

    if strcmp(tolower(format), 'text')
        fprintf(fd, "0x%04X\n", signal_int);
    else
        fwrite(fd, signal_int, 'int16', 0, 'b');
	end

    fclose(fd);

end
