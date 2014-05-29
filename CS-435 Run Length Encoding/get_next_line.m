function [ line, remaining_file, is_end ] = get_next_line( remaining_file )
    line = [];
    is_end = 0;
    while 1
        [ pixel, count, remaining_file ] = get_next_value(remaining_file);
        if (pixel == 257)
            return
        elseif (pixel == 258)
            is_end = 1;
            return
        else
            for m = 1:count
               line = [line,pixel]; 
            end
        end
    end
end
