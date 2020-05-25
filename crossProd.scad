// Prints cross-products of a pair of vectors 
// Rich Cameron, 2019
// Prints cross-products  v x w
// "v" is a little lower than w

$fs = .2;
$fa = 2;
angle = 120;  // angle between vectors, degrees
width = 3;

hull() {
    translate([0, -width/2, 0]) cube([60, width, 1]);
    rotate([0,0,angle]) translate([0, -width/2, 0]) cube([60, width, 1]);
 }

translate([0, -width/2, 0]) cube([60, width, 7]);
rotate([0,0,angle]) translate([0, -width/2, 0]) cube([60, width, 9]);

// height of the cross-product 
 
cylinder(r=4, h=60*sin(angle));