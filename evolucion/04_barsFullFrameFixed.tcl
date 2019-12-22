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

# Canvas
set theCanvas [ canvas .can -width $H_MAX_SIZE -height $V_MAX_SIZE -background "#303030" ]

# Image
set theImage [ image create photo -width $H_MAX_SIZE -height $V_MAX_SIZE -palette 256/256/256 ]

# Canvas image item
set theImageId [ .can create image  0 0 -anchor nw -image $theImage ]

pack .can

wm title . "VGA Renderer - Bars Fixed"
wm geometry . "${H_MAX_SIZE}x${V_MAX_SIZE}"


for { set idx 1} { $idx <= 7 } { incr idx } {
  set f($idx) [ expr {$H_DISPLAY / 8 * $idx    } ]
} 

for { set y 0 } { $y <= $V_MAX } { incr y  } {
  for { set x 0 } { $x <= $H_MAX } { incr x } {
    if { $y <= $V_DISPLAY } {
      if {$x < $H_DISPLAY } {
        if { $x < $f(1)  } {
          $theImage put "#ffffff" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } elseif { $x >= $f(1)  && $x < $f(2) } {
          $theImage put "#ffff00" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } elseif { $x >= $f(2)  && $x < $f(3) } {
          $theImage put "#00fefe" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } elseif { $x >= $f(3)  && $x < $f(4) } {
          $theImage put "#00fe00" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } elseif { $x >= $f(4)  && $x < $f(5) } {
          $theImage put "#fe00fe" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } elseif { $x >= $f(5)  && $x < $f(6) } {
          $theImage put "#fe0000" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } elseif { $x >= $f(6)  && $x < $f(7) } {
          $theImage put "#0000fe" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } else {
          $theImage put "#000000" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        }
      } else {
        if { $x > $H_SYNC_START &&  $x < $H_SYNC_END } {
          $theImage put "#129090" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        } else {
          $theImage put "#123030" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        }
      }
    } else {
      if { $y >= $V_SYNC_START && $y <= $V_SYNC_END } {
        $theImage put "#129090" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
      } else {
        $theImage put "#123030" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
      }
    }
  }
}
