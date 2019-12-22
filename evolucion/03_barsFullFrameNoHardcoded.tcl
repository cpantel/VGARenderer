# horizontal constants
set H_DISPLAY    640 ; # horizontal display width
set H_BACK        48 ; # horizontal left border (back porch)
set H_FRONT       16 ; # horizontal right border (front porch)
set H_SYNC        96 ; # horizontal sync width

# vertical constants
set V_DISPLAY    480 ; # vertical display height
set V_TOP         33 ; # vertical top border
set V_BOTTOM      10 ; # vertical bottom border
set V_SYNC         2 ; # vertical sync # lines

# derived constants
set H_SYNC_START   [expr { $H_DISPLAY + $H_FRONT }]
set H_SYNC_END     [expr { $H_DISPLAY + $H_FRONT  + $H_SYNC   - 1 }]
set H_MAX_SIZE     [expr { $H_DISPLAY + $H_BACK   + $H_FRONT  + $H_SYNC }]
set H_MAX          [expr { $H_MAX_SIZE - 1 }]
set V_SYNC_START   [expr { $V_DISPLAY + $V_BOTTOM }]
set V_SYNC_END     [expr { $V_DISPLAY + $V_BOTTOM + $V_SYNC   - 1 }]
set V_MAX_SIZE     [expr { $V_DISPLAY + $V_TOP    + $V_BOTTOM + $V_SYNC }]
set V_MAX          [expr { $V_MAX_SIZE - 1 }]


puts "H_SYNC_START $H_SYNC_START"
puts "H_SYNC_END $H_SYNC_END"
puts "H_MAX $H_MAX"
puts "V_SYNC_START $V_SYNC_START"
puts "V_SYNC_END $V_SYNC_END"
puts "V_MAX $V_MAX"

# Canvas
set theCanvas [ canvas .can -width $H_MAX_SIZE -height $V_MAX_SIZE -background gray ]

# Image
set theImage [ image create photo -width $H_MAX_SIZE -height $V_MAX_SIZE -palette 256/256/256 ]

# Canvas image item
set theImageId [ .can create image  0 0 -anchor nw -image $theImage ]

pack .can

wm title . "VGA Renderer - Bars"
wm geometry . "${H_MAX_SIZE}x${V_MAX_SIZE}"

set f1 [ expr {$H_DISPLAY / 8     } ]
set f2 [ expr {$H_DISPLAY / 8 * 2 } ]
set f3 [ expr {$H_DISPLAY / 8 * 3 } ]
set f4 [ expr {$H_DISPLAY / 8 * 4 } ]
set f5 [ expr {$H_DISPLAY / 8 * 5 } ]
set f6 [ expr {$H_DISPLAY / 8 * 6 } ]
set f7 [ expr {$H_DISPLAY / 8 * 7 } ]
set f8 [ expr {$H_DISPLAY / 8 * 8 } ]


for { set x 0 } { $x <= $H_DISPLAY } { incr x } {
  for { set y 0 } { $y <= $V_DISPLAY } { incr y  } {
    set fx [ expr $x + $H_FRONT ]
    set fy [ expr $y + $V_TOP ]

    if { $x < $f1  } {
      $theImage put "#ffffff" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    } elseif { $x >= $f1  && $x < $f2 } {
      $theImage put "#ffff00" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    } elseif { $x >= $f2  && $x < $f3 } {
      $theImage put "#00fefe" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    } elseif { $x >= $f3  && $x < $f4 } {
      $theImage put "#00fe00" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    } elseif { $x >= $f4  && $x < $f5 } {
      $theImage put "#fe00fe" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    } elseif { $x >= $f5  && $x < $f6 } {
      $theImage put "#fe0000" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    } elseif { $x >= $f6  && $x < $f7 } {
      $theImage put "#0000fe" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    } else {
      $theImage put "#000000" -to $fx $fy [expr {$fx + 1}] [expr {$fy + 1}]
    }
  }
}
