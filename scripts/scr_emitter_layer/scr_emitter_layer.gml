// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EmitterLayer(_emitter = undefined) constructor{
	
	//Emitter Information
	name ="Emitter_1"
	width = 96.000
	height = 96.000
	shape = "Ellipse"
	distribution = "Linear"
	particle_count = 1
	stream = true

	//Particle Shape Values
	shape_selected = shape_items[0];

	//Sprite Information
	sprite_file = undefined;
	sprite_subframe_val = 0;
	sprite_remove_background = true;
	sprite_smooth = true;
	sprite_x_origin = 0;
	sprite_y_origin = 0;

	//Sprite Particle Information
	sprite_animated = false;
	sprite_stretched = false;
	sprite_random_frame = false;

	//Particle Alpha Values
	part_alpha_min = random_range(0.000,1.000);
	part_alpha_mid = random_range(0.000,1.000);
	part_alpha_max = random_range(0.000,1.000);

	//Particle Size Values
	part_size_min		= random_range(-5.000,5.000);
	part_size_max		= random_range(-5.000,5.000);
	part_size_increase	= random_range(-5.000,5.000);
	part_size_wobble	= random_range(-5.000,5.000);

	//Particle Scale Values
	part_scale_h = random_range(0.000,5.000);
	part_scale_v = random_range(0.000,5.000);

	//Particle Lifetime Values
	part_lifetime_min = random_range(0.000,300.000);
	part_lifetime_max = random_range(0.000,300.000);

	//Particle Speed Values
	part_speed_min		= random_range(-5.000,5.000);
	part_speed_max		= random_range(-5.000,5.000);
	part_speed_increase	= random_range(-5.000,5.000);
	part_speed_wobble	= random_range(-5.000,5.000);

	//Particle Direction Values
	part_direction_min		= random_range(0.000,359.000);
	part_direction_max		= random_range(0.000,359.000);
	part_direction_increase	= random_range(-5.000,5.000);
	part_direction_wobble	= random_range(-5.000,5.000);

	//Particle Orientation Values
	part_orientation_min		= random_range(0.000,359.000);
	part_orientation_max		= random_range(0.000,359.000);
	part_orientation_increase	= random_range(-5.000,5.000);
	part_orientation_wobble		= random_range(-5.000,5.000);

	//Particle Gravity Values
	part_gravity_amount		= random_range(0.000,15.000);
	part_gravity_direction	= random_range(0.000,359.000);

	// Particle Colors
	// Additive
	part_additive = "No";

	//Color Types
	part_color_type = "Gradient";

	part_color_a = irandom_range(c_white,c_black)//color a and color start
	part_color_b = irandom_range(c_white,c_black)//color b and color middle
	part_color_c = irandom_range(c_white,c_black)//color end
	
}