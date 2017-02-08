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
    translate( [-(23+6)/2,-26/2,0] ) {
        plate_hole_upside_down();
        translate([25+5,0,0]) plate_hole_normal();
        translate([-25-5,0,0]) plate_hole_normal();
    }
}

plate_hole();