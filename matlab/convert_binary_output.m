
function output = convert_binary_output(output_bin)

    fd = fopen(output_bin);
    
    output = fread(fd, 'short');
    output = output';
    
    fclose(fd);

end
