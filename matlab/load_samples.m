
function samples = load_samples(file, format = 'binary')

    fd = fopen(file, 'r');

    samples_struct  = [];
    tmp_str         = [];

    if strcmp(tolower(format), 'text')
        while (1)
            tmp_str = fgetl(fd);

            if (tmp_str == -1)
                break;
            end

            samples_struct = [ samples_struct, sscanf(substr(tmp_str, -6), '0x%04x\n', "C") ];
        end
	else
	    samples_struct = fread(fd, 'uint16', 0, 'b');
	end

    samples = zeros(length(samples_struct), 2);

    for i = 1:length(samples_struct)
        samples(i, 1) = (samples_struct(i) >= 2^15);

        if (samples_struct(i) >= 2^15)
            samples(i, 2) = samples_struct(i) - 2^15;
        else 
            samples(i, 2) = samples_struct(i);
        end
    end

    fclose(fd);

end
