MCP9808 QT -> Temperature sensor wicth I2C (www.adafruit.com/product/1782)
Feather RP2040 -> Chip Raspberry (~/product/4884)
Teensy 3.5 -> (pjrc.com/store/teensy35.html)
Arduino Uno -> (https://www.adafruit.com/product/4806)
        
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

3.
$ sudo apt-get update
$ sudo apt-get install libgraphicsmagick++-dev libwebp-dev -y


                ##--For gif and picture--##
4.
Use nano/emacs or use a text editor on led-image-viewer.cc 
line 252 we have : RGBMatrix::Options matrix_options;
we want to change the default hardware_mapping

So after this line write: matrix_options.hardware_mapping = "adafruit_hat";
save this and build it with the makefile
$ make led-image-viewer

5.
download a gif / png / jpg / ... 
and run it 
$ sudo ./led-image-viewer image.gif --led-no-hardware-pulse


                ##--For Scrooltext--##
6.
Use nano/emacs or use a text editor on text-scroller.cc 
line 85 we have : RGBMatrix::Options matrix_options;
we want to change the default hardware_mapping

So after this line write: matrix_options.hardware_mapping = "adafruit_hat";
save this and build it with the makefile
$ make text-scroller


-s = speed/sec of letters
-B = color background && -C = color letters
-t = spacing between letters

Big letter (bold) right to the left
$ sudo ./text-scroller -f ../fonts/texgyre-27.bdf -s1 -y-9 "text"

Big letter without bold right to the left
$ sudo ./text-scroller -f ../fonts/clR6x12n.bdf -s1 -y9 "text"

Small letter without bold right to the left
$ sudo ./text-scroller -f ../fonts/tom-thumb.bdf -s1 -y9 "text"


                ##--For StarWars--##

Draw text on the pannel -> rgb_matrix::DrawText();

For the direction text ->    "```code
                            x += scroll_direction;
                            if ((scroll_direction < 0 && x + length < 0) ||
                                (scroll_direction > 0 && x > canvas->width())) {
                            x = x_orig + ((scroll_direction > 0) ? -length : 0);
                            if (loops > 0) --loops;
                            }"

Get the legnth of the text ->   "```code
                                length = rgb_matrix::DrawText(offscreen_canvas, font,
                                    x, y + font.baseline(),
                                    color, NULL,
                                    line.c_str(), letter_spacing);"


Just use utils folder and we need include, lib & fonts folders
