
function output = load_binary_output(output_bin)

    fd = fopen(output_bin);
    
    output = fread(fd, 'int16', 0, 'b');
    output = cast(1 / 32768 * output', 'single');
    
    fclose(fd);

end