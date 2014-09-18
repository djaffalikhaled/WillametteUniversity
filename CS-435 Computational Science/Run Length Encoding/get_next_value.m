function [ pixel, count, updated_compressed_image ] = get_next_value( compressed_image )
    line_size = size(compressed_image);
    line_size = line_size(2);
    for i=1:line_size
       current_char = compressed_image(i);
       if current_char == ';'
           value_pair = compressed_image(1:i-1);
           value_pair = strsplit(value_pair,':');
           pixel = value_pair(1);
           count = value_pair(2);
           pixel = str2num(char(pixel));
           count = str2num(char(count));
           updated_compressed_image = compressed_image(i+1:end);
           return
       elseif current_char == '#'
           pixel = 257;
           count = 0;
           updated_compressed_image = compressed_image(2:end);
           return
       elseif current_char == '$'
           pixel = 258;
           count = 0;
           updated_compressed_image = compressed_image(2:end);
           return
       end
    end
end

