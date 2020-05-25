zmax = 100;
step = .1;


function x(z) = 10 * cos(z * 10) + 20;
function y(z) = .01 * pow(z - 50, 2) + 10;

intersection() {
	rotate([0, -90, 0]) linear_extrude(1000, convexity = 5) polygon(concat([[zmax, 0], [0, 0]], [for(z = [0:step:zmax]) [z, x(z)]]));
	rotate([0, -90, 90]) mirror([0, 0, 1]) linear_extrude(1000, convexity = 5) polygon(concat([[zmax, 0], [0, 0]], [for(z = [0:step:zmax]) [z, y(z)]]));
}