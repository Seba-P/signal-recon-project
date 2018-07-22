
function output = load_binary_output(file)

    fd = fopen(file);
    
    output = fread(fd, 'int16', 0, 'b');
    output = cast(1 / 32768 * output', 'single');
    
    fclose(fd);

end
