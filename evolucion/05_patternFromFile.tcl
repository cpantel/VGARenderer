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
set theCanvas [ canvas .can -width $H_MAX_SIZE -height $V_MAX_SIZE -background "#ff0000" ]

# Image
set theImage [ image create photo -width $H_MAX_SIZE -height $V_MAX_SIZE -palette 256/256/256 ]

# Canvas image item
set theImageId [ .can create image  0 0 -anchor nw -image $theImage ]

pack .can

wm title . "VGA Renderer - Pattern from file"
wm geometry . "${H_MAX_SIZE}x${V_MAX_SIZE}"


# echo $(( 6652012 - 6639207 ))

# echo $(( 3207594 + 12804 ))


set infile [open "simulate.log" r]
set offset 0

# discard until vsync 1 0 1  0  0  0

puts "searching for first vsync..."
while { [gets $infile line] >= 0 && [string index $line 4] != "1" } { incr offset }
puts "line    : $line"
puts "offset  : $offset"

puts "skipping vsync"
while { [gets $infile line] >= 0 && [string index $line 4] == "1"} { incr offset }
puts "line    : $line"
puts "offset  : $offset"

puts "drawing..."
set x 0
set y 0
set hsyncCount 0
set mode "normal"

# read until first vsync
while { [gets $infile line] >= 0 && [string index $line 4] != "1" } {
  incr offset
  # only posedge, skip negedge
  if { [ string index $line 0 ] == "1"} { continue }

    if { $mode == "normal" } {
      # hsync start detected 
      if { [ string index $line 2 ] == "1" } {
        set mode "hsync"
      } else {
        $theImage put [string range $line 6 12]  -to $x $y [expr {$x + 1}] [expr {$y + 1}]
        incr x
      }
    # hsync end detected
    } elseif { [ string index $line 2 ] == "0" } {

        set x 0
        incr y
 

      set mode "normal"
    }
 
}
puts "end"

