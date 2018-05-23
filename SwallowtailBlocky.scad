// OpenSCAD model to print out an arbitrary surface defined as z = f(x,y)
// Either prints the surface as two sided and variable thick = thickness
// Or if thick = 0, prints a top surface with a flat bottom
// File surfaceprint.scad
 
 a = -10;
 b = 1;
 c=1 ;
 xscale = 6;
 zscale=1000;
 center = 30;
function f(x, y) = 40 + (pow((x - center) / xscale, 5) + a * (y - center) * pow((x - center) / xscale, 3) + b * pow((x - center) / xscale, 2) + c * ((x - center) / xscale)) / zscale; // Saddle point 

res = 8;
 
//z height, in mm

thick = 0; //set to 0 for flat bottom. else mm thickness of surface
xmax = 60; //Number of points in x direction - 99 is the max
ymax = 60; // Number of points in y direction - 99 is the max

for(x = [0:res:xmax], y = [0:res:ymax]) translate([x, y, 0]) cube([res + .001, res + .001, f(x, y)]);
