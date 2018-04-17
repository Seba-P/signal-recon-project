
function count = save_binary_input(input_bin, data)

    fd = fopen(input_bin, 'w');

    data_int = floor(32768 * data);
    fwrite(fd, data_int, 'int16', 0, 'b');

    fclose(fd);

end
