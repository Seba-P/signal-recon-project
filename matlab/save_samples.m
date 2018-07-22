
function samples_struct = save_samples(file, samples, format = 'binary')

    fd = fopen(file, 'w');

    samples_struct = zeros(1, rows(samples));

    for i = 1:rows(samples)
        samples_struct(i) = samples(i,1) * 2^15 + samples(i,2);
    endfor

    if strcmp(tolower(format), 'text')
    	fprintf(fd, "0x%04X\n", samples_struct);
	else
	    fwrite(fd, samples_struct, 'uint16', 0, 'b');
	end

    fclose(fd);

end
