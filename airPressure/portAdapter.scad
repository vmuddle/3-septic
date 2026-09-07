// Adapter for new Differential Pressure to Older pipe
newInnerDiameter=6;
oldInnerDiameter=6;
newLength=20;
oldLength=20;
$fn=360;



isTPU=true;


module OLD_tpuGrommet(sealLength=10, tpuInnerDiameter=6, tpuOuterDiameter=8) {
    union() {
        cylinder(h=sealLength, d=tpuOuterDiameter);
        translate([10,0,(sealLength/3)*2]) {
            cylinder(h=sealLength/3, d1=tpuInnerDiameter-1, d2=tpuInnerDiameter);
        }
        translate([20,0,(sealLength/3)*1]) {
            cylinder(h=sealLength/3, d=tpuInnerDiameter-1);
        }
        translate([30,0,0]) {
            cylinder(h=sealLength/3, d2=tpuInnerDiameter, d1=tpuInnerDiameter-1);
        }
    }
}

module tpuGrommet(sealLength=10, tpuInnerDiameter=6, tpuOuterDiameter=8) {
    cylinder(h=sealLength, d1=tpuInnerDiameter, d2=tpuOuterDiameter);
}

module tpuAdapter() {
    totalLength=40;
    sealLength=6;
    tpuInnerDiameter=6; 
    tpuWideInnerDiameter=7;
    tpuOuterDiameter=tpuInnerDiameter+3;
    difference() {
        cylinder(h=totalLength, d=tpuOuterDiameter);
        cylinder(h=totalLength, d=tpuInnerDiameter);
        translate([0,0,0]) {
            tpuGrommet(sealLength=sealLength, tpuWideInnerDiameter, tpuInnerDiameter-1);
        }
        translate([0,0,totalLength-sealLength]) {
            tpuGrommet(sealLength=sealLength, tpuInnerDiameter-1, tpuOuterDiameter=tpuWideInnerDiameter);
        }
    }
}

module adapter() {
    wallThickness=3;
    difference() {
        cylinder(h=newLength+oldLength, d=newInnerDiameter+(wallThickness*2));
        cylinder(h=newLength, d=newInnerDiameter);
        cylinder(h=newLength+oldLength, d1=oldInnerDiameter, d2=oldInnerDiameter+0.5);
    }
    
}

module vent() {
    topThickness=1.6;
    sideThickness=2;
    finThickness=0.8;
    difference() {
        union() {
            cylinder(h=topThickness, d=newInnerDiameter+(sideThickness*2));
            translate([0,0,(newLength/2)+topThickness]) {
                for(angle = [0:20:360]) {
                    rotate([0,0,angle]) {
                        hull() {
                            translate([(newInnerDiameter/2)+sideThickness-finThickness/2,0,0]) {
                            cube([finThickness,finThickness,newLength], true);
                            }
                            cube([finThickness/4,finThickness/4,newLength], true);
                        }
                    }
                }
            }
            translate([0,0,newLength+topThickness]) {
                cylinder(h=topThickness+newLength, d=newInnerDiameter+(sideThickness*2));
            }
        }
        translate([0,0,topThickness]) {
            cylinder(h=(newLength*2)+topThickness,d1=newInnerDiameter, d2=newInnerDiameter+0.5);
        }
    }
}

module grommet() {
    outerDiameter=10.5;
    outerLength=40;
    grooveWidth=3.5;
    grooveDepth=1.75;

    difference() {
        cylinder(h=outerLength, d=outerDiameter);
        hull() {
            spacing=(grooveWidth/2)-(grooveDepth/2);
            translate([-spacing,0,0]) {
                cylinder(h=outerLength, d=grooveDepth);
            }
            translate([spacing,0,0]) {
                cylinder(h=outerLength, d=grooveDepth);
            }
        }
        %translate([0,0,outerLength]) {
            cube([grooveWidth,grooveDepth,outerLength], true);
        }
        translate([0,outerDiameter/2,outerLength/2]) {
            cube([outerDiameter,outerDiameter,outerLength], true);
        }
    }
}

if(false) {
//vent();
translate([30,0,0]) {
    adapter();
}
}
if(false){
translate([-30,0,0]) {
    grommet();
    translate([-15,0,0]) {
        grommet();
    }
}
}


tpuAdapter();