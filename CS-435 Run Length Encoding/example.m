clear all;
close all;
clc;

% Load the image with imread
image = imread('double_grad.png');

% Compress with different threshold values
compress(image,0,'double_grad_0.rle');
decompressed_image = decompress_image('double_grad_0.rle');
imshow(decompressed_image);p
imwrite(decompressed_image,'double_grad_0.png');

compress(image,25,'ouble_grad_25.rle');
decompressed_image = decompress_image('double_grad_25.rle');
imshow(decompressed_image);
imwrite(decompressed_image,'double_grad_25.png');

compress(image,50,'double_grad_50.rle');
decompressed_image = decompress_image('double_grad_50.rle');
imshow(decompressed_image);
imwrite(decompressed_image,'double_grad_50.png');
