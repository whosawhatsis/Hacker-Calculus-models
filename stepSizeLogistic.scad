// Solves the logistic equation  
// Rich Cameron, adapted Joan Horvath, December 2019 

a = 0.2; //exponential decay factor 
w = 5; //width in y direction of each iteration
offset = 25; // height in millimeters for f(x,step) = 0
K = 50; //carrying capacity 
 
// h = step in x direction - varied as a parameter
// f(x) is assumed to be the logistics function 
// And assumed to start at f(0) = 1. 

for(i = [1:13]) translate([0, i * w, 0]) f(h = i);

module f(i = 0,  h, start = 1, end= 2*3*4*3) {
	cube([h, w, start + offset]);
	if (i < (end - h) )
        translate([h, 0, 0]) 
       f( i + h, h, start *(1 + h*a) - h * a * start*start / K, end);
}