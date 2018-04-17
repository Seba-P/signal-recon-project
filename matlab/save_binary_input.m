
function count = save_binary_input(input_bin, data)

    fd = fopen(input_bin, 'w');
    
    data_int = cast(32768/4 * data, 'int16');
    fwrite(fd, data_int, 'int16', 0, 'b');
    
    fclose(fd);

end
