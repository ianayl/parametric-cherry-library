$fn = 50;

// thickness of the lofts used
LOFT_THICKNESS = 0.001; // this level of detail is indiscernable to a 3d printer

X_AXIS = [1,0,0];

// Generate a square plane with rounded edges
module round_square(corner_r, hor_len, ver_len) {

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

//           backside offset: 0.25
//           topside offset: 2.625
//           top vertical length: 14.75
//           top horizontal length: 12.75
//           top face vertical offset: 3
//           scuplt angle: 11 degrees
//           sculpt curve cup radius: 64/2 = 32


// measurements in mm

// ROW 4

// cap profile measurements
cap_height = 9.5;
base_side_len = 18;

// fillet radiuses
base_r = 0.25; // radius of base face
top_r = 0.875;

// top face dimensions
top_hor_len = 12.75;
top_ver_len = 14.75;

// top face positioning
top_hor_margin = (base_side_len - top_hor_len) / 2; // side margins
// should be 2.625 using stock values 
top_ver_margin = 3; // top margin of top face

// cap scuplt
cap_sculpt_angle = 11;
cap_sculpt_tilt = -1; // 1 for positive tilt, -1 for negative tilt
cap_indent = 0.75;

// cap cutout
cutout_len = top_ver_len + 0.75;
cutout_r = 32;

difference() {
    hull() {
        // base face of cap
        round_square(base_r, base_side_len, base_side_len);
        
        // top face of cap
        translate([top_hor_margin, top_ver_margin, cap_height]) {
            // round_square(top_r, top_hor_len, top_ver_len);
            rotate(a = cap_sculpt_tilt * cap_sculpt_angle, v = X_AXIS) {
                round_square(top_r, top_hor_len, top_ver_len);
            }
        }
    }
    
    // cup cutout
    translate([base_side_len / 2,
              top_ver_margin + top_ver_len,
              cap_height - sin(cap_sculpt_angle) * cutout_len - cap_indent]) {
        rotate(a = cap_sculpt_tilt * cap_sculpt_angle, v = X_AXIS) {
            translate([0, 0, cutout_r]) {
                rotate(a = 90, v = X_AXIS) {
                    cylinder(h = cutout_len, r = cutout_r);
                }
            }
        }
    }
}
// keycap side length: 18

// hull() {
//     // base face of cap
//     round_square(base_r, base_side_len, base_side_len);
//     
//     // top face of cap
//     translate([top_hor_margin, top_ver_margin, cap_height]) {
//         rotate(a = cap_sculpt_tilt * cap_sculpt_angle, v = X_AXIS) {
//             round_square(top_r, top_hor_len, top_ver_len);
//         }
//     }
// }
