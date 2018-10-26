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

module motor_tilt(rot=0, rside=0)
{
	heigth=8;
	module plain()
	{
		dia = 28;
		module hole()
		{
			translate([0, 0, -1]) difference()
			{
					translate([0, 0, 0]) cylinder(d=40, h=50, center=true);
					translate([0, 0, -1]) cylinder(d=28, h=50, center=true);
				
			}
		}
		
		difference()
		{
			translate([0, 0, 0.5])  hull()
			{
				cylinder(d=dia, h=1, center=true);
				translate([0, 0, heigth]) rotate([forward_tilt, rside*inner_tilt, 0]) cylinder(d=dia, h=1, center=true);
				
			}
			//hole();
		}
	}
	module hole()
	{
//		M3_hexa = 6.1;
//		M3_hole = 3.6;
//		M3_head_hole = 4.6;

//		M2_hexa = 5.3;
//		M2_hole = 2.6;
//		M2_head_hole = 4.4;
		
		M25_hexa = 5.4;
		M25_hole = 2.9;
		M25_head_hole = 5.2;

		
		rot2 =  (rot*rside < 0) /* bogus > */ ? rot+270 : rot+90; 
		rotate([forward_tilt, 0, 0]) rotate([0, rside*inner_tilt, 0]) rotate([0, 0, rot2])  translate([0, 0, -7]) 	hull() {
			translate([19.5/2, 0, 0])   cylinder(d=4.6, h=20, center=false);
			translate([30.5/2, 0, 0])   cylinder(d=5.6, h=20, center=false);
		}
		
			
		for(n=[0, 180])
		{
			rotate([0, 0, n+rot-45]) {
			
				translate([18/2, 0, 0]) { 
					translate([0, 0, 5]) cylinder(d=M25_hole, h=10.5, center=true);

					translate([0, 0, 1.8]) rotate([0, 0, 30])  hexaprismx(ri=(M25_hexa)/2, h=10);
					//translate([0, 0, 1.8]) rotate([0, 0, 30])  hexaprismx(ri=M25_hexa/2, h=2);
					translate([0, 0, 1.8+3]) rotate([0, 0, 30])  hexaprismx(ri=(M25_hexa+0.3)/2, h=10);
					
				}
			}
			
		}
		for(n=[0, 180])
		{
			translate([0.5, 1.3, 0]) {
				
				rotate([forward_tilt, rside*inner_tilt, 0]) translate([-0.5, 0, 0])   {
		//#translate([0, 0, 9])   cylinder(d=28, h=12, center=false);
					// motor center hole
					translate([0, 0, 0])  cylinder(d=7, h=20.5, center=true);
					rotate([0, 0, n+rot+45]) translate([0, 0, 0])  {
						// hole screw
						translate([16/2, 0, 0]) cylinder(d=M25_hole, h=20.5, center=true);
						// head screw
						translate([16/2, 0, -5.9-2.2]) cylinder(d=M25_head_hole, h=15, center=false);
						
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
module roundCornersCube(x,y,z,r)  // Now we just substract the shape we have created in the four corners
{
	module createMeniscus(h,radius) // This module creates the shape that needs to be substracted from a cube to make its corners rounded.
	{
		difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
		   translate([radius/2+0.1,radius/2+0.1,0]){
		      cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
		   }
		
		   cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
		}
	
	}
	difference(){
	   cube([x,y,z], center=true);
	
	translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
	      rotate(0){  
	         createMeniscus(z,r); // And substract the meniscus
	      }
	   }
	   translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
	      rotate(90){
	         createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
	      }
	   }
	      translate([-x/2+r,-y/2+r]){ // ... 
	      rotate(180){
	         createMeniscus(z,r);
	      }
	   }
	      translate([x/2-r,-y/2+r]){
	      rotate(270){
	         createMeniscus(z,r);
	      }
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


module arm(heigth=3)
{
	M3_hole = 3.5;
	arm_lenght = 94;
	arm_width = 24;
	
	module plain()
	{
		translate([-arm_width/2, 0, 0]) 
		{
			translate([0, -5, 0]) rotate([0, 0, 0]) cube([arm_width, arm_lenght, heigth]);
		}
		translate([0, 88, heigth/2]) cylinder(d=28, h=heigth, center =true);  	
	}
	module hole()
	{
		translate([-arm_width/2, 0, 0]) 
		{
			translate([arm_width/2-7, 0, -1]) cylinder(d=M3_hole, h=10);
			translate([arm_width/2+7, 0, -1]) cylinder(d=M3_hole, h=10);
		}
		translate([0, 88, 0])
		{
			for(r=[0, 90, 180, 270]) {
				rotate([0, 0, r+45]) {
					hull() {
						translate([16/2, 0, -1])cylinder(d=2, h=10);	
						translate([12/2, 0, -1]) cylinder(d=2, h=10);
					
					}
				}
				rotate([0, 0, r]) {
					hull() {
						translate([16/2, 0, -1])cylinder(d=M3_hole, h=10);	
						translate([19/2, 0, -1]) cylinder(d=M3_hole, h=10);
					
					}
				}
				
			}
		}
	}
	module arm_pos()
	{
		translate([27.7, 49.8, 9]) rotate([0, 0, -65]) armx();
	}
	difference()
	{
		plain();
		hole();
	}
}

module full_view()
{
	translate([27.7, 49.8, -3.2]) rotate([0, 0, -45]) arm();
	translate([-27.7, 49.8, -3.2]) rotate([0, 0, 45]) arm();
	translate([27.7, -49.8, -3.2]) rotate([0, 0, -135]) arm();
	translate([-27.7, -49.8, -3.2]) rotate([0, 0, 135]) arm();
	
	
	//translate([0, 88, 0]) motor_tilt(rot=0);
	
	// forward
	translate([27.7, -49.8, 0]) rotate([0, 0, -115]) translate([0, 88, 0]) rotate([0, 0, 115]) motor_tilt(rot=65, rside=1);
	translate([-27.7, -49.8, 0]) rotate([0, 0, 115]) translate([0, 88, 0]) rotate([0, 0, -115]) motor_tilt(rot=-65, rside=-1);



	// backward
	translate([27.7, 49.8, 0]) rotate([0, 0, -65]) translate([0, 88, 0]) rotate([0, 0, 65]) motor_tilt(rot=-65, rside=1);
	translate([-27.7, 49.8, 0]) rotate([0, 0, 65]) translate([0, 88, 0]) rotate([0, 0, -65]) motor_tilt(rot=65, rside=-1);
	
	//
	//
	//translate([0, -0, 0]) calibration_stand();
	
}

module motor_holder()
{
	// forward
	translate([20, -20, 0]) motor_tilt(rot=90, rside=1);
	translate([-20, -20, 0]) motor_tilt(rot=-90, rside=-1);

	// backward
	translate([20, 20, 0]) motor_tilt(rot=-45, rside=1);
	translate([-20, 20, 0]) motor_tilt(rot=45, rside=-1);
	
	
	translate([0, 80, 0]) calibration_stand();
}

motor_holder();
//full_view();
//translate([20, -20, 0]) motor_tilt(rot=65, rside=1);

//translate([0, -0, 0]) calibration_stand();
