set title "bloat_39"
set palette negative rgbformula 21,22,23
set cbrange [0:2]
set yrange [420:0]
set size ratio 3.11111
set view map
splot "bloat_39.dat" using 1:2:3 with image
pause -1
