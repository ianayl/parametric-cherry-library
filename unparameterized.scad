$fn = 50;

// thickness of the lofts used
LOFT_THICKNESS = 0.001; // this level of detail is indiscernable to a 3d printer

// Generate a square plane with rounded edges
module roundSquare(corner_r, hor_len, ver_len) {

    hull() {
        translate([corner_r, corner_r, 0]) {
            cylinder(h = LOFT_THICKNESS, r = corner_r);
            translate([0, ver_len - corner_r * 2, 0]) {
                cylinder(h = LOFT_THICKNESS, r = corner_r);
            }

            translate([hor_len - corner_r * 2, 0, 0]) {
                cylinder(h = LOFT_THICKNESS, r = corner_r);
                translate([0, ver_len - corner_r * 2, 0]) {
                    cylinder(h = LOFT_THICKNESS, r = corner_r);
                }
            }
        }
    }

}



// keycap top radius: 1.75 / 2 = 0.875
// roundSquare(1.75, 12.75, 14.75);

// row 4

// r4 keycap height: 9.5
//           backside offset: 0.25
//           topside offset: 2.625
//           top vertical length: 14.75
//           top horizontal length: 12.75
//           top face vertical offset: 3
//           scuplt angle: 11 degrees
//           sculpt curve cup radius: 64/2 = 32

difference() {
    hull() {
        // 0.25
        roundSquare(0.25,18,18);
        
        // todo: - figure out the weird ledge
        //       - make the top cube rounded
        translate([2.625,3,9.5]) {
            rotate(a = -11, v = [1, 0, 0]) {
                roundSquare(0.875, 12.75, 14.75);
            }
        }
    }
    
    // cup indent size: 0.75mm
    translate([9, 3 + 14.75 , 9.5 - sin(11) * 15 - 0.75]) {
        rotate(a = -11, v = [1, 0, 0]) {
            translate([0,0,32]) {
                rotate(a = 90, v = [1, 0, 0]) {
                    cylinder(h = 17, r = 32);
                }
            }
        }
    }

}

rotate(a = atan(2.625/9.5), v = [0,1,0])
{
    translate([-1,0,0]) cube([1,18,9.5]);
}
// keycap side length: 18

