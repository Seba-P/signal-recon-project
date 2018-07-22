
function count = save_binary_input(file, data)

    fd = fopen(file, 'w');

    data_int = floor(32768 * data);
    fwrite(fd, data_int, 'int16', 0, 'b');

    fclose(fd);

end
