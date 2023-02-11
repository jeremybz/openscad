$fa = 1;
$fs = 0.4;

strands=3;
twists=4+(1/strands);
thickness=2;
main_radius=24;
inner_radius=8;
dy=2;

module offset_sphere(i,twists,thickness,offst,inset){
  rotate([i,0,0])
    translate([0,offst])
      rotate([0,0,i*twists])
          translate([inset,0,0])
            sphere(thickness); 
}

module cruller_knot(){
 for ( i=[0:dy:360*strands]) {
   hull(){
     offset_sphere(i,twists,thickness,main_radius,inner_radius);
     offset_sphere(i-dy,twists,thickness,main_radius,inner_radius);
   }
  }
}
cruller_knot();
