stepsize = .001;
skipsteps = 100;
steps = 20000;
grid = 5;
gridz = 1;

scale = 50;

$fs = .2;

start = [.6, .4];

a = 2/3;
b = 4/3;
c = 1;
d = 1;

axis = [1, 0, 0];

function x(x, y) = x + stepsize * (a * x - b * x * y);
function y(x, y) = y + stepsize * (-c * y + d * x * y);

function xy(step = steps, values = [start]) = (step <= 0) ? values : xy(step - 1, concat([[
		x(values[0][0], values[0][1])
	,
		y(values[0][0], values[0][1])
		]], values));

xy = xy();


*%for(z = [0:skipsteps:len(xy) - 1]) translate([100 * xy[steps - z][0], 100 * xy[steps - z][1], z / skipsteps]) cube(1);


scale(.5) {
	if(axis[0]) {
		*intersection() {
			for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([scale * xy[steps - z][0], -z / skipsteps, scale * xy[steps - z][1]]) sphere(2);
			linear_extrude(steps + 2) translate([0, -200, 0]) square(200);
		}
		for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([0, -z / skipsteps, 0]) cube([scale * xy[steps - z][0], .01, scale * xy[steps - z][1]]);
		*for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([100 * xy[steps - z][0], -z / skipsteps, 0]) cylinder(r = 1, h = 100 * xy[steps - z][1]);
		*linear_extrude(1) hull() for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([100 * xy[steps - z][0], -z / skipsteps, 0]) circle(r = 2);
	}
	if(axis[1]) {
		*intersection() {
			for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([-z / skipsteps, 100 * xy[steps - z][1], 100 * xy[steps - z][0]]) sphere(2);
			linear_extrude(steps + 2) square(1000, center = true);
		}
		for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([-z / skipsteps, 100 * xy[steps - z][1], 0]) cylinder(r = 1, h = 100 * xy[steps - z][0]);
		linear_extrude(1) hull() for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([-z / skipsteps, 100 * xy[steps - z][1], 0]) circle(r = 2);
	}
	if(axis[2]) {
		*intersection() {
			for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([100 * xy[steps - z][0], 100 * xy[steps - z][1], z / skipsteps]) sphere(2);
			linear_extrude(steps + 2) square(1000, center = true);
		}
		
		for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([100 * xy[steps - z][0], 100 * xy[steps - z][1], 0]) cylinder(r = 1, h = z / skipsteps);
		
		*#for(i = [0:skipsteps:len(xy) - 2]) translate([0, 0, i / skipsteps]) linear_extrude(1) for(z = [i:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([100 * xy[steps - z][0], 100 * xy[steps - z][1], z / skipsteps]) circle(1);
	
		*linear_extrude(1) for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([100 * xy[steps - z][0], 100 * xy[steps - z][1], z / skipsteps]) circle(1);
			
		hull() linear_extrude(1) for(z = [0:skipsteps:len(xy) - 2]) hull() for(z = [z, z + skipsteps]) translate([100 * xy[steps - z][0], 100 * xy[steps - z][1], z / skipsteps]) circle(1);
	}
}