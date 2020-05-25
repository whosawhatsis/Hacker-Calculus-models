xmin = 0;
xmax = 7;
step = (xmax - xmin) / 100;

c = 0;
c = f(xmin);

xunit = 10;
thick = 1.5;

openwidth = 10;

xmark = .2;


function f(x) = sin(x * 180 / PI) * 5 + x * 8;
function d(x) = cos(x * 180 / PI) * 5 + 8;


x = [for(x = [xmin:step:xmax + step / 2]) x];
integral = integrate([for(x = x) d(x) * step], c);
	
$fs = .2;
$fa = 2;

translate([0, 0, 0 * xunit * xmax]) rotate([0, -90, 0]) {
	difference() {
		union() {
			linear_extrude(thick, center = true, convexity = 10) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, f(x)]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
			rotate([90, 0, 0]) translate([0, 0, openwidth / 2]) linear_extrude(thick + openwidth, center = true, convexity = 10) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, d(x) + thick/2]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
		rotate([0, 90, 0]) hull() for(i = [0, 1]) translate([0, i * -openwidth, xmin * xunit]) cylinder(r = thick / 2, h = (xmax - xmin) * xunit);
		}
		if(ceil(xmin + step) < (xmax - step)) for(x = [ceil(xmin):xmax - step]) translate([x * xunit, 0, 0]) cube([1, 1000, 1000], center = true);
	}
		
	#%translate([0, 0, xmark / 2]) linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(i = [0:len(x) - 1]) [x[i] * xunit, integral[i]]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
	#%rotate([90, 0, 0]) translate([0, 0, -xmark / 2]) linear_extrude(thick, center = true) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, ((f(x) - f(x - step)) + (f(x + step) - f(x))) / 2 / step]], [[xmax * xunit, 0], [xmin * xunit, 0]]));
		
	if(ceil(xmin + step) < (xmax - step)) 
		intersection() {
		union() {
			translate([0, 0, xmark]) linear_extrude(thick, center = true, convexity = 10) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, f(x)]], [[max(x) * xunit, 0], [min(x) * xunit, 0]]));
			rotate([90, 0, 0]) translate([0, 0, -xmark + openwidth / 2]) linear_extrude(thick + openwidth, center = true, convexity = 10) offset(xmax / 1000) offset(-xmax / 1000) polygon(concat([for(x = x) [x * xunit, d(x) + thick / 2]], [[max(x) * xunit, 0], [min(x) * xunit, 0]]));
			rotate([0, 90, 0]) hull() for(i = [0, 1]) translate([-xmark, xmark + i * -openwidth, xmin * xunit]) cylinder(r = thick / 2, h = (xmax - xmin) * xunit);
		}
		for(x = [ceil(xmin + step):xmax - step]) translate([x * xunit, 0, 0]) cube([1, 1000, 1000], center = true);
	}
}

function integrate(v, c = 0, sum = []) = (len(v) == len(sum)) ? sum : integrate(v, c, concat(sum, [len(sum) ? sum[len(sum) - 1] + v[len(sum)] : v[0] + c]));