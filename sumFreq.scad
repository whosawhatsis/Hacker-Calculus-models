// Model that sums a set of frequencies
// Rich Cameron 2018-19

sum = false;

// Generates Figure 9.1. Uncomment the following line to genreate Figure 9.2 and 9.3 instead:
//sum = true;

frequencies = [.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10];

range = [-360, 360];

function f(x, y) = cos(x * y) * (cos(30 * x) + 0 * cos(30 * x));

scale([1/7.2, 10, 5])
	for(f = [0:len(frequencies) - 1])
		translate([0, 0, f])
			linear_extrude(1)
				polygon(concat([[range[1], -1], [range[0], -1]], [for(x = [range[0]:2:range[1]]) [x, (sum ? sum(x, f) : cos(x * frequencies[f])) / 10]]));
        
function sum(x, f) = cos(x * frequencies[f]) + ((f > 0) ? sum(x, f - 1) : 0);