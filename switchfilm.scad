LIP_SIZE = 6; // mm size of lip
SEPARATOR_OFFSET = 3;

module gen_film(l, w, brim, thicc, lip, separator) {
    translate([(w/2 + brim)/2, l, 0])
    
    if (lip) // generates lip
        cube([LIP_SIZE, brim*2, thicc]);
    
    if (separator)
        translate([0, SEPARATOR_OFFSET, 0])
            cube([w + brim*2, brim, thicc]);
    
    difference() 
    {
        cube([brim*2 + w, brim*2 + l, thicc]);
        translate([brim, brim, -thicc/2]) 
            cube([w, l, thicc*2]);
    }
}

module gen_film_row(num, l, w, brim, thicc, lip, separator, supports) {
    for(i = [0 : num - 1]) {
        translate([i*(w + brim*2 + 2), 0, 0]) 
        {
            gen_film(l, w, brim, thicc, lip, separator);
            
            // generate connector supports - doesn't really slice well
            if (supports) {
                translate([w + brim*2, (l + brim*2)/4, 0]) cube([2, brim, thicc]);
                translate([w + brim*2, ((l + brim*2)/4)*3, 0]) cube([2, brim, thicc]);
            }
        }
    }
}

// gen_film_row(15, 13, 10, 1, 0.20, true, true, false);

// FIRST ROW

gen_film(13, 10, 1, 0.19, false, false);

translate([15,0,0])
    gen_film(13, 10, 1, 0.19, true, false);

translate([30,0,0])
    gen_film(13, 10, 1, 0.19, false, true);

translate([45,0,0])
    gen_film(13, 10, 1, 0.19, true, true);

// SECOND ROW

translate([0,17,0])
    gen_film(13, 10, 1, 0.19, false, false);

translate([15,17,0])
    gen_film(13, 10, 1, 0.19, true, false);

translate([30,17,0])
    gen_film(13, 10, 1, 0.19, false, true);

translate([45,17,0])
    gen_film(13, 10, 1, 0.19, true, true);