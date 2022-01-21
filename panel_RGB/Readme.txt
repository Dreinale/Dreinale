MCP9808 QT -> Temperature sensor wicth I2C (www.adafruit.com/product/1782)
Feather RP2040 -> Chip Raspberry (~/product/4884)
Teensy 3.5 -> (pjrc.com/store/teensy35.html)
Arduino Uno -> (https://www.adafruit.com/product/4806)
https://cdn-shop.adafruit.com/970x728/1914-01.jpg
Rasberry Pi -> (https://www.adafruit.com/product/1914)

Panel 32x32:
->tensy 3.5 need a special shield (https://www.kiwi-electronics.nl/nl/smartmatrix-smartled-shield-v4-for-teensy-3-3684?language=nl-nl&currency=EUR&gclid=Cj0KCQiAw9qOBhC-ARIsAG-rdn4PhR1jbxAXTySfY5SoK2ZjoaQQWiv-fczCIP4G1d6s58h_MzMQTZkaArwGEALw_wcB)

->Arduino Uno is limited to 32x16 pixels: single-buffered

-> Rasberry Pi
(tuto montage A-Z: https://learn.adafruit.com/adafruit-rgb-matrix-plus-real-time-clock-hat-for-raspberry-pi/overview)




1. download packages
$ curl https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/rgb-matrix.sh
$ sudo bash rgb-matrix.sh
$ y
$ 2 (install the module RGB Matrix HAT & RTC)
$ 2 (install The “convenience” setting requires no changes and sound still works.)

2.(https://github.com/hzeller/rpi-rgb-led-matrix)
Now go in : rpi-rgb-led-matrix/utils (we have 3 examples in c#)

                ##--For gif and picture--##
3.
Use nano/emacs or use a text editor on led-image-viewer.cc 
line 252 we have : RGBMatrix::Options matrix_options;
we want to change the default hardware_mapping

So after this line write: matrix_options.hardware_mapping = "adafruit_hat";
save this and build it with the makefile
$ make led-image-viewer

4.
download a gif / png / jpg / ... 
and run it 
$ sudo ./led-image-viewer image.gif --led-no-hardware-pulse
