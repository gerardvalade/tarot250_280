// FpvTransmitterBacket - a OpenSCAD 
// Copyright (C) 2015  Gerard Valade

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


$fn= 50;


module fpv_transmitter_bracket()
{
	height=12;
	translate([0, 0, height/2]) {
		difference() {
			translate([0, 0, 0])  cube([7, 21, height], center=true);
			translate([0, 0, 0]) {
				translate([0.7, 0, 1])  cube([2, 9.5, 8.9], center=true);
				
				translate([-2, 0, 2.2])  cube([4, 9.5, 6.9], center=true);
				hull(){
					translate([7-1.9, 0, 0]) rotate([0, 90, 0]) cylinder(d=6.5, h=7, center=true);
					translate([7-1.9, 0, 5]) rotate([0, 90, 0]) cylinder(d=6.5, h=7, center=true);
				}
				for (y=[-1,1]) {
					//translate([0, y*(8+2), 0]) cube([3, 2, 20], center=true);
					translate([0, y*(8+2), -2]) cylinder(d=2.2, h=10, center=true);
				}
			
			}
			translate([0, 0, 4.5])  cube([8, 22, 6], center=true);
		}
	}
	
}

module fpv_transmitter_bracket2()
{
	height=14;
	width=10;
	translate([0, 0, height/2]) {
		difference() {
			translate([0, 0, 0])  cube([width, 21, height], center=true);
			hull(){
				translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(d=10, h=width+1, center=true);
				translate([0, 0, 5]) rotate([0, 90, 0]) cylinder(d=10, h=width+1, center=true);
			}
			for (y=[-1,1]) {
				translate([0, y*(8+2), 0]) cube([3, 2, 20], center=true);
			}
			translate([0, 0, 4.5])  cube([width+1, 22, 6], center=true);
		}
	}
	
}
module fpv_transmitter_bracket4()
{
	height=14;
	width=10;
	//translate([0, 0, height/2]) 
	{
		difference() {
			#translate([0, 0, 0])  cube([width, 21, height], center=true);
			hull(){
				translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(d=10, h=width+1, center=true);
				translate([0, 0, 5]) rotate([0, 90, 0]) cylinder(d=10, h=width+1, center=true);
			}
			for (y=[-1,1]) {
				//translate([0, y*(8+2), 0]) cube([3, 2, 20], center=true);
				translate([0, y*(8+2), -2]) cylinder(d=2.2, h=10, center=true);
			}
			translate([0, 0, 4.5])  cube([width+1, 22, 6], center=true);
		}
	}
	
}

module fpv_transmitter_bracket3()
{
	height = 14;
	length = 26;
	width = 26;
	//translate([0, 0, height/2]) 
	{
		difference() {
			union(){
				translate([0, 0, -height/4])  cube([width, length, height/2], center=true);
				translate([0, 0, 2])  cube([width, length, 4], center=true);
				rotate([0, 90, 0]) cylinder(d=height+2, h=width, center=true);
				
			}
			translate([-2, 0, 0]) {
				rotate([0, 90, 0]) cylinder(d=10, h=8.2, center=true);
				for (x=[-1, 1]) {
					translate([x*(6+4), 0, 0]) rotate([0, 90, 0]) cylinder(d=11, h=12, center=true);
				}
			
			}
			for (y=[-1,1]) {
				//#translate([0, y*(20.5/2), 0]) cylinder(d=2.2, h=height+1, center=true);
				for (x=[-1,1]) {
					//translate([0, y*(8+2), 0]) cube([3, 2, 20], center=true);
					#translate([x*(20.5/2), y*(20.5/2), 0]) cylinder(d=2.2, h=height+1, center=true);
					
				}
			}
			//translate([0, 0, 4.5])  cube([width+1, length+1, 6], center=true);
			translate([0, 0, 0])  cube([width+1, length+1, 1.2], center=true);
			translate([0, 0, -height/2-3])  cube([width+1, length+1, 6], center=true);
		}
	}
	
}


translate([-60, 0, 0]) fpv_transmitter_bracket();
translate([-80, 0, 0]) fpv_transmitter_bracket2();
//#translate([-10, 0, 0]) fpv_transmitter_bracket4();
translate([0, 0, 0]) fpv_transmitter_bracket3();