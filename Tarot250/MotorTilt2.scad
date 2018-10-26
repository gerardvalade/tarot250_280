// TL250/280 motorTilt - a OpenSCAD 
// Copyright (C) 2016  Gerard Valade

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.



$fn = 40;
forward_tilt = 10;
inner_tilt = -4;
//         	

module hexaprismx(
	ri =  1.0,  // radius of inscribed circle
	h  =  1.0)  // height of hexaprism
{ // -----------------------------------------------

	ra = ri*2/sqrt(3);
	cylinder(r = ra, h=h, $fn=6, center=false);
}

module motor_tilt(rot=0)
{
	heigth=6;
	module plain()
	{
		translate([0, 0, 0.5])  hull()
		{
			translate([0.4, 1.4, 0]) rotate([0, 0, 0]) cylinder(d=27, h=1, center=true);
			translate([0, 0, heigth]) rotate([forward_tilt, inner_tilt, 0]) cylinder(d=27, h=1, center=true);
		}
	}
	module hole()
	{
		M25_hexa = 5.4;
		M25_hole = 2.8;
		M25_head_hole = 5.1;
		
		for(n=[0, 90, 180, 270])
		{
			if (rot==0 && (n==90 || n==270) || rot==45 && (n==0 || n==180))  rotate([0, 0, n+rot]) {
				translate([16/2, 0, 0]) { 
					translate([0, 0, 5]) cylinder(d=M25_hole, h=10.5, center=true);

					translate([0, 0, 1.8]) rotate([0, 0, 30])  hexaprismx(ri=(M25_hexa-0.5)/2, h=10);
					translate([0, 0, 1.8]) rotate([0, 0, 30])  hexaprismx(ri=M25_hexa/2, h=2);
					translate([0, 0, 1.8+3]) rotate([0, 0, 30])  hexaprismx(ri=(M25_hexa)/2, h=10);
					
				}
			}
			translate([0.5, 1.3, 0]) {
				if (n==180 && rot==0 || n==90 && rot==45)
				{
					rotate([forward_tilt, inner_tilt, 0]) rotate([0, 0, n+45+rot])  translate([0, 0, -2]) hull() {
						translate([19.5/2, 0, 0])   cylinder(d=4.6, h=20, center=false);
						translate([30.5/2, 0, 0])   cylinder(d=5.6, h=20, center=false);
					}
					
				} else if (rot==0 && (n==90 || n==270) || rot==45 && (n==180 || n==0))
				
				rotate([forward_tilt, inner_tilt, 0]) {
					// motor center hole
					translate([0, 0, 0])  cylinder(d=8.1, h=20.5, center=true);
					// helpfull mark
					//translate([0, 0, 7.2]) rotate([90, 0, 0]) cylinder(d=1, h=30, center=true);
					rotate([0, 0, n+rot+90]) translate([0, 0, 0])  {
						// hole screw
						hull() {
							translate([15.5/2, 0, 0]) cylinder(d=M25_hole, h=20.5, center=true);
							translate([19.5/2, 0, 0]) cylinder(d=M25_hole, h=20.5, center=true);
						}
						// head screw
						translate([0, 0, -12.8-2]) hull() {
							translate([14.5/2, 0, 0])  cylinder(d=M25_head_hole, h=20, center=false);
							translate([20.5/2, 0, 0])  cylinder(d=M25_head_hole, h=20, center=false);
						}
						
					}
				
				}
			}
		}
	}
	
	translate([0, 0, 0]) {
		difference()
		{
			plain();
			hole();
		}
	}
}

module calibration_stand()
{
	heigth=20;
	width= 32;
	length=55;
	thin = 3;
	difference() {
		union() {
			translate([-width/2, 0, 0]) {
				cube([width, length, thin], center=false);
				translate([0, 0, 0]) cube([width, thin, heigth+10.5], center=false);
				translate([0, length-thin, 0]) cube([width, thin, heigth], center=false);
			}
		}
		translate([(width+2)/2, length, heigth-1.5]) rotate([0,0,180]){
			rotate([forward_tilt, 0, 0]) cube([width+2, 80, 11], center=false);
		}
		hull()
		{
			translate([0, 15, -0.1]) cylinder(d=16, h=4);
			translate([0, length-15, -0.10]) cylinder(d=16, h=4);
		}	
		hull() {
			translate([0, 4, 35]) rotate([90, 0, 0]) cylinder(d=10, h=8);
			translate([0, 4, 10]) rotate([90, 0, 0]) cylinder(d=10, h=8);
		}
	}
}


// backward
translate([40, 60, 0]) motor_tilt(rot=0);
translate([-40, 60, 0]) mirror([1, 0, 0])motor_tilt();

// forward
translate([40, 0, 0]) motor_tilt(rot=45);
translate([-40, 0, 0]) mirror([1, 0, 0])motor_tilt(rot=45);


 calibration_stand();
