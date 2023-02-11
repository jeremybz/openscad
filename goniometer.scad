$fa = 1;
$fs = 0.4;
width=3;
protractor_radius=30;
height=20;
letter_depth=3;
letter_size=1;
font="Roboto Mono";
bumper_side=10;
tube_radius=3;
tube_width=2;
tube_length=20;

module annulus(height,inner_radius,width){
	difference(){
		cylinder(h=height,r=inner_radius+width,center=true);
		cylinder(h=2*height,r=inner_radius,center=true);

	}
}
module arced_vertical_lines(height,width,radius,angle,dy=5,every=5,every_other=10){
	for ( i=[dy:dy:angle-dy]) {		
		rotate([0,0,i])
			translate([radius,0,0])
				if ( i % every_other == 0 ){
					cube([2*width,width,height],center=true);
				}else if ( i % every == 0 ){
					cube([2*width,width,height*0.8],center=true);
				}else{
					cube([2*width,width,height*0.6],center=true);
				}
	}
}
module letter(l) {
	linear_extrude(height = letter_depth) {
		text(l, size=letter_size, font=font, halign="center", valign="bottom", $fn=16);
	}
}
module arced_angle_numbers(radius,angle,dy=5,every=15){
	for ( i=[every:every:angle-every]) {	
		rotate([0,0,i])
			translate([radius,0,0])
				rotate([90,0,270])
					// half the value because angles
					letter(str(abs((90-i)/2)));
	}
}
module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

//protractor
difference(){
	annulus(height,protractor_radius,width);
	translate([-1.5*(protractor_radius+width),0,height/-1])
		cube([3*(protractor_radius+width),2*(protractor_radius+width),2*height]);
        // lines
	rotate([0,0,180])
		arced_vertical_lines(height/1.5,0.2,protractor_radius,180,1,5,10);
        // top numbers
	translate([0,0,height*3/8])
		rotate([0,0,180])
			arced_angle_numbers(protractor_radius,180,5,10);
        // bottom numbers
	translate([0,0,height*-3/8])
		rotate([0,0,180])
		rotate([0,180,0])
			arced_angle_numbers(protractor_radius,180,5,10);
}

// platform with bumpers and hole
difference(){
	union(){
		// platform
		translate([-1*(width+protractor_radius),0,height/-2])
			cube([2*(protractor_radius+width),width,height]);

		// bumpers
		translate([sqrt(2*bumper_side)/2,-1*(sqrt(2*bumper_side)/2),height/-2])
			rotate([90,0,0])
				rotate([0,135,0])
					prism(height, sqrt(bumper_side),sqrt(bumper_side));
		translate([sqrt(2*bumper_side)/-2,-1*(sqrt(2*bumper_side)/2),height/-2])
			rotate([90,0,0])
				rotate([0,135,0])
					prism(height, sqrt(bumper_side),sqrt(bumper_side));
	}
	// hole in bumpers
	rotate([90,0,0])
		cylinder(h=width*5,r=tube_radius/2,center=true);
}
// laser tube
translate([0,tube_length/2,0])
	rotate([90,0,0])
		annulus(tube_length,tube_radius,tube_width);
// tube support
difference(){
	translate([0,tube_length/2,0])
		cube([tube_width,tube_length,height],center=true);
	rotate([90,0,0])
	//translate([0,tube_length/2,0])
	cylinder(h=3*tube_length,r=tube_radius,center=true);
}
