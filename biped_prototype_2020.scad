use <aluminium_2020.scad>;

width = 7;

//translate([0,0,0]) profile2020( 60 );
//translate([20,-40,-10]) rotate([-90,0,0]) profile2020( 80 );

translate( [10,-10,0] )
    difference() {
        cube([width,20,40]);
        translate([-1,10,15]) rotate( [0,90,0] ) cylinder(r=2.4,h=20,$fn=12);
        translate([-1,10,30]) rotate( [0,90,0] ) cylinder(r=2.4,h=20,$fn=12);
}
translate( [10,-30,0] ) 
    difference() {
    cube([20,60,width]);
    translate([10,7,-1]) cylinder(r=2.4,h=20,$fn=12);
    translate([10,60-7,-1]) cylinder(r=2.4,h=20,$fn=12);
}

translate( [10,-10-width,0] )
    difference() {
        cube([20,width,40]);
        translate([7,-1,40]) rotate([0,60,0]) cube([40,10,20]);
}

translate( [10,10,0] )
    difference() {
        cube([20,width,40]);
        translate([7,-1,40]) rotate([0,60,0]) cube([40,10,20]);
}

//translate([20,0,-7]) rotate([0,0,90]) translate( [10,10,0] )
//    difference() {
//        cube([20,width,40]);
//        translate([7,-1,40]) rotate([0,60,0]) cube([40,10,20]);
//}
//
//mirror([0,1,0]) translate([20,0,-7]) rotate([0,0,90]) translate( [10,10,0] )
//    difference() {
//        cube([20,width,40]);
//        translate([7,-1,40]) rotate([0,60,0]) cube([40,10,20]);
//}

//translate( [30,-30,-7] ) cube([7,60,14]);