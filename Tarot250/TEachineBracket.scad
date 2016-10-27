// TEachineBracket - a OpenSCAD 
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



$fn = 30;
//         	
show_module = 0;
heatsink_heigth = 6;


module antenna()
{
	translate([-19.5/2, 0, 0]) rotate([0, 90, 0]) cylinder(d=9.9, h=19.5, center=true);
	translate([-24, 0, -9.9/2]) { 
		hull() {
			translate([0, 0, 0]) cylinder(d=9.8, center=true);
			translate([0, 0, 87]) cylinder(d=8, center=true);
		}
		translate([0, 0, 87]) sphere(d=8);
	}
}

module eachine_transmitter_bracket(length= 35, width = 28, tin = 1.5)
{
	
	offset = 5;
	heatsink_width = heatsink_heigth == 0 ? 19 : 20;
	hf_heigth = 3.79;
	pad_heigth = 5.76 + heatsink_heigth + tin;
	
	module plate_pad(d, h)
	{
//		translate([0, 0, h/2]) {
//			for (x=[-1,1]) {
//				translate([x*length/2, -19/2, 0]) cylinder(d=d, h=h, center=true);
//				translate([x*length/2, 19/2, 0]) cylinder(d=d, h=h, center=true);
//			}
//		}
		translate([0, 0, 0]) {
			translate([0, 0, h/2]) {
				for (x=[-1,1]) {
				for (y=[-1,1]) {
					translate([x*length/2, y*19/2, 0]) cylinder(d=d, h=h, center=true);
				}
				}
			}
		}
	}
	
	module transmitter_module(length = 25.3, width=20.25)
	{
		tin=1.5;
		
		
		color([0.5, 0, 0])
		{
			// PCB
			translate([0, 0, hf_heigth+tin/2+heatsink_heigth]) {
				cube([length, width, tin], center=true);
				translate([-(length+3.24)/2, (width-9)/2, 0]) cube([3.24, 9, tin], center=true);
			}
			// HF module		
			translate([2, 0, hf_heigth/2+heatsink_heigth]) cube([19.3, 18.5, hf_heigth], center=true);
			// heat sink
			translate([2, 0, heatsink_heigth/2]) cube([20, heatsink_width, heatsink_heigth], center=true);
			translate([-length/2-3.24, 6, heatsink_heigth]) {
				translate([-5/2, 0, 9.9/2]) rotate([0, 90, 0]) cylinder(d=6.3, h=5, center=true);
				translate([-5, 0, 9.9/2]) antenna();
			}
			//translate([-21, 6, heatsink_heigth]) antenna(); 
		}
	}
	
	module transmitter_holder(length=32)
	{
		difference(){
			union() {
				translate([3, 0, 1]) cube([5, length, 2], center=true);
				for (y=[-1,1]) {
					hull() {
						translate([0, y*length/2, 1]) cylinder(d=5.5, h=2, center=true);
						translate([2.7, y*length/2, 1]) cylinder(d=5.5, h=2, center=true);
					}
				}
			}
			for (y=[-1,1]) {
				translate([0, y*length/2, 4.55]) cylinder(d=2.6, h=10, center=true);
			}
		}
	}

	
	difference(){
		union() {
			translate([0, 0.8, tin/2]) cube([length, width, tin], center=true);
			
			// heatsink holder
			translate([0, 3, (tin+1.5)/2]) 
			for (y=[-1,1]) {
				//translate([0, y*(heatsink_width+1.5)/2+2.5, (tin+1.5)/2]) cube([22, 1.5, tin+1.5], center=true);
				translate([0, y*(heatsink_width+2.2)/2, 0]) cube([22, 1.5, tin+1.5], center=true);
				//#translate([0, y*(heatsink_width)/2, 0]) cube([50, 0.2, 0.2], center=true);
			}

			plate_pad(d=5.5, h=2);
			translate([0, -width/2, 0]) {
//				translate([0, 0, 3]) {
//					translate([length/2, 19, 0]) cylinder(d=5.5, h=6, center=true);
//					for (x=[-1,1]) {
//						translate([x*length/2, 0, 0]) cylinder(d=5.5, h=6, center=true);
//					}
//				}
				for (x=[-1,1]) {
					translate([x*(32)/2, 8+offset, pad_heigth/2]) cylinder(d=5.5, h=pad_heigth, center=true);
				}
			}
	
		}
		translate([0, 0, -0.1]) plate_pad(d=2.2, h=10);
		translate([0, -width/2, 0]) {
			// hole 
			yy = heatsink_width > 15.8 ? (heatsink_width/2-7.9) : 0;
			translate([0, 6.5/2-yy, tin/2]) cube([16, 6.55, tin+2], center=true);
			
			
//			translate([0, 0, 0]) {
//				translate([length/2, 19, 3]) cylinder(d=2.2, h=10, center=true);
//				for (x=[-1,1]) {
//					translate([x*length/2, 0, 3]) cylinder(d=2.2, h=10, center=true);
//				}
//			}
			for (x=[-1,1]) {
				translate([x*(32)/2, 8+offset, pad_heigth/2]) cylinder(d=2.2, h=pad_heigth+1, center=true);
			}
		}
	}
	
	module lower_plate(tin = 1)
	{
		module roundHole(s)
		{
			round=5;
			translate([0, 0, 0]) cube([s[0]-round, s[1]-round, s[2]], center=true);
			for (x=[-1, 1]) {
				hull() {
				translate([x*(s[0]-round)/2, -x*(s[1]-round)/2, 0]) cylinder(d=round, h=6, center=true);
				translate([x*(s[0]-round)/2, x*(s[1]-round)/2, 0]) cylinder(d=round, h=6, center=true);
				}
				hull() {
				translate([-x*(s[0]-round)/2, x*(s[1]-round)/2, 0]) cylinder(d=round, h=6, center=true);
				translate([x*(s[0]-round)/2, x*(s[1]-round)/2, 0]) cylinder(d=round, h=6, center=true);
				}
			}
			
		}
		
		difference(){
			union() {
				translate([0, 0, tin/2]) cube([length+1, width, tin], center=true);
				
				mirror([0, 1, 0]) plate_pad(d=5.5, h=6);
			}
			translate([0, 0, -0.5]) mirror([0, 1, 0]) plate_pad(d=2.2, h=10);
			translate([0, 0, tin/2]) roundHole([length-6, width-6, tin+2], center=true);
//			translate([-15, 0, 3]) {
//				for (y=[-1, 1]) {
//					hull() {
//						translate([length/2, y*13.5/2, -3]) cylinder(d=6.8, h=6, center=true);
//						translate([length/2-14, y*13.5/2, -3]) cylinder(d=6.8, h=6, center=true);
//					}
//				}
//			}
		}
	}
	
	if(show_module) 
	{
		translate([-5.5, 0, 0]) tarot_plate();
		
		translate([0, 0, tin]) {
			translate([0, offset/2, 0]) transmitter_module();
			translate([0, -0.5, pad_heigth-tin+1]) rotate([0,0,90]) transmitter_holder(length =32);
			translate([0, 0, -2])  rotate([180,0,0]) lower_plate();
		}
		
	} else {
		translate([0, 30, 0]) rotate([0,0,90]) transmitter_holder(length =32);
		translate([50, 0, 0])  lower_plate();
	}
}

module tarot_plate(length=61, width=37.57, tin=1)
{
	color([0.9, 0.9, 0]) difference(){
		union() {
			translate([0, 0, -tin/2]) cube([length, width, tin], center=true);
		}
		translate([0, 0, 3]) {
			for (y=[-1, 1]) {
				for (x=[-3, -36]) {
					hull() {
						translate([length/2+x, y*19/2, -3]) cylinder(d=2, h=6, center=true);
						translate([length/2+x-11, y*19/2, -3]) cylinder(d=2, h=6, center=true);
					}
				}
				hull() {
					translate([length/2-20, y*13.5/2, -3]) cylinder(d=6.5, h=6, center=true);
					translate([length/2-20-11, y*13.5/2, -3]) cylinder(d=6.5, h=6, center=true);
				}
			}
		}
	}
	
}

translate([0, 0, 0]) eachine_transmitter_bracket();

 
