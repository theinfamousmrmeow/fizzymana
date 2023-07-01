ImGui.__Initialize();
ImGui.ConfigFlagToggle(ImGuiConfigFlags.DockingEnable);	

randomize();

particle_info_open = true;
header_visible = true;
enable_docking = true;
_static = undefined;
try {
	_static = static_get(ImGui);
} catch (e) {
	_static = undefined;
}

shape_items = [
	"Pixel",
	"Disk",
	"Square",
	"Line",
	"Star",
	"Circle",
	"Ring",
	"Sphere",
	"Flare",
	"Spark",
	"Explosion",
	"Cloud",
	"Smoke",
	"Snow",
	"Sprite"
]
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
additive_items = [
	"no",
	"yes"
]
additive_selected = additive_items[0];
//Color Types
color_type_items = [
	"Gradient",
	"Mix"
]
color_type_selected = color_type_items[0];
color_a = irandom_range(c_white,c_black)
color_b = irandom_range(c_white,c_black)

//Export Information
export_items = [
	"GML",
	"GMC Wrapper",
	"GML Raptor"
]
export_selected = export_items[0];
export_destination = undefined;

//Emitter Information
emitter_counter = 4
emitters = [
	"Emitter_1",
	"Emitter_2",
	"Emitter_3",
];
emitter_selected = emitters[0];

col = c_blue;                     // for TextColored
col2 = c_white;                   // for Image & ColorPicker
col3 = c_lime;                    // for ColorPicker3
col4 = new ImColor(c_aqua, 0.5);  // for ColorPicker4
col5 = c_fuchsia;
col6 = new ImColor(irandom(255), irandom(255), irandom(255), random(1));
dir = ImGuiDir.Right;             // for ArrowButton

surf = -1;                        // for Surface

input_val = "This is a text input! You can type things here! Or even paste new text!";        // for InputText
input_val_ml = "This is a multiline input!\nBelieve it or not, you can have multiple lines here.\n\nPretty neat, right?";
input_hint = "";

input_int = irandom(255);
input_float = random(255);
plot_val = [];
plot_val2 = [];
for(var i = 0; i < 12; i++) {
	array_push(plot_val, irandom(255));
	array_push(plot_val2, irandom(255));
}

drag_mode = 0;
drag_names = [
	"Bobby", "Beatrice", "Betty",
	"Brianna", "Barry", "Bernard",
	"Bibi", "Blaine", "Bryn"
];
 
tab1 = true;

font_default = ImGui.AddFontDefault();
font_roboto = ImGui.AddFontFromFile("fonts/Roboto-Regular.ttf", 24);