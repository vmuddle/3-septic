// TPU seal for popups that are in the ground.
// Need to have a smaller diameter at base inner and larger diameter at base outer.
// Should act like a hydraulic seal, where the pressure of the water will make it seal tighter.
$fn=360;
modifier=1;
topInnerDiameter=27.4-modifier;
bottomInnerDiameter=topInnerDiameter+1;
topOuterDiameter=36.9+1;
bottomOuterDiameter=topOuterDiameter+1+modifier;
height=9.75;
wallThickness=1.6;


module innerCore() {
    cylinder(h=0.5, d1=topInnerDiameter+1, d2=topInnerDiameter);
    translate([0,0,0.5])
    cylinder(h=height-0.5, d1=topInnerDiameter, d2=bottomInnerDiameter);
    
}
module outer() {
    cylinder(h=0.5, d1=topOuterDiameter-1, d2=topOuterDiameter);
    translate([0,0,0.5])
        cylinder(h=height-0.5, d1=topOuterDiameter, d2=bottomOuterDiameter);
}

module innerBuck() {
    difference() {
        cylinder(h=height, d1=topOuterDiameter-(wallThickness*2), d2=bottomOuterDiameter-(wallThickness*0));
        cylinder(h=height, d1=topInnerDiameter+(wallThickness*2), d2=bottomInnerDiameter+(wallThickness*1));
    }
}

difference() {
    outer();
    innerCore();
    translate([0,0,wallThickness*2])
    innerBuck();
}