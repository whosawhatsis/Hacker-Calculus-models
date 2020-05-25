zscale = 48;
xmax = 64; //Number of points in x direction - 99 is the max
ymax = 64; // Number of points in y direction - 99 is the max
res = .5 * 1 * 1; // For 8 by 8, use 0.5 * 4 * 4; for 128, use 0.5 * 1 * 1

center = [(xmax - res)/2, (ymax - res)/2];
function f(x, y) = (y - center[1]) * pow(x - center[0], 3) / ymax / pow(xmax / 2, 3) * zscale + zscale / 2 + 1;

for(x = [0:res:xmax - res], y = [0:res:ymax - res]) translate([x, y, 0]) cube([res + .001, res + .001, f(x, y)]);
