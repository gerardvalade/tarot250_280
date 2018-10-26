// AfrominiBracket - a OpenSCAD 
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


// AfrominiBracket - a OpenSCAD 
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
//         type, len,   width, heigth, pad_x pad_y
FRSKY_D4FR = [1,  26,    18,   5+1.5,     47,  25];
FRSKY_D4R  = [2,  31,    23.0,   7,     47,  25];
FRSKY_V8R4 = [3,  29.5,  19.2,   8,     47,  25];
function is_FRSKY_D4FR() = receiver_type[0] == FRSKY_D4FR[0];
function is_FRSKY_D4R() = receiver_type[0] == FRSKY_D4R[0];
function is_FRSKY_V8R4() = receiver_type[0] == FRSKY_V8R4[0];
function receiver_lenth() = receiver_type[1];
function receiver_width() = receiver_type[2];
function receiver_heigth() = receiver_type[3] + 4.8; 
function receiver_pad_x() = receiver_type[4]; 
function receiver_pad_y() = receiver_type[5]; 

receiver_type = FRSKY_D4FR;
//receiver_type = FRSKY_D4R;
//receiver_type = FRSKY_V8R4;

plate_wx = 33 + 16.5 + 7;
plate_wx_extra = 12;
plate_wy = 34;
hole_x = -plate_wx_extra;
hole_width = 30.30;
hole_x0 = -plate_wx_extra;
hole_x1 = hole_x0 + 18.50;
hole_x2 = hole_x1 + 6*8;
hole_length = 18.50+5*8;
alarm_pos_x = 47.5;
alarm_pad_width =receiver_type[5];// hole_width-3.5;
	
show_module = 1;


module afromini32()
{
	module connector()
	{
		translate([0, -7.5, 0]) color([0.2, 0.2, 0.2]) cube([2.5, 15, 7.48], center=false);
		translate([0, 0, 0]) color([0.9, 0.8, 0.2])
			for (y=[0:5]) {
				for (z=[0:2]) {
				translate([0, y*2.54-6.5, z*2.5+1.25]) rotate([0, 90, 0]) cylinder(d=.6, h=8.5);
				}
			}
		
	}

	translate([0, 0, 0.425]) {
		color([0.4, 0.7, 0.4]) cube([33.10, 16.53, 0.85], center=true);
		translate([16,0,0]) connector();
	}
	
}


module frskyV8R4($fn = 4, len=29, heigth=8)
{
	module connector()
	{
		color([0.2, 0.2, 0.2]) cube([2.5, 15, 5], center=false);
		translate([0, 1, 1]) color([0.9, 0.8, 0.2])
			for (y=[0:5]) {
				translate([0, y*2.54, 0]) rotate([0, 90, 0]) cylinder(d=.6, h=8.5);
				translate([0, y*2.54, 2.54]) rotate([0, 90, 0]) cylinder(d=.6, h=8.5);
			}
		
	}

	translate([0, 0, heigth/2]) color([0.6, 0.4, 0.4]) cube([len, 19, heigth], center=true);
	translate([len/2, -heigth, 2]) connector();

}

module frskyD4R($fn = 4, len=31.12, width=23.16, heigth=7.34) 
{
	module connector()
	{
		color([0.2, 0.2, 0.2]) cube([2.5, 15, 5], center=false);
		translate([0, 1, 1]) color([0.9, 0.8, 0.2])
			for (y=[0:5]) {
				translate([0, y*2.54, 0]) rotate([0, 90, 0]) cylinder(d=.6, h=8.5);
				translate([0, y*2.54, 2.54]) rotate([0, 90, 0]) cylinder(d=.6, h=8.5);
			}
		
	}
	module telemetryPort()
	{
		color([0.9,0.9,0.9])
		difference() { 
			cube([7.5, 4.5, 3.0], center=true);
			cube([7, 5, 2.5], center=true);
		
		}
		color([0.9, 0.8, 0.2]) for (x=[0:3]) {
			translate([x*1.25-1.9, 2.8, 0]) rotate([90, 0, 0]) cylinder(d=.5, h=5);
		}
		
	}

	difference() {	
		translate([0, 0, heigth/2]) color([0.6, 0.4, 0.4]) cube([len, width, heigth], center=true);
		translate([11.9, -9.5, 6.0]) 
				cube([7.5, 4.5, 3.0], center=true);
	}
	translate([11.9, -9.5, 6.0]) telemetryPort();	
	translate([len/2, -heigth, 2]) connector();

}


module frskyD4FR($fn = 4)
{
	module connector()
	{
		color([0.2, 0.2, 0.2]) cube([2.5, 15, 5], center=false);
		translate([0, 1, 1]) color([0.9, 0.8, 0.2])
			for (y=[0:5]) {
				translate([0, y*2.54, 0]) rotate([0, 90, 0]) cylinder(d=.6, h=8.5);
				translate([0, y*2.54, 2.54]) rotate([0, 90, 0]) cylinder(d=.6, h=8.5);
			}
		
	}

	difference() {	
		translate([0, 0, 0.5]) color([0.7, 0.4, 0.4]) cube([26.31, 18.74, 1], center=true);
	}
	translate([26.31/2, -7.34, 1]) connector();

}

module alarm()
{
	translate([0, 0, 2])  color([0.8, 0.0, 0.0])cube([32, 19.5, 4], center=true);
}
	
module afromini_bracket(thin=1)
{
	module fixing_receiver(y, d, h)
	{
		translate([0, 0, receiver_heigth()/2+4]) 
		difference() {
			translate([0,0,0]) cylinder(d=d, h=h, center=true);
		 	translate([0, y*2.3, -h/2-.4]) rotate([45,0,0]) cube([8, 6, 6], center=true);
		}
		
	}
	
	module back_receiver_pad(y, d, h)
	{
		translate([0, 0, receiver_heigth()/2+3]) 
		difference() {
			translate([0, 0, 0]) cylinder(d=4.5, h=receiver_heigth()+6, center=true);
		 	translate([0,0,0]) cylinder(d=2.2, h=receiver_heigth()+7, center=true);
		}
	}
	module back_up_receiver_pad(y, d, h)
	{
		translate([0, 0, receiver_heigth()/2+6]) 
		difference() {
			hull() {
				translate([0,0,0]) cylinder(d=d, h=h, center=true);
				translate([0, -y*2, 0]) cylinder(d=d, h=h, center=true);
			}
		 	translate([0, y*2.3, -h/2-.4]) rotate([45,0,0]) cube([8, 6, 6], center=true);
		 	translate([0,0,0]) cylinder(d=2.2, h=h+1, center=true);
		}
	}
	module front_receiver_pad(y, d, h)
	{
		translate([0, 0, receiver_heigth()/2+6]) 
		difference() {
			union() {
				translate([0, 0, 0]) cylinder(d=4.5, h=receiver_heigth(), center=true);
				hull() {
					translate([0, 0, -3.5]) cylinder(d=4.5, h=5, center=true);
					translate([0, -y*2, -3.5]) cylinder(d=4.5, h=5, center=true);
				}
			}
		 	translate([0,0,0]) cylinder(d=2.2, h=h+1, center=true);
		}
	}
	module bloc_plus()
	{
		// main plate
		translate([(plate_wx)/2-0.5, 0, thin/2]) cube([plate_wx, plate_wy, thin], center=true);
		translate([(-plate_wx_extra)/2-0.5, 0, thin/2]) cube([plate_wx_extra, plate_wy, thin], center=true);
		
		// voltage alarm
		translate([alarm_pos_x+35/2, 0, thin/2]) cube([35, 25.5, thin], center=true);
		
		for (y=[-1,1]) {
			// voltage regulator, osd
			translate([17+14, y*(12.1+3.9+.5), 2.5]) cube([48, 1, 5], center=true);
			
			
			// afromini
			translate([-plate_wx_extra+10.5, y*(7.75+1), 6]) cube([21, 2, 12], center=true);
			
			// frsky
			translate([31, y*(10.6-1.9), 10.8]) rotate([45,0,0]) cube([29, 1.8, 1.8], center=true);
	
			translate([17+14, y*(8.65+1-0.1), 7]) cube([29, 3.8, 14], center=true);
	
			// voltage alarm pads
			for (x=[10, 27])  {
				translate([alarm_pos_x+x, y*(alarm_pad_width/2), 5.5]) cylinder(d=4.5, h=11, center=true);
				translate([alarm_pos_x+x, y*(3+19.7)/2, 3.5]) cube([4, 3, 7], center=true);
			}
			
			// pads	
			for (x=[hole_x1, hole_x2]) {
				translate([x, y*(hole_width/2), 3.5]) cylinder(d=4.5, h=7, center=true);
			}
			if (is_FRSKY_D4R()) translate([47-4.3, y*11, 0]) rotate([0, 0, 0]) fixing_receiver(y, d=4.8, h=6);
			
		}
	
	}
	module bloc_extra()
	{
		for (y=[-1,1]) {
			translate([hole_x1, y*(receiver_pad_y()/2), 0]) rotate([0, 0, 0]) front_receiver_pad(y, d=4.5, h=receiver_heigth());
			translate([receiver_pad_x(), y*(receiver_pad_y()/2), 0]) rotate([0, 0, 0]) back_receiver_pad(y, d=4.5, h=receiver_heigth());
		}
		
	}
	module bloc_minus()
	{
		
		// voltage regulator
		for (y=[-1,1]) translate([29, y*13.5, 8+1]) cube([28, 5.5, 16], center=true);
		
		translate([10, 0, -1]) hull()
		{
			translate([0, 0, 0]) cylinder(d=8, h=thin+2);
			translate([35, 0, 0]) cylinder(d=8, h=thin+2);
		}
		translate([alarm_pos_x+14.5, 0, -1]) hull()
		{
			translate([0, 0, 0])  cylinder(d=10, h=thin+2);
			translate([10, 0, 0]) cylinder(d=10, h=thin+2);
		}
		//afromini connector 6 pins
		for (y=[-1,1]) translate([39, y*7.2, 0]) rotate([0, 90, 0]) hull()
		{
			translate([-3.5, 0, 0])  cylinder(d=2, h=16, center=true);
			translate([-7.5, 0, 0]) cylinder(d=2, h=16, center=true);
		}
		
		// afromini
		translate([0, 0, 4]) rotate([0, 90, 0]) hull()
		{
			// front
			for (i=[-1,1]) translate([0, i*(7.8), 6]) cylinder(d=1.6, h=18, center=true);
			// back
			for (i=[-1,1]) translate([0, i*(7.8), 22]) cylinder(d=1.4, h=50, center=true);
		}
		
		// frsky receiver
		translate([-receiver_lenth()/2 + 45.55, 0, 11+7.5/2]) cube([receiver_lenth(), receiver_width(), 7.5], center=true);
		translate([-receiver_lenth()-1.9 + 45.5, 0, 11+7.5/2]) cube([4, receiver_width(), 7.5], center=true);
		translate([-receiver_lenth()-20/2 + 45.5, 0, 11+7.5/2]) cube([20, 16, 7.5], center=true);
	
		
		// hole's pads
		for (y=[-1,1]) {
			translate([hole_x0+7, y*((plate_wy-3)/2), 8]) cube([16, 3.5, 16.1], center=true);
			for (x=[hole_x1, hole_x2]) {
				translate([x, y*((plate_wy+2)/2), 3.5]) cube([8.1, 2, 8], center=true);
				translate([x, y*(hole_width/2), 3.5]) cylinder(d=2.2, h=6.1+thin, center=true);
			}
			// alarm hole's pads
			for (x=[10, 27]) 
				translate([alarm_pos_x+x, y*(alarm_pad_width)/2, 5]) cylinder(d=2.2, h=15+thin, center=true);
			
		}
	}
	translate([0, 0, 0])  {
		 color([0.9, 0.9, 0.9]) difference() {
			bloc_plus();
			bloc_minus();
		}
		bloc_extra();
		if (show_module)
			translate([63, 0, thin]) alarm();
		
	}
	
}

module alarm_holder(length=alarm_pad_width)
{
	difference(){
		union() {
			translate([0, 0, 1]) cube([5.5, length, 2], center=true);
			for (y=[-1,1]) {
				translate([0, y*length/2, 1]) cylinder(d=5.5, h=2, center=true);
			}
	
		}
		for (y=[-1,1]) {
			translate([0, y*length/2, 4.55]) cylinder(d=2.6, h=10, center=true);
			//#translate([0, y*((plate_wy+2)/2), 3.5]) cube([8.1, 2, 8], center=true);
		}
	}
}

module receiver_holder()
{
	alarm_holder();
	if (is_FRSKY_D4FR())
	{
		translate([-5, 0, 1]) cube([10, 4, 2], center=true);
		translate([-8, 0, -0.5]) cube([4, 4, 5], center=true);
	}
}

module transmitter_holder()
{
	alarm_holder(length=32);
}


module transmitter_bracket(length= 35, width = 27, thick = 1.5)
{
	
	offset = 5;
	heat_sink_heigth = 0;
	pad_heigth = 7.26+heat_sink_heigth;
	module transmitter(length = 25.3, width=20.25)
	{
		hf=3.79;
		color([0.5, 0, 0]){
			translate([2, 0, hf/2+heat_sink_heigth]) cube([19.3, 18.5, hf], center=true);
			translate([2, 0, heat_sink_heigth/2]) cube([20, 20, heat_sink_heigth], center=true);
			translate([0, 0, hf+thick/2+heat_sink_heigth]) {
				cube([length, width, thick], center=true);
				translate([-(length+3.24)/2, (width-9)/2, 0]) cube([3.24, 9, thick], center=true);
			}		
		}
	}
	
	difference(){
		union() {
			translate([0, 0, thick/2]) cube([length, width, thick], center=true);
			if (heat_sink_heigth==0)
				for (y=[-1,1]) {
					translate([0, y*(19+1.5)/2+2.5, (thick+1.5)/2]) cube([22, 1.5, thick+1.5], center=true);
				}
			translate([0, -width/2, 0]) {
				translate([0, 0, 3]) {
					translate([length/2, 19, 0]) cylinder(d=5.5, h=6, center=true);
					for (x=[-1,1]) {
						translate([x*length/2, 0, 0]) cylinder(d=5.5, h=6, center=true);
					}
				}
				for (x=[-1,1]) {
					translate([x*(32)/2, 8+offset, pad_heigth/2]) cylinder(d=5.5, h=pad_heigth, center=true);
				}
			}
	
		}
		translate([0, -width/2, 0]) {
			translate([0, 6.5/2-1.55, thick/2]) cube([16, 6.55, thick+2], center=true);
			translate([0, 0, 0]) {
				translate([length/2, 19, 3]) cylinder(d=2.2, h=10, center=true);
				for (x=[-1,1]) {
					translate([x*length/2, 0, 3]) cylinder(d=2.2, h=10, center=true);
				}
			}
			for (x=[-1,1]) {
				translate([x*(32)/2, 8+offset, pad_heigth/2]) cylinder(d=2.2, h=pad_heigth+1, center=true);
			}
		}
	}
	if(show_module) 
	{
		translate([0, offset/2, thick]) transmitter();
		translate([0, -0.5, 8]) rotate([0,0,90]) transmitter_holder(length =32);
		
	}
}


module upper_module_holder(width=25, thin=2)
{
	dia = 4.8;
	plate_length = 25;
	length=receiver_pad_x()-6.5;
	module holder(x, y, dia=dia)
	{
		difference() {
			union() {
				for (i=[-1,1]) {
					hull()
					{
						translate([0, i*receiver_pad_y()/2, 1]) cylinder(d=dia, h=2, center=true);
						translate([x, i*y, 1]) cylinder(d=dia, h=2, center=true);
					}
					hull()
					{
						translate([0, i*receiver_pad_y()/2, 1]) cylinder(d=dia, h=2, center=true);
						translate([x, i*y, 1]) cylinder(d=dia, h=2, center=true);
					}
				}
		
			}
			for (y=[-1,1]) {
				translate([0, y*receiver_pad_y()/2, 4.55]) cylinder(d=2.6, h=10, center=true);
			}
		}
	}
	module plate(heigth=7) {
		translate([-length/2, 0, thin/2]) {
			translate([2, 0, 0]) cube([22, width+3.2, thin], center=true);
			
			for(y=[-1,1]) {
				translate([10, y*(16.5+1.6)/2, (heigth-thin)/2]) cube([4, 1.6, heigth], center=true);
				translate([-7, y*(16.5+1.6)/2, (heigth-thin)/2]) cube([4, 1.6, heigth], center=true);
				
				translate([0, y*(width+3.2)/2, (heigth-thin)/2]) cube([length-dia, 1.6, heigth], center=true);
				
				translate([1, y*receiver_pad_y()/2, (heigth-thin)/2]) cylinder(d=dia, h=heigth, center=true);
			}
		}
	}
	difference() { 
		union() {
			plate();
			translate([0, 0, 0]) holder(-length+10, receiver_pad_y()/2);	
			translate([-length, 0, 0]) holder(length-10, receiver_pad_y()/2);	
			translate([0, 0, 0]) holder(0, 0, 2.5);
			translate([-length, 0, 0]) holder(0, 0, 2.5);
		}
		translate([0, 0, 0.5]) cube([dia+1, 3, thin*2], center=true);
		translate([-length, 0, 0.5]) cube([dia+1, 3, thin*2], center=true);
		for (y=[-1,1]) {
			translate([-length/2+1, y*receiver_pad_y()/2, 3]) cylinder(d=2.2, h=10, center=true);
		}
	}	
	if (show_module)
		translate([-length/2, 0, 5]) color([0.8, 0.0, 0.0]) cube([15.5, 15.5, 5.5], center=true);
}

module micro_osd_holder(width=20, thin=2)
{
	length = 13+12;
	ext_dia = 8.5;
	int_dia = 4.6;
	difference() {
		union() {
			
			translate([0, 0, 0]) {
				translate([0, 0,thin/2]) cube([length, width+8, thin], center=true);
			}
			for(x=[-1,1]) {
				translate([x*6.5, 0, ext_dia/2+1]) rotate([90, 0,0]) cylinder(d=ext_dia, h=7.5, center=true);
				translate([0, x*(width/2+3), 3]) rotate([0, 0,0]) cylinder(d=4.5, h=6, center=true);
			}
		}
		for(x=[-1,1]) {
			hull() {
				translate([x*6.5, 0, ext_dia/2+1]) rotate([90, 0,0]) cylinder(d=int_dia, h=33, center=true);
				translate([x*6.5, 0, ext_dia/2+5]) rotate([90, 0,0]) cylinder(d=int_dia, h=33, center=true);
			}
			translate([0, x*(width/2+3), 0]) rotate([0, 0,0]) cylinder(d=2.2, h=33, center=true);
		}
		
	}
}

module tarotTL250()
{
	length=119;
	width=34.62; 
	thick=0.1;
	
	module square(l, w)
	{
		difference() {
			cube([l, w, thick], center=true);
			cube([l-2, w-2, thick+2], center=true);
		}
	}

	translate([length-34/2+8, 0, 16]) square(34, width, thick);
	
	translate([length-61/2-26, 0, 30]) square(61, width);
	
	translate([length-13/2 -26 -61 +1.8 , 0, 30-4.5]) rotate([0,-45,0] )square(13, width);
	
	color([0.6, 0.3, 0]) {
		translate([length-102-32, 0, -38+4.5/2]) 	rotate([90, 0, 0])	cylinder(d=4.5, h=width, center=true);
		translate([length-96, 0, 22]) {
			rotate([90, 0, 0]) {
				cylinder(d=4.5, h=width, center=true);
				translate([9.2, 9.2, 0]) cylinder(d=4.5, h=width, center=true);
			}
		}
	
		for (y=[-1,1]) {
			pos  = length-13;
			translate([pos, y*34/2, -38/2])	cylinder(d=4.5, h=38, center=true);
			pos2 = length-13-99.5-4.5;
			translate([pos2, y*8.5/2, -38/2]) cylinder(d=4.5, h=38, center=true);
		}
	}
	
	difference() {
		union() {
			translate([length/2, 0, 0]) cube([length, width, thick], center=true);
			l= 18;
			translate([(length-l)/2, 0, -38]) cube([length+l, width, thick], center=true);
		
		}
		for (y=[-1,1]) {
			for (x=[length-102]) {
				hull() 
				{
					translate([x-1, y*(hole_width/2), 0]) cylinder(d=2.2, h=1+thick, center=true);
					translate([x+1, y*(hole_width/2), 0]) cylinder(d=2.2, h=1+thick, center=true);
				}
			}
			for (x=[0:6]) {
				pos = length-36-x*8;
				hull() {
					translate([pos-1, y*(hole_width/2), 0]) cylinder(d=2.2, h=1+thick, center=true);
					translate([pos+1, y*(hole_width/2), 0]) cylinder(d=2.2, h=1+thick, center=true);
				}
			}
		}
	}
	
}

if (show_module) {
	translate([0, 0, 0]) afromini_bracket();
	
	translate([13, 0, 3.5]) rotate([0,0,180]) afromini32();
	if (is_FRSKY_D4FR()) {
		translate([31, 0, 11]) rotate([0,0,180]) frskyD4FR();
	}
	if (is_FRSKY_D4R()) {
		translate([29.5, 0, 11]) rotate([0,0,180]) frskyD4R();
	}
	if (is_FRSKY_V8R4()) {
		translate([30, 0, 11]) rotate([0,0,180]) frskyV8R4();
	}
	
	translate([alarm_pos_x+10, 0, 11.5]) rotate([0,0,0]) alarm_holder();
	
	translate([receiver_pad_x(), 0, receiver_heigth()+6.5])  upper_module_holder();
	
	if (show_module==2) translate([3, 0, 22]) rotate([0, -45, 0]) micro_osd_holder();

	
	if (show_module==2) translate([-28.5, 0, 0]) tarotTL250();
	translate([35, 0, 30]) rotate([0,0,180])  transmitter_bracket();
	
} else {
	translate([0, 0, 0]) color([0.9, 0.9, 0.9]) afromini_bracket();
	
	translate([70, 30, 0]) rotate([0,0,90]) alarm_holder();
	translate([70, 40, 0]) rotate([0,0,90]) alarm_holder();
	translate([70, 50, 2]) rotate([0,180,90]) receiver_holder();
	translate([70, 70, 0]) rotate([0,0,90]) transmitter_holder(length =32);
	
	translate([40, 40, 0]) upper_module_holder();
	
	translate([-30, 40, 0]) transmitter_bracket();
	
}
 

 
