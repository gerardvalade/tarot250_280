// TransmitterBracket - a OpenSCAD 
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
//         	
show_module = 0;


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

module boscam_transmitter_module(rot_antenna=0)
{
	tin = 1.5;
	length = 38.4; 
	width = 26.4;
	heatsink_heigth = 3.17;
	heatsink_width = 22.5;
	hf_heigth = 7.58;
	
	color([0.9, 0, 0])
	{
		// PCB
		translate([0, 0, hf_heigth+tin/2+heatsink_heigth]) {
		//translate([0, 0, tin/2+11.9]) {
			cube([length, width, tin], center=true);
			//translate([-(length+3.24)/2, (width-9)/2, 0]) cube([3.24, 9, tin], center=true);
			translate([(length)/2-1, (width-8)/2, -3.5]) cube([13, 8, 5.5], center=true);
			translate([(length)/2-1, -(width-10.23)/2, -3.5]) cube([13, 10.2, 5.5], center=true);
		}
		// hf_heigth module		
		translate([-(length-29.5)/2, 0, hf_heigth/2+heatsink_heigth]) cube([29.5, 25.34, hf_heigth], center=true);
		// heat sink
		translate([-(length-29.5)/2, 0, heatsink_heigth/2]) cube([26, heatsink_width, heatsink_heigth], center=true);
		translate([-length/2, 6+2.2, -5.3/2+5.2]) {
			translate([-12.36/2, 0, 9.9/2]) rotate([0, 90, 0]) cylinder(d=6.3, h=12.36, center=true);
			translate([-12.36/2+1.5, 0, 9.9/2]) rotate([90, 0, 0]) rotate([0, 90, 0]) hexaprismx(ri=4, h=2);
			translate([-8, 0, 9.9/2]) rotate([rot_antenna, 0, 0]) antenna();
		}
		// capacitors
		translate([7, 0, 6/2+12]) rotate([0, 0, 0]) cylinder(d=8.5, h=6, center=true);
		translate([7, 8, 5/2+12]) rotate([0, 0, 0]) cylinder(d=6.9, h=5, center=true);
		
	}
}

module hexaprismx(
	ri =  1.0,  // radius of inscribed circle
	h  =  1.0)  // height of hexaprism
{ // -----------------------------------------------

	ra = ri*2/sqrt(3);
	cylinder(r = ra, h=h, $fn=6, center=true);
}


module boscam_transmitter_bracket(length= 42, width = 25, tin = 1.5)
{
	
	offset_x = -5;
	offset_y = -3;
	pad_heigth =  11+tin+1.5;
	
	
	module transmitter_module_pad(d, h)
	{
		translate([offset_x, offset_y, 0])
		for (x=[1]) {
			translate([x*(40.5+5.5)/2-.5, 0, h/2]) cylinder(d=d, h=h, center=true);
		}
	}

	module plate_pad(d, h)
	{
		translate([0, 0, h/2]) {
			for (x=[-1,1]) {
				translate([x*length/2, -19/2, 0]) cylinder(d=d, h=h, center=true);
				translate([x*length/2, 19/2, 0]) cylinder(d=d, h=h, center=true);
			}
		}
	}
	
	module transmitter_holder(length = 32)
	{
		difference(){
			hull() {
				translate([7, 0, 1]) cylinder(d=5.5, h=2, center=true);
				translate([-7, 0, 1]) cylinder(d=5.5, h=2, center=true);
			}
			translate([0, 0, 4.55]) cylinder(d=2.6, h=10, center=true);
		}
	}

	module lower_plate(tin = 1)
	{
		difference(){
			union() {
				translate([0, 0, tin/2]) cube([length+1, width, tin], center=true);
				
				mirror([0, 1, 0]) plate_pad(d=5.5, h=6);
			}
			translate([0, 0, -0.5]) mirror([0, 1, 0]) plate_pad(d=2.2, h=7);
			translate([-15, 0, 3]) {
				for (y=[-1, 1]) {
					hull() {
						translate([length/2, y*13.5/2, -3]) cylinder(d=6.8, h=6, center=true);
						translate([length/2-14, y*13.5/2, -3]) cylinder(d=6.8, h=6, center=true);
					}
				}
			}
		}
	}
	
	module hole(d)
	{
		translate([-length/2+offset_x, offset_y+6, 8+tin])
		hull() {
			translate([0, 0, 3]) rotate([0, 90, 0]) cylinder(d=d, h=6, center=true);
			translate([0, 0, -2]) rotate([0, 90, 0]) cylinder(d=d, h=6, center=true);
		}
		
	}
	
	difference(){
		union() {
			translate([offset_x/2 - 1, 0, tin/2]) cube([length+1-offset_x, width, tin], center=true);
				
			translate([-length/2-0.5+offset_x, offset_y+6, 18/2]) cube([2, 15, 18], center=true);
			translate([0, -3.5, tin+1.5/2]) {
				translate([-length/2+offset_x+9.5, 0, 0]) cube([4, width-7, 1.5], center=true);
				translate([-length/2+offset_x+27, 0, 0]) cube([6, width-7, 1.5], center=true);
			}
	
			plate_pad(d=5.5, h=tin);
			transmitter_module_pad(d=5.5, h=pad_heigth);
		}
		
		translate([0, 0, -0.5]) plate_pad(d=2.6, h=7);
		transmitter_module_pad(d=2.2, h=pad_heigth+1);
		
		translate([0, 0, 0])  hole(d=6.6);		
		
		translate([-15, 0, 3]) {
			for (y=[-1, 1]) {
				hull() {
					translate([length/2, y*13.5/2, -3]) cylinder(d=6.8, h=8, center=true);
					translate([length/2-14, y*13.5/2, -3]) cylinder(d=6.8, h=8, center=true);
				}
			}
		}
		
	}
	if(show_module) 
	{
		translate([-5.5, 0, 0]) tarot_plate();
		
		translate([0, 0, tin]) {
			translate([offset_x, offset_y-2, 1.5]) rotate([0, 0, 0]) boscam_transmitter_module();
			translate([offset_x+22.5, offset_y, pad_heigth-tin]) rotate([0,0,90]) transmitter_holder(length = 46);
		}
		translate([0, 0, -tin]) rotate([180, 0, 0]) lower_plate();
		
	} else {
		translate([0, 30, 0]) rotate([0,0,90]) transmitter_holder(length =46);
		translate([0, -40, 0])  lower_plate();
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

translate([0, 0, 0]) boscam_transmitter_bracket();

 
