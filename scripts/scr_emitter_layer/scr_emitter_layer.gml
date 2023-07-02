global.emitter_layers = [];
/**
 * Function Description
 * @param {Struct} [_emitter] Description
 */
function EmitterLayer(_emitter = undefined) constructor{
	
	//Emitter
	static emitter_shapes = [
		{key:0, name:"Diamond",	 value:0},
		{key:1, name:"Ellipse",	 value:1},
		{key:2, name:"Line",	 value:2},
		{key:3, name:"Rectangle",value:3}
	]
	
	static emitter_distributions = [
		{key:0, name:"Linear",			value:0},
		{key:1, name:"Gaussian",		value:1},
		{key:2, name:"Inverse Gaussian",value:2}
	]
	
	 //Particle Shape Values
	static part_shape_items = [
		{key:0,  name:"Pixel",	  value:0},
		{key:1,  name:"Disk",	  value:1},
		{key:2,  name:"Square",	  value:2},
		{key:3,  name:"Line",	  value:3},
		{key:4,  name:"Star",	  value:4},
		{key:5,  name:"Circle",	  value:5},
		{key:6,  name:"Ring",	  value:6},
		{key:7,  name:"Sphere",	  value:7},
		{key:8,  name:"Flare",	  value:8},
		{key:9,  name:"Spark",	  value:9},
		{key:10, name:"Explosion",value:10},
		{key:11, name:"Cloud",	  value:11},
		{key:12, name:"Smoke",	  value:12},
		{key:13, name:"Snow",	  value:13},
		{key:-1, name:"Sprite",	  value:-1}//always last
	]
	// Additive
	static part_additive_items = [
		{key:0, name:"no",  value: false},
		{key:1, name: "yes",value: true }
	]
	
	//Color Types
	static part_color_type_items = [
		{key:0, name:"Gradient",value: "Gradient"},
		{key:1, name:"Mix",		value: "Mix"	 }
	]
	
	//Emitter Information
	layer_id = get_id_free();
	name	 = _emitter!=undefined?_emitter.name: string("Emitter_{0}", layer_id);
	width	 = _emitter!=undefined?_emitter.xmin-_emitter.xmax: 96.000;
	height	 = _emitter!=undefined?_emitter.ymin-_emitter.ymax: 96.000;
	shape	 = _emitter!=undefined?emitter_shapes[_emitter.shape]: emitter_shapes[0];
	stream	 = _emitter!=undefined?_emitter.mode: true;
	distribution	= _emitter!=undefined?emitter_distributions[_emitter.distribution]: emitter_distributions[0];
	particle_count	= _emitter!=undefined?_emitter.number: 1;

	//Sprite Information
	sprite_file		= undefined; //??
	sprite_subframe = _emitter!=undefined?_emitter.parttype.frame: 0;
	sprite_smooth	= true; //??
	sprite_x_origin = 0; //??
	sprite_y_origin = 0; //??
	sprite_remove_background = true; //??

	//Sprite Particle Information
	sprite_animated		= _emitter!=undefined?_emitter.parttype.animate	: false;
	sprite_stretched	= _emitter!=undefined?_emitter.parttype.stretch	: false;
	sprite_random_frame = _emitter!=undefined?_emitter.parttype.random	: false;

	//Particle Alpha Values
	part_shape = part_shape_items[
		_emitter!=undefined
		? (_emitter.parttype.shape==-1
			?array_length(part_shape_items)-1 
			: _emitter.parttype.shape
		  )
		: 7
	];
	part_alpha_min = _emitter!=undefined?_emitter.parttype.alpha1 : random_range(0.000,1.000);
	part_alpha_mid = _emitter!=undefined?_emitter.parttype.alpha2 : random_range(0.000,1.000);
	part_alpha_max = _emitter!=undefined?_emitter.parttype.alpha3 : random_range(0.000,1.000);

	//Particle Size Values
	part_size_min		= _emitter!=undefined?_emitter.parttype.size_min    : random_range(-5.000,5.000);
	part_size_max		= _emitter!=undefined?_emitter.parttype.size_max    : random_range(-5.000,5.000);
	part_size_increase	= _emitter!=undefined?_emitter.parttype.size_incr   : random_range(-5.000,5.000);
	part_size_wobble	= _emitter!=undefined?_emitter.parttype.size_wiggle : random_range(-5.000,5.000);

	//Particle Scale Values
	part_scale_h = _emitter!=undefined?_emitter.parttype.alpha1 : random_range(0.000,5.000);
	part_scale_v = _emitter!=undefined?_emitter.parttype.alpha1 : random_range(0.000,5.000);

	//Particle Lifetime Values
	part_lifetime_min = _emitter!=undefined?_emitter.parttype.life_min : random_range(0.000,300.000);
	part_lifetime_max = _emitter!=undefined?_emitter.parttype.life_max : random_range(0.000,300.000);

	//Particle Speed Values
	part_speed_min		= _emitter!=undefined?_emitter.parttype.speed_min	: random_range(-5.000,5.000);
	part_speed_max		= _emitter!=undefined?_emitter.parttype.speed_max	: random_range(-5.000,5.000);
	part_speed_increase	= _emitter!=undefined?_emitter.parttype.speed_incr	: random_range(-5.000,5.000);
	part_speed_wobble	= _emitter!=undefined?_emitter.parttype.speed_wiggle : random_range(-5.000,5.000);

	//Particle Direction Values
	part_direction_min		= _emitter!=undefined?_emitter.parttype.dir_min    : random_range(0.000,359.000);
	part_direction_max		= _emitter!=undefined?_emitter.parttype.dir_max    : random_range(0.000,359.000);
	part_direction_increase	= _emitter!=undefined?_emitter.parttype.dir_incr	  : random_range(-5.000,5.000);
	part_direction_wobble	= _emitter!=undefined?_emitter.parttype.dir_wiggle : random_range(-5.000,5.000);

	//Particle Orientation Values
	part_orientation_min		= _emitter!=undefined?_emitter.parttype.ang_min	  : random_range(0.000,359.000);
	part_orientation_max		= _emitter!=undefined?_emitter.parttype.ang_max	  : random_range(0.000,359.000);
	part_orientation_increase	= _emitter!=undefined?_emitter.parttype.ang_inc	  : random_range(-5.000,5.000);
	part_orientation_wobble		= _emitter!=undefined?_emitter.parttype.ang_wiggle : random_range(-5.000,5.000);

	//Particle Gravity Values
	part_gravity_amount		= _emitter!=undefined?_emitter.parttype.grav_amount : random_range(0.000,15.000);
	part_gravity_direction	= _emitter!=undefined?_emitter.parttype.grav_dir	   : random_range(0.000,359.000);

	// Particle Colors
	part_additive	= _emitter!=undefined?part_additive_items[_emitter.parttype.additive]: part_additive_items[false];
	part_color_type = part_color_type_items[0]; //?
	part_color_a = _emitter!=undefined?_emitter.parttype.color1 : irandom_range(c_white,c_black)//color a and color start
	part_color_b = _emitter!=undefined?_emitter.parttype.color2 : irandom_range(c_white,c_black)//color b and color middle
	part_color_c = _emitter!=undefined?_emitter.parttype.color3 : irandom_range(c_white,c_black)//color end
	
}

/**
 * Function Description
 * @param {Asset.GMParticleSystem} _particle_system
 * @returns {Array<Struct.EmitterLayer>}
 */
function init_emitter_layers(_particle_system){
	var __part_info = particle_get_info(ParticleSystem1)
	var __emitters = __part_info.emitters;
	var __emitter_count = array_length(__emitters)
	for(var __i = 0; __i< __emitter_count; __i++){
		show_debug_message(json_stringify(__emitters[__i]))
		var __new_layer = new EmitterLayer(__emitters[__i]);
		array_push(global.emitter_layers, __new_layer)	
	}
}

function get_id_free(){
	var __layer_id = 1;
	var __id_found = true
	var __emitter_count = array_length(global.emitter_layers);
	while(__id_found){
		__id_found = false;
		for(var __i = 0; __i<__emitter_count; __i++){
			if(global.emitter_layers[__i].layer_id == __layer_id){
				__id_found = true;
				break;
			}
		}	
		if(!__id_found) return __layer_id;
		__layer_id++;
	}
}