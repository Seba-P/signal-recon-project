
function results = load_signal(file, format = 'binary')

    fd = fopen(file, 'r');

    if strcmp(tolower(format), 'text')
        results = fscanf(fd, '0x%04x\n');
        results = results - 65536*(results>32767);
    else
        results = fread(fd, 'int16', 0, 'b');
    end

    results = cast(1 / 32768 * results', 'single');

    fclose(fd);

end
