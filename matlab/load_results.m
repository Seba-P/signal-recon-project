
function results = load_results(file, format = 'binary')

    fd = fopen(file, 'r');

    if strcmp(tolower(format), 'text')
        results = fscanf(fd, "0x%04X\n");
        results = results - 65536*(results>32767);
        % results = [];
        % while !feof(fd)
        %     results = [ results hex2dec(fscanf(fd, "")) ];
        % end
    else
        results = fread(fd, 'int16', 0, 'b');
	    % results = cast(1 / 32768 * results', 'single');
    end

    results = cast(1 / 32768 * results', 'single');

    fclose(fd);

end
