// TL250/280 landing gear 10 degrees front - a OpenSCAD 
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

width=35;
hole_width=30;
higth=10.8;

module front_top()
{
	module plain(length=28) {
		translate([0, 0, higth]) {
			translate([0, 0, 1.5/2]) cube([8, width, 1.5], center=true);
			translate([0, 0, 7/2]) cube([2, 20, 7], center=true);
			dia=8;
			translate([0, 0, dia/2])  difference() {			
				rotate([90, 0, 0]) hull() {
					translate([6, 0, ]) rotate([0, 0, 0]) cylinder(d=dia, h=10, center=true);
					translate([-6, 0, 0]) rotate([0, 0, 0]) cylinder(d=dia, h=10, center=true);
				}
			}			
			for(y=[-1,1])  {
				translate([0, y*(33), 0]) oval_foam(y, 0, h=2);
				for(y2=[0:22:26]) {
					translate([0, y*(22+y2), 0]) rotate([y*0,-10,0]) {
						hull() {
							translate([6, 0, 0]) cylinder(d=3.5, h=length-5, center=false);
							translate([-6, 0, 0]) cylinder(d=2.2, h=length, center=false);
						}
					}
				}
			}
		}
	}
	
	module hole(d=15.5, h=50)
	{
		translate([0, 0, higth+5/2]) {
			translate([0, 0, 0]) cube([25, 4.3, 5], center=true);
			for(x=[9,-9]) for(y=[-hole_width/2,hole_width/2]) {
				translate([x, y, 0]) cylinder(d=3.6, h=20, center=true);
			}
		}			
		for(y=[-1,1]) {
			translate([0, y*(50+40)/2, higth-5/2]) cube([25, 80, 5], center=true);
			translate([0, y*(33), 0]) oval_foam(y, 0, h=10.72);
		}			
	}
	module trunc(length=200, heigth=20)
	{
		translate([length/2-40, 0, heigth+17.74]) rotate([0, -10, 0]) cube([length, 200, heigth], center=true);
	}
	
	difference()
	{
		plain();
		hole();
		translate([-94-18/2, 0, 0]) trunc();
	}
}
module front_base()
{
	module plain(length=40) {
		translate([0, 0, 0]) {
			translate([0, 0, 1.5/2]) cube([22, width, 1.5], center=true);			
			hull() {
				translate([8.5, 0, 0]) cylinder(d=3.9, h=higth+5, center=false);
				translate([-8.5, 0, 0]) cylinder(d=3.9, h=higth+5, center=false);
			}
		}
	}
	module hole(d=15.5, h=50)
	{
		for(y=[-1,1]) {
			translate([0, 0, 11/2]) hull() {
				translate([0, y*(32+d)/2, 0]) cylinder(d=d, h=11, center=true);
				translate([0, y*((32+d)/2+34), 0]) cylinder(d=d, h=11, center=true);
			}
			translate([0, 0, h/2-0.05]) hull() {
				translate([0, y*(32+d)/2, 0]) cylinder(d=d, h=h, center=true);
				translate([0, y*((32+d)/2+34), 0]) cylinder(d=d, h=h, center=true);
			}
		}			
		for(x=[9,-9]) for(y=[-hole_width/2,hole_width/2]) {
			translate([x, y, 0]) cylinder(d=2.5, h=20, center=true);
		}
	}
	
	difference()
	{
		plain();
		hole();
	}
}


module oval_foam(y, rot=70, d=15, h=10.72)
{
	rotate([0, 0, rot]) hull() {
		translate([0, -y*(35-15)/2, 0]) cylinder(d=d, h=h, center=false);
		translate([0, y*(35-15)/2, 0]) cylinder(d=d, h=h, center=false);
	}
}



translate([94+18/2, 0, 0]) 	front_base();
translate([0, 0, -higth])  front_top();

