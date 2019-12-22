# Canvas
set theCanvas [ canvas .can -width 640 -height 480 -background gray ]

# Image
set theImage [ image create photo -width 640 -height 480 -palette 256/256/256 ]

# Canvas image item
set theImageId [ .can create image  0 0 -anchor nw -image $theImage ]

pack .can

wm title . "VGA Renderer - Bars"
wm geometry . 640x480

for { set x 0 } { $x <= 640 } { incr x } {
  for { set y 0 } { $y <= 480 } { incr y  } {
    if { $x < 80  } {
      $theImage put "#ffffff" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    } elseif { $x >= 80  && $x < 160 } {
      $theImage put "#ffff00" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    } elseif { $x >= 160  && $x < 240 } {
      $theImage put "#00fefe" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    } elseif { $x >= 240  && $x < 320 } {
      $theImage put "#00fe00" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    } elseif { $x >= 320  && $x < 400 } {
      $theImage put "#fe00fe" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    } elseif { $x >= 400  && $x < 480 } {
      $theImage put "#fe0000" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    } elseif { $x >= 480  && $x < 560 } {
      $theImage put "#0000fe" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    } else {
      $theImage put "#000000" -to $x $y [expr {$x + 1}] [expr {$y + 1}]
    }
  }
}
