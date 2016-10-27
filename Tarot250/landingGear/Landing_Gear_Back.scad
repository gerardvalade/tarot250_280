// TL250/280 landing gear 10 degrees back - a OpenSCAD 
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

width_back=40;
hole_width_back=34.1;
higth=10.8;


module oval_foam(y, rot=70, d=15, h=10.72)
{
	rotate([0, 0, rot]) hull() {
		translate([0, -y*(35-15)/2, 0]) cylinder(d=d, h=h, center=false);
		translate([0, y*(35-15)/2, 0]) cylinder(d=d, h=h, center=false);
	}
}

module back_top( length=10)
{
	module plain() {
		translate([0, 0, 1.5/2+higth]) cube([10, width_back+28, 1.5], center=true);			
		for(y=[-1,1]) {
			translate([5, y*33, higth]) oval_foam(y, y*70, h=2);
		}			
		for(y=[-1,1]) {
			uu= 1.0;
			for(y2=[0:12:20]) {
				translate([4, y*(27+y2), higth]) rotate([y*0,0,0]) {
					rotate([0, 0, y*0]) hull() {
						translate([-y2*uu+15, 0, 0]) cylinder(d=3.5, h=length-2, center=false);
						translate([-y2*uu-1, 0, 0]) cylinder(d=3.5, h=length, center=false);
					}
				}
			}
		}
		
	}
	module hole()
	{
		translate([0, 0, higth/2-2]) cube([16, 16, higth], center=true);			
		for(y=[-1,1]) {
			translate([-4, y*31.5, 0]) oval_foam(y, y*70, h=10.72);
		}			
		for(x=[0]) for(y=[-hole_width_back/2,hole_width_back/2]) {
			translate([x, y, -0.1]) cylinder(d=3, h=20, center=false);
			translate([x, y, 2]) cylinder(d=5, h=20, center=false);
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
		trunc();
	}
}
		
module back_base(length=14)
{
	module plain() {
		translate([0, 0, (higth)/2]) cube([10, width_back+1, higth], center=true);			
	}
	module hole(connector_heigth=8.46)
	{
		translate([0, 0, connector_heigth/2-0.02]) cube([16, 16, connector_heigth], center=true);			
		translate([0, 0, higth+2.1/2]) cube([8.3, width_back+6, 2.1], center=true);			
		
		for(y=[-1,1]) {
			translate([-4, y*31.5, higth]) oval_foam(y, y*70, h=2);
		}			
		for(x=[0]) for(y=[-hole_width_back/2,hole_width_back/2]) {
			translate([x, y, -0.1]) cylinder(d=2.5, h=20, center=false);
			translate([x, y, 2]) cylinder(d=5, h=20, center=false);
		}
	}
	
	difference()
	{
		plain();
		hole();
	}
	translate([0, -8, 8.5]) rotate([45, 0, 0]) cube([10, 3.1, 3.1], center=true);			
}


translate([-30, 0, higth]) rotate([0, 180, 0]) back_base(higth=higth);			
translate([0, 0, -higth]) back_top(higth=higth);			
