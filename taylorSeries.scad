thick = 1.2;
xyscale = 4;
range = [-4 * PI, 4 * PI];
steps = 20;
clip = 40;

//Taylor series for sin(x)
/*
func = 0;
/**/

//Taylor series for cos(x)
/*
func = 1;
/**/

//Taylor series for e^x
/*
range = [-8, 4];
func = 2;
/**/

xstep = .1;
zstep = 2;

$fs = .2;
$fa = 2;

linear_extrude(zstep * (steps)) intersection() {
	for(x = [range[0]:xstep:range[1]]) hull() for(x = [x, x + xstep]) translate([xyscale * x, xyscale * (func ? (func == 2) ? exp(x) : cos(x * 180 / PI) : sin(x * 180 / PI)), 0]) circle(thick / 2);
	translate([xyscale * range[0], -clip, 0]) square([xyscale * (range[1] - range[0]), clip * 2]);
}

for(i = [0:steps - 1]) linear_extrude((i + 1) * zstep) intersection() {
	translate([xyscale * range[0], -clip, 0]) square([xyscale * (range[1] - range[0]), clip * 2]);
	union() {
		polygon(concat([for(x = [0:xstep:range[1] + xstep]) [xyscale * x, xyscale * (func ? (func == 2) ? series_exp(x, i) : series_cos(x, i) : series_sin(x, i))]], [for(x = [-range[1] - xstep:xstep:xstep]) [xyscale * -x, xyscale * (func ? (func == 2) ? exp(-x) + thick / 2 / xyscale : cos(-x * 180 / PI) - thick / 2 / xyscale * pow(-1, i) : sin(-x * 180 / PI) - thick / 2 / xyscale * pow(-1, i))]]));
		if(range[0] < 0) polygon(concat([for(x = [.0001:xstep:-range[0] + xstep]) [xyscale * -x, xyscale * (func ? (func == 2) ? series_exp(-x, i) : series_cos(-x, i) : series_sin(-x, i))]], [for(x = [range[0] - xstep:xstep:xstep]) [xyscale * x, xyscale * (func ? (func == 2) ? exp(x) + thick / 2 / xyscale * ((i % 2) ? 1 : -1) : cos(x * 180 / PI) - thick / 2 / xyscale * pow(-1, i) : sin(x * 180 / PI) + thick / 2 / xyscale * pow(-1, i))]]));
	}
}

//!for(i = [0:steps - 1], x = [range[0]:xstep:range[1]]) hull() for(x = [x, x + xstep]) translate([xyscale * x, xyscale * (func ? (func == 2) ? series_exp(x / PI, i) : cos(x * 180 / PI) : sin(x * 180 / PI)), 0]) circle(thick / 2);

function fact(n) = n ? n * fact(n - 1) : 1;

function series_sin(x, n) = pow(-1, n) * pow(x, n * 2 + 1) / fact(n * 2 + 1) + (n ? series_sin(x, n - 1) : 0);
function series_cos(x, n) = pow(-1, n) * pow(x, n * 2) / fact(n * 2) + (n ? series_cos(x, n - 1) : 0);
function series_exp(x, n) = pow(x, n) / fact(n) + (n ? series_exp(x, n - 1) : 0);

