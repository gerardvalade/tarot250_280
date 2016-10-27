// FpvCameraBacket - a OpenSCAD 
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


$fn= 30;


// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly) {
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				 y = [radius-size[1]/2, -radius+size[1]/2]) {
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
					y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
				rotate(rot[axis]) 
					translate([x,y,0]) 
					cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				y = [radius-size[1]/2, -radius+size[1]/2],
				z = [radius-size[2]/2, -radius+size[2]/2]) {
			translate([x,y,z]) sphere(radius);
		}
	}
}

module pad(d, h)
{	
	difference() {
		cylinder(d=d, h=h, center=true);	
		cylinder(d=hole_dia, h=h+10, center=true);	
	
	}
}

module eachine_camera_bracket(thin=1)
{
plate_width=32;
camera_width_fixing_hole=27;
plate_width_fixing_hole=18;
hole_dia=1.8;
holder_pad_offset=7;
holder_pad_heigth=6;
camera_pad_heigth=holder_pad_heigth+1.5;

	translate([0, 0, 0]) {
		difference() {
			translate([0, 0, thin/2]) roundedBox([plate_width, plate_width, thin], 2, true);
			translate([0, (plate_width-9.5)/2, thin/2]) cube([9.5, 9.6, thin*2], center=true);
			for (x=[-1,1]) {
				for (y=[-1,1]) {
					translate([x*plate_width_fixing_hole/2, y*plate_width_fixing_hole/2-holder_pad_offset, 5/2]) cylinder(d=hole_dia, h=20, center=true);	
				}
			}
		}
		for (x=[-1,1]) {
			for (y=[-1,1]) {
				// holder pad
				translate([x*plate_width_fixing_hole/2, y*plate_width_fixing_hole/2-holder_pad_offset, holder_pad_heigth/2]) pad(5, holder_pad_heigth);
				// camera pad
				translate([x*camera_width_fixing_hole/2, y*camera_width_fixing_hole/2, camera_pad_heigth/2]) pad(4.5, camera_pad_heigth);
			}
		}
	}
}

module sony_camera_bracket(thin=0.6)
{
camera_width=32.19;	
plate_width=33;
camera_width_fixing_hole=28;
plate_offset_fixing_hole=12;
plate_width_fixing_hole=18;
hole_dia=1.8;
holder_pad_offset=7;
holder_pad_heigth=6;
camera_pad_heigth=holder_pad_heigth+1.5+thin+2.5+3.68;
connector_depth = 5.1;

	module plate(d=5, h=1.8)
	{
		translate([0, 0, 0.2/2]) roundedBox([plate_width, plate_width, 0.2], 2, true);
		translate([0, 0, thin/2]) roundedBox([20, 20, thin], 2, true);
		for (x=[-1,1]) {
			//translate([x*plate_width_fixing_hole/2, plate_offset_fixing_hole-camera_width_fixing_hole/2, 1]) rotate([0,0,0]) cylinder(d=5, h=2, center=true);
			hull() {
				translate([x*(camera_width_fixing_hole)/2, 1*camera_width_fixing_hole/2, h/2]) cylinder(d=d, h=h, center=true);
				//translate([-x*camera_width_fixing_hole/2, -1*camera_width_fixing_hole/2, h/2]) cylinder(d=d, h=h, center=true);
				translate([x*(plate_width_fixing_hole-5)/2, plate_offset_fixing_hole-camera_width_fixing_hole/2, h/2]) rotate([0,0,0]) cylinder(d=d, h=h, center=true);
			}
			hull() {
				translate([x*(camera_width_fixing_hole)/2, -1*camera_width_fixing_hole/2, h/2]) cylinder(d=d, h=h, center=true);
				//translate([-x*camera_width_fixing_hole/2, -1*camera_width_fixing_hole/2, h/2]) cylinder(d=d, h=h, center=true);
				translate([x*(plate_width_fixing_hole-5)/2, plate_offset_fixing_hole-camera_width_fixing_hole/2, h/2]) rotate([0,0,0]) cylinder(d=d, h=h, center=true);
			}
		
		}
		hull() {
			translate([1*plate_width_fixing_hole/2, plate_offset_fixing_hole-camera_width_fixing_hole/2, h/2]) rotate([0,0,0]) cylinder(d=d+1, h=h, center=true);
			translate([-1*plate_width_fixing_hole/2, plate_offset_fixing_hole-camera_width_fixing_hole/2, h/2]) rotate([0,0,0]) cylinder(d=d+1, h=h, center=true);
		}
	}
	module camera_pad(d, h)
	{
		for (x=[-1,1]) {
			for (y=[-1,1]) {
				translate([x*camera_width_fixing_hole/2, y*camera_width_fixing_hole/2, h/2]) cylinder(d=d, h=h, center=true);
			}
		}
	}
	module plate_pad(d, h)
	{
		for (x=[-1,1]) {
			for (y=[-1,1]) {
				translate([x*plate_width_fixing_hole/2, y*plate_width_fixing_hole/2-holder_pad_offset, h/2]) cylinder(d=d, h=h, center=true);
			}
		}
	}
	module top_plate()
	{
		difference() {
			union(){
				translate([0, 0, thin/2]) roundedBox([plate_width, plate_width, thin], 2, true);
				camera_pad(d=4.5, h=3.7);
			}
			translate([0, 0, thin/2]) cube([16.3, 16.3, thin*2], center=true);
			translate([0, 0, -1]) camera_pad(d=2.6, h=20);
		}
		
	}
	module main_plate() {
		difference() {
			union(){
				plate();
				camera_pad(d=4.5, h=camera_pad_heigth);
				camera_pad(d=5.5, h=camera_pad_heigth-2);
				//camera_pad(d=4.5, h=camera_pad_heigth);
				//plate_pad(d=4.5, h=holder_pad_heigth);
				//translate([0, plate_offset_fixing_hole-camera_width_fixing_hole/2, 1]) rotate([0,0,0]) cube([plate_width,5,2], center=true);
//				for (x=[-1,1]) {
//					translate([x*plate_width_fixing_hole/2, plate_offset_fixing_hole-camera_width_fixing_hole/2, 1]) rotate([0,0,0]) cylinder(d=5, h=2, center=true);
//				}
			}
			for (x=[-1,1]) {
				translate([x*plate_width_fixing_hole/2, plate_offset_fixing_hole-camera_width_fixing_hole/2, 1]) rotate([0,0,0]) cylinder(d=2, h=plate_width, center=true);
			}
			//translate([(-9-camera_width)/2+13.6, (camera_width-connector_depth+5)/2, thin/2]) cube([9, connector_depth+5, thin*2], center=true);
			//translate([(-camera_width+connector_depth-6)/2, (-9-camera_width)/2+13.6, thin/2]) cube([connector_depth+5, 9, thin*4], center=true);
			translate([0, 0, -1]) {
				camera_pad(d=hole_dia, h=20);
				//plate_pad(d=hole_dia, h=20);
			}
		}
	}
	translate([0, 0, 0]) main_plate();
	//translate([0, -50, 0]) top_plate();
}

translate([40, 0, 0]) eachine_camera_bracket();
translate([0, 0, 0]) sony_camera_bracket();