// grill to allow ventilation, but not water into Septic controller box.
$fn=128;
innerWidth=120;
innerHeight=55;
wallThickness=1.6;
outerOverhang=15;
screwDiameter=5;

module outerRing() {
    outerWidth=innerWidth+(outerOverhang*2);
    outerHeight=innerHeight+(outerOverhang*2);
    
    difference() {
        minkowski() {
            cube([outerWidth, outerHeight, wallThickness*1], true);
            cylinder(h=0.1, r=3);
        }
        cube([innerWidth-(wallThickness*2), innerHeight-(wallThickness*2), wallThickness*4], true);
    }
}

module innerRing() {
    difference() {
        cube([innerWidth, innerHeight, wallThickness*4], true);
        cube([innerWidth-(wallThickness*2), innerHeight-(wallThickness*2), wallThickness*4], true);
    }
}

module grillBar() {
    rotate([45,0,0]) {
        cube([innerWidth, wallThickness*7, wallThickness],true);
    }
}

module grill() {
    spacing=wallThickness*2.5;
    for(counter=[-innerHeight/2:spacing:innerHeight/2]) {
        translate([0,counter,0]) {
            grillBar();
        }
    }
    cube([wallThickness, innerHeight, (wallThickness*6)],true);
}

module grillPanel() {
    innerRing();
    translate([0,0,wallThickness*2]){
        outerRing();
    }
    difference() {
        grill();
        translate([0,0,wallThickness*1]){
            outerRing();
        }
        translate([0,0,wallThickness*0]){
            outerRing();
        }
        translate([0,0,-wallThickness*1]){
            outerRing();
        }
        translate([0,0,-wallThickness*2]){
            outerRing();
        }
    }
}

module holes() {
    translate([((innerWidth+outerOverhang)/2),((innerHeight+outerOverhang)/2),0]) {
        cylinder(h=wallThickness*10, d=screwDiameter);
    }
    translate([-((innerWidth+outerOverhang)/2),((innerHeight+outerOverhang)/2),0]) {
        cylinder(h=wallThickness*10, d=screwDiameter);
    }
    translate([((innerWidth+outerOverhang)/2),-((innerHeight+outerOverhang)/2),0]) {
        cylinder(h=wallThickness*10, d=screwDiameter);
    }
    translate([-((innerWidth+outerOverhang)/2),-((innerHeight+outerOverhang)/2),0]) {
        cylinder(h=wallThickness*10, d=screwDiameter);
    }
    translate([0,((innerHeight+outerOverhang)/2),0]) {
        cylinder(h=wallThickness*10, d=screwDiameter);
    }
    translate([0,-((innerHeight+outerOverhang)/2),0]) {
        cylinder(h=wallThickness*10, d=screwDiameter);
    }
}

module flatteners() {
    translate([0,0,wallThickness*7.5]) {
        cube([innerWidth*2, innerHeight*2, wallThickness*10], true);
    }
    translate([0,0,-wallThickness*7]) {
        cube([innerWidth*2, innerHeight*2, wallThickness*10], true);
    }
}

difference() {
    grillPanel();
    holes();
    flatteners();
}