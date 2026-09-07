// Port adapter with vent for air pressure sensor
// Designed for 3D printing


rigidPortDiameter=5.5;  // probably really 6.25  5.5 is good in TPU.
rigitPortLength=10; // maybe too large, but it'll connect well.
rigitPortThickness=1.5; // maybe too thick, but it'll connect well.

portSpacing=18;

module rigidPortTPUGasket(isBuck=false) {
    if(isBuck) {
        cylinder(d=rigidPortDiameter+(2*rigitPortThickness)+0.4, h=rigitPortLength+0.4, $fn=360);
    } else {
        difference() {
            cylinder(d=rigidPortDiameter+(2*rigitPortThickness), h=rigitPortLength, $fn=360);
                
            cylinder(d=rigidPortDiameter, h=rigitPortLength, $fn=360);
            cylinder(d2=rigidPortDiameter, d1=rigidPortDiameter+1, h=rigitPortLength/4, $fn=360);
        }
    }
}

module ridgidPortSurround() {
    difference() {
        cylinder(d=rigidPortDiameter+(2*rigitPortThickness), h=rigitPortLength, $fn=360);
        translate([0,0,-1]) cylinder(d=rigidPortDiameter, h=rigitPortLength+2, $fn=360);
    }
}

module ridgiddPortWithTPUGasketSlot() {
    difference() {
        union() {
            rigidPortTPUGasket();
            cylinder(d=rigidPortDiameter, h=rigitPortLength, $fn=360);
        }
        translate([0,0,-1]) cylinder(d=rigidPortDiameter+(2*rigitPortThickness), h=rigitPortLength+2, $fn=360);
    }
}


module portSpacingRuler(spacingNumber=20) {
    portDiameter=6.25;
    wallThickness=2;
    
    spacing=spacingNumber/2;
    
    difference() {
        hull() {
            translate([-spacing,0,0]) {
                cylinder(h=wallThickness, d=portDiameter+(wallThickness*2), $fn=360);
            }
            translate([spacing,0,0]) {
                cylinder(h=wallThickness, d=portDiameter+(wallThickness*2), $fn=360);
            }
        }
        translate([-spacing,0,0]) {
            cylinder(h=wallThickness, d=portDiameter, $fn=360);
        }
        translate([spacing,0,0]) {
            cylinder(h=wallThickness, d=portDiameter, $fn=360);
        }
    }
    linear_extrude(height=wallThickness+0.5) {
        text(str(spacingNumber), size=6, halign="center", valign="center");
    }
}

module doublePortWithVent() {
    portDiameter=6.25;
    wallThickness=2;
    adapterLength=40;
    
    spacing=portSpacing/2;
    
    gasketDiameter=rigidPortDiameter+(2*rigitPortThickness)+0.4;
    
    difference() {
        hull() {
            translate([-spacing,0,0]) {
                cylinder(h=adapterLength, d=max(portDiameter, gasketDiameter)+(wallThickness*2), $fn=360);
            }
            translate([spacing,0,0]) {
                cylinder(h=adapterLength, d=max(portDiameter, gasketDiameter)+(wallThickness*2), $fn=360);
            }
        }
        // Through holes for the ports
        translate([-spacing,0,0]) {
            cylinder(h=adapterLength, d=portDiameter, $fn=360);
        }
        translate([spacing,0,0]) {
            cylinder(h=adapterLength, d=portDiameter, $fn=360);
        }
        // Gasket slots for the ports
        translate([-spacing,0,1]) {
            rigidPortTPUGasket(true);
        }
        translate([spacing,0,1]) {
            rigidPortTPUGasket(true);
        }
        // gasket end caps
        translate([-spacing,0,0]) {
            cylinder(h=1, d=gasketDiameter-1, $fn=360);
        }
        translate([spacing,0,0]) {
            cylinder(h=1, d=gasketDiameter-1, $fn=360);
        }
        // Hose insertion point
        translate([-spacing,0,adapterLength-20]) {
            cylinder(h=20, d1=6, d2=7.5, $fn=360);
        }
    }
    translate([spacing,0,adapterLength-.5]) {
        cube([gasketDiameter,1,1], true);
        cube([1,gasketDiameter,1], true);
    }
    
}
if(false) {
    rigidPortTPUGasket(false);
}

if(false) {
    // we have worked out that 18mm is about right, and 6.25mm port diamter is about right.  Let's make a ruler to check.
    for(spacingNumber = [15:1:25]) {
        translate([0,15*spacingNumber,0])
        portSpacingRuler(spacingNumber);
    }
}

doublePortWithVent();