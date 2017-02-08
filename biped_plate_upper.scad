module cart_plate() {
    h = 6;
    plate_outside_radius = 13;
    plate_separation = 4+29;
    plate_spacing = 25+9;
  difference() {
    linear_extrude(height=h) difference() {
    minkowski() {
      square([0.1+plate_separation, 0.1+plate_spacing], center=true);
      circle(r=plate_outside_radius-0.05, $fn=36);
    }
    } //diff
    // holes
    for (y = [-16/2, 16/2]) {
      for (x = [-21/2, 21/2]) {
        translate([x, y, -1])
          cylinder(r=1.5,h=10, $fn=12);
      }
    } //for
    // hex nuts
    for (y = [-16/2, 16/2]) {
      for (x = [-21/2, 21/2]) {
          translate([x, y, 2])
        cylinder(r=3.3, h=15, $fn=6); // with 3.2 hole I had to hammer the nuts into them
      }
    } //for
  } //diff
} //module


module bracket_u() {
    // 
    rotate([0,0,90]) translate([-25/2,-38/2,(8+11)]) union() {
        difference() { // main plate
            cube( [25,38,7] ); // plate
            translate([9,14,-0.1]) cube( [7,10,8] ); // middle rect hole
        }
        // side 1
        translate([0,-5.5,-8]) cube([25,5.5,2+8]);
        translate([1.5,-5.5,-19]) cube([22,3,11]);
        translate([25/2,-5.5+3,-8-11]) rotate( [90,0,0] ) cylinder(r=11,h=3);
        // side 2
        translate( [25,38,0] ) rotate([0,0,180]) {
            translate([0,-5.5,-8]) cube([25,5.5,2+8]);
            translate([1.5,-5.5,-19]) cube([22,3,11]);
            translate([25/2,-5.5+3,-8-11]) rotate( [90,0,0] ) cylinder(r=11,h=3);
        }
    }
}

//translate( [-63,0,20+5] ) rotate( [90,0,-90] )  cart_plate();

//translate( [0,0,-26-3] ) bracket_u();

size_y = 40;
size_z = 10;
size_x = 80;

vert_x = 21-6; 
vert_z = 45;
translate( [-60,-size_y/2,0] ) {
   union() {
        // ------ main plate -----
        difference() {
            cube([size_x,size_y,size_z]);
            
            hole_quality=10;
        //    length = 23+5;
            hole = 2; // M2 = 2, M3 = 3
            // hex nuts
            translate( [size_x-12,size_y/2,size_z-2] ) {
                for( i = [-24,-16,-8,0,8] )
                    for( j= [-8,0,8 ] )
                        translate([i, j, 2]) rotate( [0,0,90] )
                        {
                            translate([0,0,-0.5]) cylinder( r=2*hole, h=1.1, center=true, $fn=6 );
                            translate([0,0,-1]) cylinder( r=1.3*hole, h=2.2,center=true, $fn=6); // hex nut
                            translate([0,0,-size_z/2]) cylinder(r=1.1,h=size_z+0.2,center=true,$fn=hole_quality);
                        }
            }
        } // diff
        
        // vertical plate
        difference() {
            cube([vert_x,size_y,vert_z]);
            for (y = [-16/2, 16/2]) {
                for (x = [-21/2, 21/2]) {
                    translate([-1, size_y/2+x, vert_z/2+y])
                        rotate( [0,90,0] ) cylinder(r=1.5,h=vert_x+2, $fn=12);
                }
            } //for
        }
        
        difference() {
            union() {
            cube( [size_x, 5, vert_z] );
            translate([0,size_y-5,0]) cube( [size_x, 5, vert_z] );
            }
            translate( [0+5, -1, vert_z] ) rotate( [0,10,0] ) cube( [size_x,size_y+2,20] );
        }
        // ------- side supports ------
        
    
    } // union
}





























