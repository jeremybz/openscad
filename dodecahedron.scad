$fa = 1;
$fs = 0.4;

module dodecahedron(side=30,thickness=2) {
	// regular dodecahedron
	c = side * (1 + sqrt(5)) / 4;  // phi / 2
	r1 = 0;
	r2 = side * (3 + sqrt(5)) / 4;  // (phi + 1) / 2
	r3 = side / 2;
	
	$points=[
			[ r1,  r2,  r3],  //  0: front top
			[ r1,  r2, -r3],  //  1: front bottom
			[  c,   c,  -c],  //  9: bottom front right
			[ r2,  r3,  r1],  // 16: right front
			[  c,   c,   c],  //  8: top front right

			[ r1,  r2,  r3],  //  0: front top
			[ -c,   c,   c],  // 12: top front left
			[-r2,  r3,  r1],  // 18: left front
			[ -c,   c,  -c],  // 13: bottom front left
			[ r1,  r2, -r3],  //  1: front bottom
			[ -c,   c,  -c],  // 13: bottom front left

			[-r3,  r1, -r2],  //  7: bottom left
			[ r3,  r1, -r2],  //  5: bottom right
			[  c,   c,  -c],  //  9: bottom front right
			[ r3,  r1, -r2],  //  5: bottom right

			[  c,  -c,  -c],  // 11: bottom rear right
			[ r2, -r3,  r1],  // 17: right rear
			[ r2,  r3,  r1],  // 16: right front

			[ r2, -r3,  r1],  // 17: right rear
			[  c,  -c,   c],  // 10: top rear right
			[ r3,  r1,  r2],  //  4: top right
			[  c,   c,   c],  //  8: top front right

			[ r3,  r1,  r2],  //  4: top right
			[-r3,  r1,  r2],  //  6: top left
			[ -c,   c,   c],  // 12: top front left

			[-r3,  r1,  r2],  //  6: top left
			[ -c,  -c,   c],  // 14: top rear left
			[-r2, -r3,  r1],  // 19: left rear
			[-r2,  r3,  r1],  // 18: left front

			[-r2, -r3,  r1],  // 19: left rear
			[ -c,  -c,  -c],  // 15: bottom rear left
			[-r3,  r1, -r2],  //  7: bottom left
			[ -c,  -c,  -c],  // 15: bottom rear left

			[ r1, -r2, -r3],  //  3: rear bottom
			[  c,  -c,  -c],  // 11: bottom rear right
			
			[ r1, -r2, -r3],  //  3: rear bottom
			[ r1, -r2,  r3],  //  2: rear top
			[ -c,  -c,   c],  // 14: top rear left
			[ r1, -r2,  r3],  //  2: rear top
			[  c,  -c,   c],  // 10: top rear right

		];
	  for (i = [0: len($points)-2]){
		hull(){
			translate($points[i]) sphere(thickness);
			translate($points[i+1]) sphere(thickness);
		
		}
	 }
 }
dodecahedron();
