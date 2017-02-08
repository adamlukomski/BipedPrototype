hole_quality = 6;

module profile2020_classic( height=60 )
{
        union() {
        difference() {
            cube([20,20,height],center=true);
            cube([16,16,height+1],center=true);
            for( angle=[0, 90, 180, 270] )
                    rotate( [0,0,angle] )
                        translate( [10,0,0] )
                            cube([8,4.5,height+1],center=true);
        }
        difference() {
            cube( [7,7,height], center=true );
            cylinder( d=3.8, h=height+1, center=true, $fn=10 );
        }
        for( angle = [0,90,180,270] )
            rotate( [0,0,45+angle] )
                translate([7.5,0,0])
                    cube( [8,2,height], center=true );
    }
}

module cart_half_simple() {
    length = 60;
    thickness = 11;
    channel_radius = 3.5; // 3.6 is quite loose for the balls (sic!)
    track_radius = 6;
    outside_radius = channel_radius + track_radius + 1.5;
    slot = 2.5;

    inner_quality = 8; // original 6
    angle_quality = 36; // original 24
      difference() {
        translate([0, 0, slot/2-thickness+1.3-5])
        linear_extrude(height=30, convexity=2) {
          difference() {
            translate([-0.5, 0, 0]) minkowski() {
              square([0.1, 0.1+length-2*outside_radius], center=true);
              circle(r=outside_radius-0.05, $fn=36);
            }
            for (y = [2+outside_radius-length/2,
                      length/2-outside_radius-2]) {
              translate([0, y])
                circle(r=1.5, $fn=12);
            }
          }
        }
        translate([-10.5, 0, 12.5]) difference() {
          cube([100, 100, 20], center=true);
          difference() {
            translate([0, 0, -10.5]) rotate([90, 0, 0]) rotate([0, 90, 0])
              cylinder(r=15, h=30, center=true, $fn=8);
            translate([-18, 0, 0]) rotate([0, 30, 0])
              cube([40, 40, 40], center=true);
          }
        }
        translate([10+track_radius, 0, -10-slot/2])
          cube([20, length, 20], center=true);
        translate([10+track_radius, 0, 10+slot/2])
          cube([20, length, 20], center=true);
      }
}

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

module cart() {
    translate([-33/2,0,-13.5]) {
    translate( [0,0,-(2.5/2-11+1.3-5)] ) {
        cart_half_simple(1.5);
        translate([33,0,0]) rotate( [0,0,180] ) cart_half_simple(1.5);
    }
    
    translate([33/2, 0, -6]) cart_plate();
    }
}

module dynamixel_ax12()
{   // simple model, just for placement
    // 40mm x length, 32 y length, 50 z axis
    translate( [ -32/2, -26/2, -(48-11) ] )
    union() {
        cube( [ 32, 26, 48] );
        translate( [32, 26/2, 48-11] ) rotate( [0,90,0] ) cylinder( r=11, h=5 ); // actuator
        translate( [-3, 26/2, 48-11] ) rotate( [0,90,0] ) cylinder( r=5.5, h=3 ); // back bearing
        translate( [32, 3, 4] ) cube( [3,20,23] ); // ax-12 sign plate
        translate( [-3, 3, 4] ) cube( [3,6,7] ); // ax-12 sign plate// plates on each sign of ID number
        translate( [-3, 26-3-6, 4] ) cube( [3,6,7] ); // ax-12 sign plate// plates on each sign of ID number
        
        translate( [0, -3, 0] ) cube( [5,3,33] ); // mount side
        translate( [32-5, -3, 0] ) cube( [5,3,33] ); // mount side
        translate( [0, 26, 0] ) cube( [5,3,33] ); // mount side
        translate( [32-5, 26, 0] ) cube( [5,3,33] ); // mount side
        
        
        translate( [-6+3,0,-5] )
           difference() { // additional bracket
               cube([32+6,26,3]); 
               translate( [14,10,-0.1] )  cube( [10,6,4] );
               // holes
               for( i = [-8,0,8] )
                   for( j= [-8,0,8 ] )
               translate( [38/2+i,26/2+j,2] ) cylinder(r=1.1,h=4.1,center=true,$fn=hole_quality);
           }
            
    }
}

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

module plate_hole_normal() {
    
    hole_quality=10;
    length = 23+5;
    
    
    hole = 2; // M2 = 2, M3 = 3
    difference() {
        union() {
            difference() { // additional bracket
               cube([length+6,26,4]); 
               translate( [1,1,3] ) cube( [(length+6)-2,26-2,1.2] );
               // holes
               for( i = [-8,0,8] )
                   for( j= [-8,0,8 ] )
                   translate( [(length+6)/2+i,26/2+j,2] ) {
                       cylinder(r=1.1,h=4.1,center=true,$fn=hole_quality);
                       translate([0,0,1.1]) rotate( [0,0,90] ) cylinder( r=1.1*hole, h=2,center=true, $fn=6); // hex nut
                   }
            }
            // sides
            
            
            // hex nuts
            translate( [(length+6)/2,26/2,2] ) {
                for( i = [-8,0,8] )
                    for( j= [-8,0,8 ] )
                        translate([i, j, 2]) rotate( [0,0,90] )
                        difference() {
                            translate([0,0,-1]) cylinder( r=1.8*hole, h=2, center=true, $fn=6 );
                            cylinder( r=1.1*hole, h=15,center=true, $fn=6); // hex nut
                        }
            }
        }
        translate( [(length+6-10)/2,9,-0.1] )  cube( [10,8,6] );
    }
}


module plate_hole_upside_down() {
    
    hole_quality=10;
    length = 23+5;
    
    
    hole = 2; // M2 = 2, M3 = 3
    difference() {
        union() {
            difference() { // additional bracket
               cube([length+6,26,4]); 
               translate( [1,1,3] ) cube( [(length+6)-2,26-2,1.2] );
               // holes
               for( i = [-8,0,8] )
                   for( j= [-8,0,8 ] )
                   translate( [(length+6)/2+i,26/2+j,2] ) {
                       cylinder(r=1.1,h=4.1,center=true,$fn=hole_quality);
                       translate([0,0,-1.1]) rotate( [0,0,90] ) cylinder( r=1.1*hole, h=2,center=true, $fn=6); // hex nut
                   }
            }
            // sides
            
            
            // hex nuts
            translate( [(length+6)/2,26/2,2] ) {
                for( i = [-8,0,8] )
                    for( j= [-8,0,8 ] )
                        translate([i, j, 2]) rotate( [0,0,90] )
                        difference() {
                            translate([0,0,-1]) cylinder( r=1.8*hole, h=2, center=true, $fn=6 );
                            cylinder( r=1.1*hole, h=15,center=true, $fn=6); // hex nut
                        }
            }
        }
        translate( [(length+6-10)/2,9,-0.1] )  cube( [10,8,6] );
    }
}

module plate_hole() {
    translate( [-(23+5+6)/2,-26/2,0] ) {
        plate_hole_upside_down();
        translate([25+5,0,0]) plate_hole_normal();
        translate([-25-5,0,0]) plate_hole_normal();
    }
}








space_motors = 5;

slide_margin = 80;


translate( [-slide_margin,0,0] ) profile2020_classic(360);
translate( [-slide_margin-40,0,180-20] ) rotate( [90,0,0] ) {
    profile2020_classic(1000);
    rotate([90,0,-90]) cart();
}
translate( [-slide_margin-40,0,-(180-20)] ) rotate( [90,0,0] ) {
    profile2020_classic(1000);
    rotate([90,0,-90]) cart();
}
//translate( [100,0,0] ) profile2020_classic(360);
//translate( [0,0,360/2+10] ) rotate([0,90,0]) profile2020_classic(200+2*10);

translate([-slide_margin,0,70]) rotate([90,0,-90]) cart();

// measurement motor
translate([0,0,42]) {
//    rotate([180,0,0]) {
        color("cyan") dynamixel_ax12();
        bracket_u();
//    }
}

middle_height = 6;

translate( [0,0,-5] ) plate_hole();

translate( [-60,0,70] ) cube([80,20,10]);

// leg 1
translate([25+space_motors,0,-42-middle_height]) rotate([180,0,0]){
    color("blue") dynamixel_ax12();
    bracket_u();
}
translate([25+space_motors,0,-42-middle_height-42-30]) rotate([180,0,0]){
    color("blue") dynamixel_ax12();
    bracket_u();
}
translate([25+space_motors,0,-42-middle_height-42-30-42-15])
    bracket_u();

// leg 2
translate([-25-space_motors,0,-42-middle_height]) rotate([180,0,0]){
    color("red") dynamixel_ax12();
    bracket_u();
}
translate([-25-space_motors,0,-42-middle_height-42-30]) rotate([180,0,0]){
    color("red") dynamixel_ax12();
    bracket_u();
}
translate([-25-space_motors,0,-42-middle_height-42-30-42-15])
    bracket_u();
