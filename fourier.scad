// Model to visualize Fourier transform processes
// Rich Cameron 2018-2019
zoffset = 10;
oversample = 1;
max_f = 10;
bar = [.5, 3];
base = 2.4;
zeroline = 1.2;
imaginary = false; // change to true to print imaginary part 
fsize = 10;
// in what follows, everything is assumed to be a cosine
// use a phase offset of -90 (degrees) to get a sine
// OpenSCAD uses degrees 

// Figure 9.6 and 9.7:
//frequencies = [[1, 1, 0]]; // [frequency, amplitude, phase offset]

// Figure 9.8:
//frequencies = [[2, 1, 0], [3, 2, 0]]; // [frequency, amplitude, phase offset]

// Figure 9.9:
//frequencies = [[3, 1.5, 0], [7, 1.5, 0]]; // [frequency, amplitude, phase offset]

// Figure 9.10:
//frequencies = [[2, 1, 0], [3, 4, -90]]; // [frequency, amplitude, phase offset]

// Figure 9.11:
//frequencies = [[2, 1, 0], [3, 4, 60]]; // [frequency, amplitude, phase offset]


function wave(x, frequency = 0) = frequencies[frequency][1] * cos((frequencies[frequency][0] * (x - 180) + frequencies[frequency][2])) + ((frequency < len(frequencies) - 1) ? wave(x, frequency + 1) : 0);

function f(x, y, i = imaginary) = (i ? sinfilter(x, y) : cosfilter(x, y)) * wave(x) + zoffset;

function cosfilter(x, y) = cos((x - 180) * y);
function sinfilter(x, y) = sin((x - 180) * y);

res = 2;

function sumx(y, i = 0, start = 0, increment = 1, end = 360 * oversample) = (f(start, y, i) - zoffset) / oversample * increment + ((start < end - increment) ? sumx(y, i, start + increment, increment, end) : 0);

for(y = [0:1 / oversample:max_f - 1]) translate([0, fsize * y, 0]) mirror([0, -1, 1]) linear_extrude(fsize / oversample) polygon(concat([[fsize * max_f, 0], [0, 0]], [for(x = [0:360]) [x / 3.6, f(x, y, imaginary)]]));
for(y = [1 / oversample:1 / oversample:max_f - 1]) translate([0, fsize * y - zeroline / 2, 0]) cube([100, zeroline, zoffset]);

for(y = [1 / oversample:1 / oversample:max_f - 1]) hull() {
	linear_extrude(base) mirror([1, 0, 0]) translate([0, fsize * y, 0]) square([abs(sumx(y, imaginary)) / 25, fsize / oversample]);
	linear_extrude(base + bar[1]) mirror([1, 0, 0]) translate([0, fsize * y + bar[1], 0]) square([abs(sumx(y, imaginary)) / 25, fsize / oversample - (bar[1]) * 2]);
}
for(y = [1 / oversample:1 / oversample:max_f - 1]) hull() {
	linear_extrude(base) mirror([1, 0, 0]) translate([0, fsize * y + fsize / oversample / 4, 0]) square([sqrt(pow(sumx(y, 0), 2) + pow(sumx(y, 1), 2)) / 25, fsize / oversample / 2]);
	linear_extrude(base + bar[0]) mirror([1, 0, 0]) translate([0, fsize * y + fsize / oversample / 4 + bar[0], 0]) square([sqrt(pow(sumx(y, 0), 2) + pow(sumx(y, 1), 2)) / 25, fsize / oversample / 2 - (bar[0]) * 2]);
}
*linear_extrude(base + bar) for(y = [1 / oversample:1 / oversample:max_f - 1]) mirror([1, 0, 0]) translate([0, fsize * y, 0]) square([sqrt(pow(sumx(y, 0), 2) + pow(sumx(y, 1), 2)) / 25, fsize / oversample]);
if(base) linear_extrude(base) for(y = [0:1 / oversample:max_f]) mirror([1, 0, 0]) square([sqrt(pow(sumx(y, 0), 2) + pow(sumx(y, 1), 2)) / 25, max_f * fsize]);