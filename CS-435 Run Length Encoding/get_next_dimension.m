function [ dimension, compressed_file ] = get_next_dimension( compressed_file )
    dimension = [];
    while 1
        [ line, compressed_file, is_end ] = get_next_line( compressed_file );
        if is_end == 1
            dimension = [dimension;line];
            return;
        else
            dimension = [dimension;line];
        end
    end
end