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

init_emitter_layers(ParticleSystem1);
emitter_dummy = new EmitterLayer();
emitter_selected = array_length(global.emitter_layers)>0
				   ? global.emitter_layers[0]
				   : emitter_dummy;
emitter_dummy.layer_id = -1;

emitter_shapes			= EmitterLayer.emitter_shapes
shape_items				= EmitterLayer.part_shape_items;
additive_items			= EmitterLayer.part_additive_items;
emitter_distributions	= EmitterLayer.emitter_distributions
color_type_items		= EmitterLayer.part_color_type_items;

//Project
//Export Information
export_items = [
	"GML",
	"GMC Wrapper",
	"GML Raptor"
]
export_selected = export_items[0];
export_destination = undefined;
surf = -1; 