/// Docking
if (enable_docking) ImGui.DockSpaceOverViewport();

// Setup
if (!surface_exists(surf)) {
	surf = surface_create(128, 128);
	surface_set_target(surf);
	draw_clear_alpha(c_lime, 0.25);
	surface_reset_target();
}

// Menu
var exit_modal = false;
ImGui.BeginMainMenuBar();
if (ImGui.BeginMenu("File")) {
	if (ImGui.MenuItem("Enable Viewport", undefined, enable_docking)) {
		enable_docking = !enable_docking;
	}
	
	ImGui.Separator();
	if (ImGui.MenuItem("Exit")) {
		exit_modal = true;
	}
	ImGui.EndMenu();
}

if (exit_modal) ImGui.OpenPopup("Exit?");

ImGui.SetNextWindowPos(window_get_width() / 2, window_get_height () / 2, ImGuiCond.Appearing, 0.5, 0.5);
if (ImGui.BeginPopupModal("Exit?", undefined, ImGuiWindowFlags.NoResize)) {
	ImGui.Text("Are you sure you want to exit?");
	ImGui.Separator();
	if (ImGui.Button("Yes")) game_end();
	ImGui.SameLine();
	if (ImGui.Button("Nevermind")) ImGui.CloseCurrentPopup();
	ImGui.EndPopup();	
	
}

if (ImGui.BeginMenu("Windows")) {
	ImGui.EndMenu();
}
ImGui.EndMainMenuBar();

// Particle Info Window
if (particle_info_open) {

	ImGui.SetNextWindowSize(room_width / 4, room_height, ImGuiCond.Once);
	//ImGui.SetNextWindowPos(ImGui.GetContentRegionMaxX(),0,ImGuiCond.Once);
	
	var ret = ImGui.Begin("Particle Information", particle_info_open, ImGuiWindowFlags.None, ImGuiReturnMask.Both);
	particle_info_open = ret & ImGuiReturnMask.Pointer;
	
	if (ret & ImGuiReturnMask.Return) {
			var width = ImGui.GetContentRegionAvailX(), 
			height =ImGui.GetContentRegionAvailY();
			if (ImGui.BeginTabBar("MyTabBar")){	
                if (ImGui.BeginTabItem("Type")){
					ImGui.NewLine()
					ImGui.Text("Shape");
					ImGui.SameLine();
					if (ImGui.SmallButton("random")){ 
						shape_selected = shape_items[irandom(array_length(shape_items)-1)]
					};
					ImGui.Indent(20);
					ImGui.PushItemWidth(width-40)
					if(ImGui.BeginCombo(" ",shape_selected,ImGuiComboFlags.None)){

						for (var __n = 0; __n < array_length(shape_items); __n++){
						    var __is_selected = (shape_selected == shape_items[__n]);
						    if (ImGui.Selectable(shape_items[__n], __is_selected)){
						        shape_selected = shape_items[__n];
							}
						    if (__is_selected){
						        ImGui.SetItemDefaultFocus();
							}
						}
						ImGui.EndCombo();
					}
					ImGui.PopItemWidth()
					ImGui.Unindent();
					//Sprite Information
					if(shape_selected=="Sprite"){
						ImGui.NewLine()
						ImGui.Text("Sprite Information");
						ImGui.SameLine();
						if (ImGui.SmallButton("reset")){ 
							//Sprite Information
							sprite_subframe_val = 0;
							sprite_remove_background = true;
							sprite_smooth = true;
							sprite_x_origin = 0;
							sprite_y_origin = 0;

							//Sprite Particle Information
							sprite_animated = false;
							sprite_stretched = false;
							sprite_random_frame = false;
						};
						ImGui.Indent(20);
						ImGui.PushID("LoadSprite");
							if (ImGui.Button("Load Sprite")){
								sprite_file = get_open_filename("PNG|*.png|JPG|*jpg|JPEG|*.jpeg", "");
							};
						ImGui.PopID();
						ImGui.PushItemWidth(width-40)
						sprite_subframe_val = clamp(ImGui.InputInt("",sprite_subframe_val,1,1),1,infinity);
						ImGui.Text("Subframes");
						ImGui.PopItemWidth()
						
						ImGui.NewLine()
						ImGui.PushID("SpriteRemoveBackground");
							sprite_remove_background = ImGui.Checkbox("Remove Background", sprite_remove_background);
						ImGui.PopID();
						ImGui.PushID("SpriteSmooth");
							sprite_smooth = ImGui.Checkbox("Smooth", sprite_smooth);
						ImGui.PopID();
						
						if (ImGui.BeginTable("table_test", 2,ImGuiTableFlags.SizingFixedFit)) {
							ImGui.TableSetupColumn("");
							ImGui.TableSetupColumn("");
							ImGui.TableNextRow();
							
							ImGui.TableSetColumnIndex(0);
							ImGui.PushItemWidth((width/2)-20);
							ImGui.PushID("XOrigin");
							sprite_x_origin = ImGui.SliderInt("",sprite_x_origin,0,64)
							ImGui.Text("X Origin");
							ImGui.PopID()
							ImGui.PopItemWidth();
							
							ImGui.TableSetColumnIndex(1);
							ImGui.PushItemWidth((width/2)-20);
							ImGui.PushID("YOrigin");
							sprite_y_origin = ImGui.SliderInt("",sprite_y_origin,0,64)
							ImGui.Text("Y Origin");
							ImGui.PopID()
							ImGui.PopItemWidth();
							
							ImGui.EndTable();	
						}
						ImGui.Unindent();
						
						ImGui.NewLine()
						ImGui.Text("Subframes");
						ImGui.Indent(20);
						ImGui.PushID("SpriteAnimated");
							sprite_animated	=ImGui.Checkbox("Animated", sprite_animated);
						ImGui.PopID();
						ImGui.PushID("SpriteStretched");
							sprite_stretched =ImGui.Checkbox("Stretched", sprite_stretched);
						ImGui.PopID();
						ImGui.PushID("SpriteRandomFrame");
							sprite_random_frame	=ImGui.Checkbox("Random Frame", sprite_random_frame);
						ImGui.PopID();
						ImGui.Unindent();
					}

					//sprite_subframe_val = 0;
					//sprite_remove_background = true;
					//sprite_smooth = true;
					//sprite_x_origin = 0;
					//sprite_y_origin = 0;

					////Sprite Particle Information
					//sprite_animated		= false;
					//sprite_stretched		= false;
					//sprite_random_frame	= false;
                    ImGui.EndTabItem();
                }
                if (ImGui.BeginTabItem("Basics"))
                {
                    //Particle Alpha Sliders
                    ImGui.NewLine()
					ImGui.Text("Alpha");
					ImGui.SameLine();
					ImGui.PushID("AlphaValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_alpha_min = random_range(0.000,1.000)
							part_alpha_mid = random_range(0.000,1.000)
							part_alpha_max = random_range(0.000,1.000)
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("AlphaValuesReset");
						if (ImGui.SmallButton("reset")){
							part_alpha_min = 1.000
							part_alpha_mid = 1.000
							part_alpha_max = 1.000
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("AlphaSliderMin");
						part_alpha_min = ImGui.SliderFloat("",part_alpha_min,0.000,1.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("min")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){
							show_message("Reset alpha min to defualt values")
						};
					ImGui.PopID()
					ImGui.PushID("AlphaSliderMid");
						part_alpha_mid = ImGui.SliderFloat("",part_alpha_mid,0.000,1.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("middle")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							show_message("Reset alpha mid to defualt values")
						};
					ImGui.PopID()
					ImGui.PushID("AlphaSliderMax")
						part_alpha_max = ImGui.SliderFloat("",part_alpha_max,0.000,1.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("max")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							show_message("Reset alpha max to defualt values")
						};
					ImGui.PopID()
					
					//Particle Size Sliders
					ImGui.NewLine()
					ImGui.Unindent();
					ImGui.Text("Size");
					ImGui.SameLine();
					ImGui.PushID("SizeValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_size_min		= random_range(-5.000,5.000);
							part_size_max		= random_range(-5.000,5.000);
							part_size_increase	= random_range(-5.000,5.000);
							part_size_wobble	= random_range(-5.000,5.000);
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("SizeValuesReset");
						if (ImGui.SmallButton("reset")){
							part_size_min		= 1.000;
							part_size_max		= 1.000;
							part_size_increase	= 0.000;
							part_size_wobble	= 0.000;
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("SizeSliderMin");
						part_size_min = ImGui.SliderFloat("",part_size_min,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("min")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_size_min = 1.000;
						};
					ImGui.PopID();
					ImGui.PushID("SizeSliderMax");
						part_size_max = ImGui.SliderFloat("",part_size_max,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("max")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_size_max = 1.000;
						};
					ImGui.PopID();
					ImGui.PushID("SizeSliderIncrease");
						part_size_increase = ImGui.SliderFloat("",part_size_increase,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("increase")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_size_increase = 0.000;
						};
					ImGui.PopID();
						ImGui.PushID("SizeSliderWobble");
						part_size_wobble = ImGui.SliderFloat("",part_size_wobble,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("wobble")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_size_wobble = 0.000;
						};
					ImGui.PopID();

					//Particle Scale Sliders
					ImGui.NewLine()
					ImGui.Unindent();
					ImGui.Text("Scale");
					ImGui.SameLine();
					ImGui.PushID("ScaleValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_scale_h = random_range(0.000,5.000);
							part_scale_v = random_range(0.000,5.000);
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("ScaleValuesReset");
						if (ImGui.SmallButton("reset")){
							part_scale_h = 1.000;
							part_scale_v = 1.000;
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("ScaleSliderHorizontal");
						part_scale_h = ImGui.SliderFloat("",part_scale_h,0.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("horizontal")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_scale_h = 1.000;
						};
					ImGui.PopID();
					ImGui.PushID("ScaleSliderVertical");
						part_scale_v = ImGui.SliderFloat("",part_scale_v,0.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("vertical")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_scale_v = 1.000;
						};
					ImGui.PopID();
					
					//Particle Lifetime Sliders
					ImGui.NewLine()
					ImGui.Unindent();
					ImGui.Text("Lifetime");
					ImGui.SameLine();
					ImGui.PushID("LifetimeValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_lifetime_min = random_range(0.000,300.000);
							part_lifetime_max = random_range(0.000,300.000);
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("LifetimeValuesReset");
						if (ImGui.SmallButton("reset")){
							part_lifetime_min = 30.000;
							part_lifetime_max = 30.000;
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("LifetimeSliderMin");
						part_lifetime_min = ImGui.SliderFloat("",part_lifetime_min,0.000,300.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("min")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_lifetime_min = 30.000;
						};
					ImGui.PopID();
					ImGui.PushID("LifetimeSliderMax");
						part_lifetime_max = ImGui.SliderFloat("",part_lifetime_max,0.000,300.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("max")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_lifetime_max = 30.000;
						};
					ImGui.PopID();
					ImGui.Unindent();
                    ImGui.EndTabItem();
                }
                if (ImGui.BeginTabItem("Motion"))
                {
					//Particle Speed Sliders
					ImGui.NewLine()
					ImGui.Text("Speed");
					ImGui.SameLine();
					ImGui.PushID("SpeedValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_speed_min		= random_range(-5.000,5.000);
							part_speed_max		= random_range(-5.000,5.000);
							part_speed_increase	= random_range(-5.000,5.000);
							part_speed_wobble	= random_range(-5.000,5.000);
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("SpeedValuesReset");
						if (ImGui.SmallButton("reset")){
							part_speed_min		= 1.000;
							part_speed_max		= 1.000;
							part_speed_increase	= 0.000;
							part_speed_wobble	= 0.000;
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("SpeedSliderMin");
						part_speed_min = ImGui.SliderFloat("",part_speed_min,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("min")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_speed_min = 1.000;
						};
					ImGui.PopID();
					ImGui.PushID("SpeedSliderMax");
						part_speed_max = ImGui.SliderFloat("",part_speed_max,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("max")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_speed_max = 1.000;
						};
					ImGui.PopID();
					ImGui.PushID("SpeedSliderIncrease");
						part_speed_increase = ImGui.SliderFloat("",part_speed_increase,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("increase")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_speed_increase = 0.000;
						};
					ImGui.PopID();
						ImGui.PushID("SpeedSliderWobble");
						part_speed_wobble = ImGui.SliderFloat("",part_speed_wobble,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("wobble")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_speed_wobble = 0.000;
						};
					ImGui.PopID();
					
					//Particle Direction Sliders
					ImGui.NewLine()
					ImGui.Unindent();
					ImGui.Text("Direction");
					ImGui.SameLine();
					ImGui.PushID("DirectionValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_direction_min		= random_range(0.000,359.000);
							part_direction_max		= random_range(0.000,359.000);
							part_direction_increase	= random_range(-5.000,5.000);
							part_direction_wobble	= random_range(-5.000,5.000);
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("DirectionValuesReset");
						if (ImGui.SmallButton("reset")){
							part_direction_min		= 0.000;
							part_direction_max		= 0.000;
							part_direction_increase	= 0.000;
							part_direction_wobble	= 0.000;
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("DirectionSliderMin");
						part_direction_min = ImGui.SliderFloat("",part_direction_min,0.000,359.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("min")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_direction_min = 0.000;
						};
					ImGui.PopID();
					ImGui.PushID("DirectionSliderMax");
						part_direction_max = ImGui.SliderFloat("",part_direction_max,0.000,359.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("max")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_direction_max = 0.000;
						};
					ImGui.PopID();
					ImGui.PushID("DirectionSliderIncrease");
						part_direction_increase = ImGui.SliderFloat("",part_direction_increase,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("increase")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_direction_increase = 0.000;
						};
					ImGui.PopID();
						ImGui.PushID("DirectionSliderWobble");
						part_direction_wobble = ImGui.SliderFloat("",part_direction_wobble,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("wobble")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_direction_wobble = 0.000;
						};
					ImGui.PopID();

					//Particle Orientation Sliders
					ImGui.NewLine()
					ImGui.Unindent();
					ImGui.Text("Orientation");
					ImGui.SameLine();
					ImGui.PushID("OrientationValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_orientation_min		= random_range(0.000,359.000);
							part_orientation_max		= random_range(0.000,359.000);
							part_orientation_increase	= random_range(-5.000,5.000);
							part_orientation_wobble		= random_range(-5.000,5.000);
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("OrientationValuesReset");
						if (ImGui.SmallButton("reset")){
							part_orientation_min		= 0.000;
							part_orientation_max		= 0.000;
							part_orientation_increase	= 0.000;
							part_orientation_wobble		= 0.000;
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("OrientationSliderMin");
						part_orientation_min = ImGui.SliderFloat("",part_orientation_min,0.000,359.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("min")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_orientation_min = 0.000;
						};
					ImGui.PopID();
					ImGui.PushID("OrientationSliderMax");
						part_orientation_max = ImGui.SliderFloat("",part_orientation_max,0.000,359.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("max")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_orientation_max = 0.000;
						};
					ImGui.PopID();
					ImGui.PushID("OrientationSliderIncrease");
						part_orientation_increase = ImGui.SliderFloat("",part_orientation_increase,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("increase")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_orientation_increase = 0.000;
						};
					ImGui.PopID();
						ImGui.PushID("OrientationSliderWobble");
						part_orientation_wobble = ImGui.SliderFloat("",part_orientation_wobble,-5.000,5.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("wobble")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_orientation_wobble = 0.000;
						};
					ImGui.PopID();
					
					//Particle Gravity Sliders
					ImGui.NewLine()
					ImGui.Unindent();
					ImGui.Text("Gravity");
					ImGui.SameLine();
					ImGui.PushID("GravityValuesRandomize");
						if (ImGui.SmallButton("random")){
							part_gravity_amount		= random_range(0.000,15.000);
							part_gravity_direction	= random_range(0.000,359.000);
						};
					ImGui.PopID();
					ImGui.SameLine();
					ImGui.PushID("GravityValuesReset");
						if (ImGui.SmallButton("reset")){
							part_gravity_amount		= 0.000;
							part_gravity_direction	= 0.000;
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("GravitySliderAmount");
						part_gravity_amount = ImGui.SliderFloat("",part_gravity_amount,0.000,15.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("amount")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_gravity_amount = 0.000;
						};
					ImGui.PopID();
					ImGui.PushID("GravitySliderDirection");
						part_gravity_direction = ImGui.SliderFloat("",part_gravity_direction,0.000,359.000)
						if(ImGui.IsItemHovered()) {
							ImGui.SetTooltip("direction")
						}
						ImGui.SameLine();
						if (ImGui.Button("reset")){ 
							part_gravity_direction = 0.000;
						};
					ImGui.PopID();
					ImGui.Unindent();
                    ImGui.EndTabItem();
                }
				if (ImGui.BeginTabItem("Colors"))
                {
					//Particle Color Additive Combo box
                    ImGui.NewLine()
					ImGui.Text("Additive");
					ImGui.Indent(20);
					ImGui.PushID("AdditiveValueComboBox");
						if(ImGui.BeginCombo(" ",additive_selected,ImGuiComboFlags.None)){
							for (var __n = 0; __n < array_length(additive_items); __n++){
							    var __is_selected = (additive_selected == additive_items[__n]);
							    if (ImGui.Selectable(additive_items[__n], __is_selected)){
							        additive_selected = additive_items[__n];
								}
							    if (__is_selected){
							        ImGui.SetItemDefaultFocus();
								}
							}
							ImGui.EndCombo();
						}
					ImGui.PopID();
					ImGui.Unindent();
					
					//Particle Color Type Combo box
					ImGui.NewLine()
					ImGui.Text("Color Type");
					ImGui.Indent(20);
					ImGui.PushID("ColorTypeValueComboBox");
						if(ImGui.BeginCombo(" ",color_type_selected,ImGuiComboFlags.None)){
							for (var __n = 0; __n < array_length(color_type_items); __n++){
							    var __is_selected = (color_type_selected == color_type_items[__n]);
							    if (ImGui.Selectable(color_type_items[__n], __is_selected)){
							        color_type_selected = color_type_items[__n];
								}
							    if (__is_selected){
							        ImGui.SetItemDefaultFocus();
								}
							}
							ImGui.EndCombo();
						}
					ImGui.PopID();
					ImGui.Unindent();
					
					//Particle Color A Editor
					ImGui.NewLine()
					ImGui.Text("Color A");
					ImGui.SameLine();
					ImGui.PushID("ColorAValueRandomize");
						if (ImGui.SmallButton("random")){
							color_a = irandom_range(c_white,c_black)
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("ColorAEditor");
					color_a = ImGui.ColorEdit3("", color_a);
					ImGui.PopID();
					ImGui.Unindent();
					
					//Particle Color B Editor
					ImGui.NewLine()
					ImGui.Text("Color B");
					ImGui.SameLine();
					ImGui.PushID("ColorBValueRandomize");
						if (ImGui.SmallButton("random")){
							color_b = irandom_range(c_white,c_black)
						};
					ImGui.PopID();
					ImGui.Indent(20);
					ImGui.PushID("ColorBEditor");
					color_b = ImGui.ColorEdit3("", color_b);
					show_debug_message(color_b);
					ImGui.PopID();
					ImGui.Unindent();
					
                    ImGui.EndTabItem();
                }
				if (ImGui.BeginTabItem("Export"))
                {
                    ImGui.NewLine()
					ImGui.Text("Export Type");
					ImGui.Indent(20);
					ImGui.PushID("ExportTypeSelection");
					if(ImGui.BeginCombo(" ",export_selected,ImGuiComboFlags.None)){
						for (var __n = 0; __n < array_length(export_items); __n++){
						    var __is_selected = (export_selected == export_items[__n]);
						    if (ImGui.Selectable(export_items[__n], __is_selected)){
						        export_selected = export_items[__n];
							}
						    if (__is_selected){
						        ImGui.SetItemDefaultFocus();
							}
						}
						ImGui.EndCombo();
					}
					ImGui.PopID();
					ImGui.Unindent();

					ImGui.NewLine()
					ImGui.Separator()
					ImGui.Text("Just click export below and you can");
					ImGui.Text("paste the code into your project.");
					ImGui.Separator()
					
					ImGui.NewLine()
					ImGui.PushID("Export");
						if (ImGui.Button("Export",width)){
							show_message("Exporting some bullshit")
						};
					ImGui.PopID();
                    ImGui.EndTabItem();
                }
				
                ImGui.EndTabBar();
            }
	}
	ImGui.End();

}

	ImGui.SetNextWindowSize(room_width/4, room_height-200, ImGuiCond.Once);
	ImGui.Begin("Emitter Information", particle_info_open, ImGuiWindowFlags.None, ImGuiReturnMask.Both);
		ImGui.Text("Emitters");
		var __list_width = ImGui.GetContentRegionAvailX();
		var __list_height = ImGui.GetContentRegionAvailY();

		if(ImGui.BeginListBox("",__list_width ,__list_height/2 )){
			for (var __n = 0; __n < array_length(emitters); __n++){
				var __is_selected = (emitter_selected.name == emitters[__n].name);
				if (ImGui.Selectable(emitters[__n].name, __is_selected)){
					emitter_selected = emitters[__n];
				}
				if (__is_selected){
					ImGui.SetItemDefaultFocus();
				}
			}
			ImGui.EndListBox()
		}
		ImGui.PushID("AddEmitter");
			if (ImGui.Button(" + ")){
				var __new_emitter = {
					key: emitter_counter,
					name: string("Emitter_{0}", emitter_counter++),
					width: 96.000,
					height: 96.000,
					shape: "Ellipse",
					distribution: "Linear",
					particle_count: 1,
					stream: true,
				}
				array_push(emitters, __new_emitter);
				emitter_selected = __new_emitter
			};
		ImGui.PopID();
		ImGui.SameLine();
		ImGui.PushID("RemoveEmitter");
			if (ImGui.Button(" - ")){
				var __current_index = array_find_index(emitters,function(_val){return _val.key == emitter_selected.key})
				array_delete(emitters,__current_index,1);
				emitter_selected = array_length(emitters)>0
								   ? emitters[0]
								   : emitter_dummy;
			};
		ImGui.PopID();
		
		ImGui.NewLine();
		ImGui.Text("Emitter Properties");
		ImGui.Separator()
			
		ImGui.BeginDisabled(emitter_selected.key==-1);
		ImGui.NewLine();
		ImGui.Text("Emitter");
		ImGui.Indent(20);
		ImGui.PushID("EmitterWidth");
			ImGui.PushItemWidth(__list_width-40);
			emitter_selected.width = ImGui.SliderFloat("",emitter_selected.width,0.000,512.000)
			if(ImGui.IsItemHovered()) {
				ImGui.SetTooltip("width")
			}
			ImGui.PopItemWidth();
		ImGui.PopID();
		ImGui.PushID("EmitterHeight");
			ImGui.PushItemWidth(__list_width-40);
			emitter_selected.height = ImGui.SliderFloat("",emitter_selected.height,0.000,512.000)
			if(ImGui.IsItemHovered()) {
				ImGui.SetTooltip("height")
			}
			ImGui.PopItemWidth();
		ImGui.PopID();
		ImGui.Unindent();
				
		ImGui.NewLine()
		ImGui.Text("Shape");
		ImGui.Indent(20);
		ImGui.PushID("EmitterShape");
			ImGui.PushItemWidth(__list_width-40);
			if(ImGui.BeginCombo("",emitter_selected.shape,ImGuiComboFlags.None)){
				for (var __n = 0; __n < array_length(emitter_shapes); __n++){
					var __is_selected = (emitter_selected.shape == emitter_shapes[__n]);
					if (ImGui.Selectable(emitter_shapes[__n], __is_selected)){
						emitter_selected.shape = emitter_shapes[__n];
					}
					if (__is_selected){
						ImGui.SetItemDefaultFocus();
					}
				}
				ImGui.EndCombo();
			}
			ImGui.PopItemWidth();
		ImGui.PopID();
		ImGui.Unindent();
				
		ImGui.NewLine()
		ImGui.Text("Distribution");
		ImGui.Indent(20);
		ImGui.PushID("EmitterDistribution");
			ImGui.PushItemWidth(__list_width-40);
			if(ImGui.BeginCombo("",emitter_selected.distribution,ImGuiComboFlags.None)){
				for (var __n = 0; __n < array_length(emitter_distributions); __n++){
					var __is_selected = (emitter_selected.distribution == emitter_distributions[__n]);
					if (ImGui.Selectable(emitter_distributions[__n], __is_selected)){
						emitter_selected.distribution = emitter_distributions[__n];
					}
					if (__is_selected){
						ImGui.SetItemDefaultFocus();
					}
				}
				ImGui.EndCombo();
			}
			ImGui.PopItemWidth();
		ImGui.PopID();
		ImGui.Unindent();
				
		ImGui.NewLine();
		ImGui.Text("Particle Count");
		ImGui.Indent(20);
		ImGui.PushID("EmitterParticleCount");
			ImGui.PushItemWidth(__list_width-40);
			emitter_selected.particle_count = ImGui.SliderInt("",emitter_selected.particle_count,1,64)
			ImGui.PopItemWidth();
		ImGui.PopID();
		ImGui.Unindent();
		ImGui.EndDisabled()

	ImGui.End();