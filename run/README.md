**After compiling there should be an executable PlanetarySimulator in the folder run/, it is used as follows:**

**Usage:** PlanetarySimulator input_file_1, input_file_2, ..., input_file_n

So it's just the executable followed by the filenames of the input files.
The program will then generate output(s) from the input(s).

**Input file(s):**

Rows 1, 3, 5 and 6 are ignored by the program, don't use them for any values.
All input values should be separated from eachother with either spaces (any amount) or commas.

Row 2 is where the program reads in the units you want to use, but if you don't give it a unit,
it will use the default unit. The units are in order: time, distance, mass, velocity.
The unit of time affects t and dt. The others affect everything below row 6. 
These units will be used whenever the program writes, to screen and to file.

Row 4 is where the program reads N, t, dt, m steps and k steps. N = how many objects, 
t = simulation length, dt = timeskip length, m steps = how often prints, k steps = how often writes.

Below row 6 is where the program reads in the masses and initial positions and velocities,
for N objects. These are read in the order: mass, position(x, y, z), velocity(x, y, z).
