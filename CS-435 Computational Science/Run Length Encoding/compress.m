function compress( image, threshold, filename )
    file_id = fopen(filename,'w');
    [height, width, depth] = size(image);
    image = double(image);
    for layer = 1 : depth
        for row = 1 : height
            current_row = image(row,:);
            current_pixel = current_row(1);
            i = 1;
            for index = 2 : width
                next_pixel = current_row(index);
                if (abs(next_pixel-current_pixel) <= threshold)
                    i = i + 1;
                else
                    fprintf(file_id,'%d:%d;', current_pixel, i);
                    i = 1;
                    current_pixel = next_pixel;
                end
                if (index == width)
                        fprintf(file_id,'%d:%d;', current_pixel, i);
                end
            end
            fprintf(file_id,'#');
        end
        fprintf(file_id,'$');
    end
end

