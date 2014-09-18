Run Length Encoding
-------------------

This is a library for performing run length encoding on images in matlab.  Aside from just performing run length encoding this library can also incorporate a threshold value and compress images further by ignoring slight variations in pixel values.  This is a final project for CS-435 at Willamette University.

API Usage
-----

```matlab
original_image = imread('image.jpg');
threshold = 5;
compress(original_image,threshold,'compressed.rle');
decompressed_image = decompress_image('compressed.rle');
imshow(decompressed_image);
```

GUI Usage
---------

The compression API can also be used with the simple provided GUI. Run the GUI and load the uncompressed image on the left side to compress it.  Loading a compressed image (.rle encoding) on the right side allows one to decompress an image.

License
-------

This project is licensed under the MIT license, please see LICENSE.md for more information.
