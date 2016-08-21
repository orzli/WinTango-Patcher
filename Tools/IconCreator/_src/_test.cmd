::convert.exe -resize 32x32 address-book-new_16.png OUT_address-book-new_32.png

convert.exe -background none address-book-new_24.svg OUT_address-book-new_24.png

::convert.exe -background none address-book-new_24.svg OUT_address-book-new_24.jpg

::convert.exe -background none -density 4000 -resize 48x48 address-book-new_24.svg OUT_address-book-new_48.png

::convert.exe -background none -gravity center -extent 20x20 address-book-new_16.png OUT_address-book-new_20.png

::convert.exe PNG_to_BMP.png BMP.bmp ...not working!