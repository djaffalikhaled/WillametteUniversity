function [ image ] = decompress_image( filename )
	compressed_image = fileread(filename);
    n = 1;
    image = [];
    dimensions = [];
	while (isempty(compressed_image) == 0)
       [ dimension, compressed_image ] = get_next_dimension( compressed_image );
       dimensions(:,:,n) = dimension;
       n = n+1;
    end
    dimension_count = size(dimensions);
    dimension_count = dimension_count(3);
    for dim = 1:dimension_count
       image(:,:,dim) =  dimensions(:,:,dimension_count+1-dim);
    end
    image = uint8(image);
end
