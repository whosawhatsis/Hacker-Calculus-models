// This file has the surface plots for chapters 3, 4, 6, 8 and 10. 
//You may need to adjust
// the limits (the variables in the range array) for a good print. 
// In all cases the parameter variation is in the y direction, and f(x,y) is what
// would be printed for one parameter value in a 2D traditional graph
// OpenSCAD overwrites functions so just have the one you want be the last 
// version of f(x,y) in the file Note that catenaries use 2 functions. 
// Based on TriangularSurfaceModel
// Rich Cameron modified by Joan Horvath 2018
// Updated Rich Cameron 11/2019

t = 0; //Thickness along z axis. t = 0 gives a flat base at z = 0
range = [90, 90]; //Range of [x, y] values to graph. Also controls those dimensions of the exported model.
res = 1; //Surface resolution in mm. Higher numbers produce a smoother surface, but take longer to generate.
originmarker = 0; //radius of an octahedral cutout placed at [0, 0, 0] to mark the origin. Set to zero to disable.

//Surface for limits in Chapter 1
/*
t = 2.4;
zscale = 48;
range = [64, 64];
xunit = 1;
center = [range[0]/2, range[1]/2];
function f(x, y) = (y - center[1]) * pow(x - center[0], 3) / range[1] / pow(range[0] / 2, 3) * zscale + zscale / 2 + 1;
/**/

//Surface for partial derivatives in Chapter 3
/*
range = [80, 100];
xunit = 20;
function f(x, y = 80) = xunit * -cos(x * 180 / PI / xunit) * sin(y * 180 / PI / xunit) + xunit * 1.5;
/**/

//Figure 4-12: 
/*
range = [60, 30];
function f(x, y) = x * y / 30;
/**/

//Use these functions for plots of logistics eqn surface in Chapter 6 
/*
Pzero = 1;
a = 0.2; //rate
function f(x, y) = (y + 10) / (1 + ((y + 10) / Pzero - 1) * exp(-a * x));
/**/

//Use this function for plot of exponential fn surface in Chapter 6. 
/*
 range = [60,60];
function f(x, y) = 30 * exp((x - 30) * (y - 30) / (30 * 30));
/**/

//Use this function for plot of Simple Harmonic motion in Chapter 8. In this case, y = spring constant/the mass. 
/*
function f(x, y) = 10 + 3 * sin(6 * x * sqrt(y / 8));
/**/

//Use this function to try out catenaries in Chapter 8. Note that it is critical that the scaling of x and f(x,y) be the same as each other. Otherwise curve is distorted.
/*
function cosh(x) = (exp(x) + exp(-x)) / 2;
function f(x, y) = ((y + 10)) * cosh((x - 30) / (y + 10));
/**/

//Use this function for a (scaled by 100) Gaussian. We did not include the probability function of 1/sqrt(2 pi). 
/*
function f(x, y) = 100 * (2 / (y + 5)) * exp(-pow((2 * (x - 30) / (y + 5)), 2));
/**/

//Use this function for  cos(a+b) or
// sin(a+b) experiments.Change cos to sin
// for sine equivalent. 
 /*
function f(x, y) = 10 * cos(4 * (x + y)) + 11.2;
/**/


s = [round((range[0] - res/2) / res), round(range[1] / res * 2 / sqrt(3))];
seg = [range[0] / (s[0] - .5), range[1] / s[1]];

function r(x, y, cx = range[0]/2, cy = range[1]/2) = sqrt(pow(cx - x, 2) + pow(cy - y, 2));
function theta(x, y, cx = range[0]/2, cy = range[1]/2) = atan2((cy - y), (cx - x));
function zeronan(n) = (n == n) ? n : 0;

points = concat(
	[for(y = [0:s[1]], x = [0:s[0]]) [
		seg[0] * min(max(x - (y % 2) * .5, 0), s[0] - .5),
		seg[1] * y,
		zeronan(f(seg[0] * min(max(x - (y % 2) * .5, 0), s[0] - .5), seg[1] * y))
	]], [for(y = [0:s[1]], x = [0:s[0]]) [
		seg[0] * min(max(x - (y % 2) * .5, 0), s[0] - .5),
		seg[1] * y,
		t ? zeronan(f(seg[0] * min(max(x - (y % 2) * .5, 0), s[0] - .5), seg[1] * y)) - t : 0
	]]
);
*for(i = points) translate(i) cube(.1, center = true);
	
function order(point, reverse) = [for(i = [0:2]) point[reverse ? 2 - i : i]];
function mirror(points, offset) = [for(i = [0, 1], point = points) order(point + (i ? [0, 0, 0] : [offset, offset, offset]), i)];

polys = concat(
	mirror(concat([
		for(x = [0:s[0] - 1], y = [0:s[1] - 1]) [
			x + (s[0] + 1) * y,
			x + 1 + (s[0] + 1) * y,
			x + 1 - (y % 2) + (s[0] + 1) * (y + 1)
		]
	], [
		for(x = [0:s[0] - 1], y = [0:s[1] - 1]) [
			x + (y % 2) + (s[0] + 1) * y,
			x + 1 + (s[0] + 1) * (y + 1),
			x + (s[0] + 1) * (y + 1)
		]
	]), len(points) / 2),
	mirror([for(x = [0:s[0] - 1], i = [0, 1]) order([
		x + (i ? 0 : 1 + len(points) / 2),
		x + 1,
		x + len(points) / 2
	], i)], len(points) / 2 - s[0] - 1),
	mirror([for(y = [0:s[1] - 1], i = [0, 1]) order([
		y * (s[0] + 1) + (i ? 0 : (s[0] + 1) + len(points) / 2),
		y * (s[0] + 1) + (s[0] + 1),
		y * (s[0] + 1) + len(points) / 2
	], 1 - i)], s[0])
);

//echo(points);

difference() {
	polyhedron(points, polys, convexity = 5);
	if(originmarker) hull() for(i = [0, 1]) mirror([0, 0, i]) cylinder(r1 = originmarker, r2 = 0, h = originmarker, $fn = 4);
}