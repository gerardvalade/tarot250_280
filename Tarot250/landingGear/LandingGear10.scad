// TL250/280 landing gear 10 degrees - a OpenSCAD 
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


module front_top()
{
	module plain(length=28) {
		translate([0, 0, higth]) {
			translate([0, 0, 2/2]) cube([8, width, 2], center=true);
			//translate([0, 0, 7/2]) cube([2, 20, 7], center=true);
			dia=8;
			translate([0, 0, dia/2])  difference() {			
				rotate([90, 0, 0]) hull() {
					translate([6, 0, ]) rotate([0, 0, 0]) cylinder(d=dia, h=10, center=true);
					translate([-6, 0, 0]) rotate([0, 0, 0]) cylinder(d=dia, h=10, center=true);
				}
			}			
			for(y=[-1,1])  {
				translate([0, y*(33), 0]) oval_foam(y, 0, h=2);
			translate([-2, y*(33), 11]) rotate([45,-10,0]) cylinder(d=3, h=30, center=true);
			translate([-2, y*(33), 11]) rotate([-45,-10,0]) cylinder(d=3, h=30, center=true);
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
			translate([5, y*33, 0]) oval_foam(y, y*70, h=10.72);
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



module all_modules()
{
translate([60, 0, 0]) 	front_base();
translate([100, 0, -higth])  front_top();
translate([-30, 0, higth]) rotate([0, 180, 0]) back_base();			
translate([0, 0, -higth]) back_top();			
	
}


module tl250_hole(length=200, heigth=20)
{
	for(x=[0, 20]) for(y=[-hole_width_back/2,hole_width_back/2]) {
		translate([x, y, 0]) cylinder(d=1, h=30, center=true);
	}
	for(x=[94, 94+18]) for(y=[-hole_width/2,hole_width/2]) {
		translate([x, y, 0]) cylinder(d=1, h=30, center=true);
	}
}

module preview_mount() {

	piece_color = [0.9, 0.9, 0.5];
	foam_color = [0.0, 0.2, 0.9];
	fixing_color = [0.9, 0.2, 0];
	
	translate([0, 0, 16.8]) rotate([180, -10, 0]) {
		color(fixing_color) tl250_hole();
		color(piece_color)  translate([0, 0, 0])  back_base();			
		color(piece_color) translate([0, 0, 0.02]) back_top();			
		translate([94+18/2, 0, 0]) {
			color(piece_color) front_base();
			translate([0, 0, 0]) color(piece_color)  front_top();
			for(y=[-1,1]) {
				translate([0, y*(33), 0]) color(foam_color) oval_foam(y, 0, h=10.72);
			}			
		}		
		for(y=[-1,1]) {
			translate([5, y*33, 0]) color(foam_color) oval_foam(y, y*70, h=10.72);
		}			
	}
}

//preview_mount();
all_modules();
