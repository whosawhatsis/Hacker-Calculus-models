// Derivative and integral right-angle plots
// Rich (Whosawhatsis) Cameron
// Last update Nov. 19, 2019 (JH) to update figure numbers
// Dec 2, 2019 JH to add in ch 3 partial derivative figures 
// Dec 2, 2019 RC to add ability to retain x and y variable names in fn call 

xmin = 0;
xmax = 2;
step = (xmax - xmin) / 100;

xunit = 100 / (xmax - xmin); //scale of x axis in mm
thick = 2.4;

c = 0; // integral offset
// To match exactly, set c = f(xmin)

xmark = .2;

//Figure 2.5 
/*
function f(x) = xunit * pow(x, 2) / 2;
function d(x) = xunit * x;
/*/

//Figure 2.7 
 /*
xmax = PI * 2.25;
function f(x) = xunit * sin(x * 180 / PI);
function d(x) = xunit * cos(x * 180 / PI);
/**/

//Figure 2.9a
/*
xmin = -1;
xmax = 1;
function f(x) = xunit * .5 * exp(x / 2);
function d(x) = xunit * .5 * exp(x / 2) / 2;
/**/

//Figure 2.9b 
/*
xmin = -1;
xmax = 1;
function f(x) = xunit * .5 * exp(x);
function d(x) = xunit * .5 * exp(x);
/**/

//Figure 3.2 
/*
xmin = -3;
function f(x) = xunit * (pow(x, 2) / 2 - 4.5);
function d(x) = xunit * x;
/**/

//Figure 3.3 updated 11/2019
/*
xmin = -3;
xmax = 5;
function f(x) = xunit *(pow(x, 3) / 12 - x);
function d(x) = xunit * (pow(x, 2) / 4 - 1);
/**/

 //Figure 3.4 updated 11/2019
 /*
xmin = -3;
xmax = 5;
function f(x) = xunit * (pow(x, 2) / 4 - 1);
function d(x) = xunit *  pow(x, 1)/2;
/*/

 
//Note that the next 3 models include a reference surface
//Be certain that the reference surface .stl file is named
//consistently to be able to see it 
// Surface is reference only. Visible in preview, but will not be part of .stl
// This code only understands df/dx, so x and y variables are flipped on
//function call to take df/dy

//Figure 3-11a, x = 0 (note that order of x and y reversed on fn call)
/*
xmax = 5;
xunit = 20;
c = f(xmin);
function f(y, x = 0) = xunit * -cos(x * 180 / PI) * sin(y * 180 / PI) + xunit * 1.5;
function d(y, x = 0) = xunit * -cos(x * 180 / PI) * cos(y * 180 / PI);
%translate([0, 0, 100]) rotate([-90, 0, 0]) import("../Chapter3/Fig3-11surface.stl");
/**/

//Figure 3-11b, x = 4 (note that order of x and y reversed on fn call)
 /*
xmax = 5;
xunit = 20;
c = f(xmin);
function f(y, x = 4) = xunit * -cos(x * 180 / PI) * sin(y * 180 / PI) + xunit * 1.5;
function d(y, x = 4) = xunit * -cos(x * 180 / PI) * cos(y * 180 / PI);
%translate([-80, 0, 100]) rotate([-90, 0, 0]) import("../Chapter3/Fig3-11surface.stl");
/**/

//Figure 3-11c, y = 5 
 
xmax = 4;
xunit = 20;
c = f(xmin);
function f(x, y = 5) = xunit * -cos(x * 180 / PI) * sin(y * 180 / PI) + xunit * 1.5;
function d(x, y = 5) = xunit * sin(x * 180 / PI) * sin(y * 180 / PI);
%translate([100, 0, 80]) rotate([0, 90, 90]) import("../Chapter3/Fig3-11surface.stl");
/**/

//Figure 4.1 
/*
function f(x) = xunit * pow(x, 2) / 2;
function d(x) = xunit * x;
/**/

//Figure 4.2 
/*
xmin = -3;
function f(x) = xunit * (pow(x, 2) / 2 - 4.5);
function d(x) = xunit * x;
/**/

// Other experiments used in development of chapters


/*
function f(x) = .5 * (pow(((x-5)), 3) + 126);
function d(x) = .5 * (3 * pow(((x-5)), 2));
/*
function f(x) = 25 * (pow(((x)), 2)) + 0;
function d(x) = 25 * (2 * pow(((x)), 1));

function f(x) = 10 * ln(x);
function d(x) = 10 * 1/x;

function f(x) = 5 * (pow(x,3) + 2*x);
function d(x) = 5* (3*pow(x,2) + 2);

function f(x) = 25 * (pow(((x)), 2)) + 0;
function d(x) = 25 * (2 * pow(((x)), 1));

function f(x) = sin(x*180  / PI) * 25;
function d(x) = cos(x * 180 / PI) * 25;

function f(x) =  exp(2*x);
function d(x) = 2*exp(2*x); 

function f(x) = 25 * (pow(((x)), 2)) + 0;
function d(x) = 25 * (2 * pow(((x)), 1));

//Next 4 lines: Case A, Chapter 3
function f(x) = (xunit/3)* ( (1/3)* pow(x, 3) - 4*x);
function d(x) = (xunit/3) * ( pow(x, 2) - 4);

function f(x) =  (xunit/3) * ( pow(x, 2) - 2);
function d(x) = (xunit/3) * 2*x;

 

// These next two are for Chapter 3 discussion of inflection points
// xmin, xmax = +/-1.8

  
function f(x) =  xunit * (pow(x, 3) / 6 - x - .5);
function d(x) =  xunit * (pow(x, 2) / 2 - 1);
 

// Chapter 4 example, x vs x^2 use xmax = 2, xmin = -3
function f(x) =  xunit * (pow(x, 2) / 2 -4.5);
function d(x) = xunit * x;

// Chapter 4 example, x vs x^2 use xmax = 2 xmin = 0
function f(x) =  xunit * (pow(x, 2) / 2 );
function d(x) = xunit * x;
*/













x = [for(x = [xmin:step:xmax + step / 2]) x];
integral = integrate([for(x = x) d(x) * step], c);
	
$fs = .2;
$fa = 2;

translate([0, 0, xunit * xmax]) rotate([0, 90 ,0]) {
	difference() {
		union() {
			linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, f(x)]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
			rotate([90, 0, 0]) linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, d(x)]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
		rotate([0, 90, 0]) translate([0, 0, xmin * xunit]) cylinder(r = thick / 2, h = (xmax - xmin) * xunit);
		}
		if(ceil(xmin + step) < (xmax - step)) for(x = [ceil(xmin):xmax - step]) translate([x * xunit, 0, 0]) cube([1, 1000, 1000], center = true);
	}
		
	#%translate([0, 0, xmark / 2]) linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(i = [0:len(x) - 1]) [x[i] * xunit, integral[i]]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
	#%rotate([90, 0, 0]) translate([0, 0, -xmark / 2]) linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, ((f(x) - f(x - step)) + (f(x + step) - f(x))) / 2 / step]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
		
	if(ceil(xmin + step) < (xmax - step)) 
		intersection() {
		union() {
			translate([0, 0, xmark]) linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, f(x)]], [[max(x) * xunit, 0], [min(x) * xunit, 0]]));
			rotate([90, 0, 0]) translate([0, 0, -xmark]) linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, d(x)]], [[max(x) * xunit, 0], [min(x) * xunit, 0]]));
			rotate([0, 90, 0]) translate([-xmark, xmark, xmin * xunit]) cylinder(r = thick / 2, h = (xmax - xmin) * xunit);
		}
		for(x = [ceil(xmin + step):xmax - step]) translate([x * xunit, 0, 0]) cube([1, 1000, 1000], center = true);
	}
}

function integrate(v, c = 0, sum = []) = (len(v) == len(sum)) ? sum : integrate(v, c, concat(sum, [len(sum) ? sum[len(sum) - 1] + v[len(sum)] : v[0] + c]));