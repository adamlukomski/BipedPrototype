module doubleT( length ) {
    // a double-T profile (letter H)
    // if you see the profile as letter T (double-T) in front of you:
    dim_A1 = 2; // fatness of upper line in T
    dim_A2 = 1.25; // fatness of verical line in T
    dim_B = 8.8; // height of T
    dim_C = 20; // width of upper line in T
    
    translate( [ -dim_C/2, -dim_B/2, 0 ] ) union() {
        cube( [ dim_C, dim_A1, length ] );
        translate( [dim_C/2-dim_A2/2,0,0] ) cube( [ dim_A2, dim_B, length ] );
        translate( [0,dim_B-dim_A1,0] ) cube( [ dim_C, dim_A1, length ] );
    }
}

module plate1() {
    
    // main plate
    
    size_x = 50;
    size_y = 50;
    size_z = 10;
    screw = 4;
    
    profile_y = 20;
    profile_z = 8.8;
    
    difference() {
        // plate
        cube( [size_x,size_y,size_z] );
        // screw holes
        for( x=[7,size_x-7] )
            for( y=[7,size_y-7] ) {
                translate([x,y,size_z/2]) cylinder( r=screw/2+0.1, h=size_z+0.4,center=true );
                translate([x,y,-0.1]) cylinder( r=8/2, h=3, $fn=6 ); // hex nut
            }
        // main shaft for aluminium profile
        translate([-0.2,(size_y-profile_y-1)/2,size_z-profile_z/2-2]) cube( [size_x+0.4, profile_y+1, profile_z] );
    }
}

//translate( [0,0,40]) rotate([180,0,90]) plate1();
//translate( [0,50,25]) rotate([180,0,0]) plate1();
plate1();