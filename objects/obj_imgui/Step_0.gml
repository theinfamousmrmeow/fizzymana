/// Docking
if (enable_docking) viewport_dock = ImGui.DockSpaceOverViewport(ImGuiDockNodeFlags.NoDockingInCentralNode);
var __main_width = window_get_width();
var __main_height = window_get_height();

#region Menu Bar
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


	ImGui.SetNextWindowPos(__main_width / 2, __main_height / 2, ImGuiCond.Appearing, 0.5, 0.5);
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
//ImGui.ShowMetricsWindow();
#endregion
#region Particle Info View
var _part_info_view_width = __main_width/5;
var __part_info_view_height =__main_height-19;

ImGui.SetNextWindowSize(_part_info_view_width, __part_info_view_height, ImGuiCond.Once);
ImGui.SetNextWindowPos(__main_width-_part_info_view_width,19,ImGuiCond.Once);
ImGui.Begin("Particle Information", undefined, ImGuiWindowFlags.None);

	if (ImGui.BeginTabBar("ParticleOptionsTabBar")){
		var __indent = 20;
        if (ImGui.BeginTabItem("Type")){
			
			ImGui.NewLine()
			ImGui.Text("Shape");
			ImGui.SameLine();
			if (ImGui.SmallButton("random")){ 
				emitter_selected.part_shape = shape_items[irandom(array_length(shape_items)-1)]
				//shape_selected = shape_items[irandom(array_length(shape_items)-1)]
			};
			ImGui.Indent(__indent);
			ImGui.PushItemWidth(ImGui.GetContentRegionAvailX()-__indent)
			if(ImGui.BeginCombo(" ",emitter_selected.part_shape.name,ImGuiComboFlags.None)){

				for (var __n = 0; __n < array_length(shape_items); __n++){
					var __is_selected = (emitter_selected.part_shape.key == shape_items[__n].key);
					if (ImGui.Selectable(shape_items[__n].name, __is_selected)){
						emitter_selected.part_shape = shape_items[__n];
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
			if(emitter_selected.part_shape.name=="Sprite"){
				ImGui.NewLine()
				ImGui.Text("Sprite Information");
				ImGui.SameLine();
				if (ImGui.SmallButton("reset")){ 
					//Sprite Information
					emitter_selected.sprite_subframe = 0;
					emitter_selected.sprite_remove_background = true;
					emitter_selected.sprite_smooth = true;
					emitter_selected.sprite_x_origin = 0;
					emitter_selected.sprite_y_origin = 0;

					//Sprite Particle Information
					emitter_selected.sprite_animated = false;
					emitter_selected.sprite_stretched = false;
					emitter_selected.sprite_random_frame = false;
				};
				ImGui.Indent(__indent);
				ImGui.PushID("LoadSprite");
					if (ImGui.Button("Load Sprite")){
						emitter_selected.sprite_file = get_open_filename("PNG|*.png|JPG|*jpg|JPEG|*.jpeg", "");
					};
				ImGui.PopID();
				ImGui.PushItemWidth(ImGui.GetContentRegionAvailX()-__indent)
				emitter_selected.sprite_subframe = clamp(ImGui.InputInt("",emitter_selected.sprite_subframe,1,1),1,infinity);
				ImGui.Text("Subframes");
				ImGui.PopItemWidth()
						
				ImGui.NewLine()
				ImGui.PushID("SpriteRemoveBackground");
					emitter_selected.sprite_remove_background = ImGui.Checkbox("Remove Background", emitter_selected.sprite_remove_background);
				ImGui.PopID();
				ImGui.PushID("SpriteSmooth");
					emitter_selected.sprite_smooth = ImGui.Checkbox("Smooth", emitter_selected.sprite_smooth);
				ImGui.PopID();
				var _col_width = ImGui.GetContentRegionAvailX()-__indent;
				if (ImGui.BeginTable("table_test", 2,ImGuiTableFlags.SizingFixedFit)) {
					
					ImGui.TableSetupColumn("");
					ImGui.TableSetupColumn("");
					ImGui.TableNextRow();
							
					ImGui.TableSetColumnIndex(0);
					ImGui.PushItemWidth(_col_width/2);
					ImGui.PushID("XOrigin");
					emitter_selected.sprite_x_origin = ImGui.SliderInt("",emitter_selected.sprite_x_origin,0,64)
					ImGui.Text("X Origin");
					ImGui.PopID()
					ImGui.PopItemWidth();
							
					ImGui.TableSetColumnIndex(1);
					ImGui.PushItemWidth(_col_width/2);
					ImGui.PushID("YOrigin");
					emitter_selected.sprite_y_origin = ImGui.SliderInt("",emitter_selected.sprite_y_origin,0,64)
					ImGui.Text("Y Origin");
					ImGui.PopID()
					ImGui.PopItemWidth();
							
					ImGui.EndTable();	
				}
				ImGui.Unindent();
						
				ImGui.NewLine()
				ImGui.Text("Subframes");
				ImGui.Indent(__indent);
				ImGui.PushID("SpriteAnimated");
					emitter_selected.sprite_animated	=ImGui.Checkbox("Animated", emitter_selected.sprite_animated);
				ImGui.PopID();
				ImGui.PushID("SpriteStretched");
					emitter_selected.sprite_stretched =ImGui.Checkbox("Stretched", emitter_selected.sprite_stretched);
				ImGui.PopID();
				ImGui.PushID("SpriteRandomFrame");
					emitter_selected.sprite_random_frame	=ImGui.Checkbox("Random Frame", emitter_selected.sprite_random_frame);
				ImGui.PopID();
				ImGui.Unindent();
			}
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
					emitter_selected.part_alpha_min = random_range(0.000,1.000)
					emitter_selected.part_alpha_mid = random_range(0.000,1.000)
					emitter_selected.part_alpha_max = random_range(0.000,1.000)
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("AlphaValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_alpha_min = 1.000
					emitter_selected.part_alpha_mid = 1.000
					emitter_selected.part_alpha_max = 1.000
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("AlphaSliderMin");
				emitter_selected.part_alpha_min = ImGui.SliderFloat("",emitter_selected.part_alpha_min,0.000,1.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("min")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){
					show_message("Reset alpha min to defualt values")
				};
			ImGui.PopID()
			ImGui.PushID("AlphaSliderMid");
				emitter_selected.part_alpha_mid = ImGui.SliderFloat("",emitter_selected.part_alpha_mid,0.000,1.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("middle")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					show_message("Reset alpha mid to defualt values")
				};
			ImGui.PopID()
			ImGui.PushID("AlphaSliderMax")
				emitter_selected.part_alpha_max = ImGui.SliderFloat("",emitter_selected.part_alpha_max,0.000,1.000)
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
					emitter_selected.part_size_min		= random_range(-5.000,5.000);
					emitter_selected.part_size_max		= random_range(-5.000,5.000);
					emitter_selected.part_size_increase	= random_range(-5.000,5.000);
					emitter_selected.part_size_wobble	= random_range(-5.000,5.000);
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("SizeValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_size_min		= 1.000;
					emitter_selected.part_size_max		= 1.000;
					emitter_selected.part_size_increase	= 0.000;
					emitter_selected.part_size_wobble	= 0.000;
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("SizeSliderMin");
				emitter_selected.part_size_min = ImGui.SliderFloat("",emitter_selected.part_size_min,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("min")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					part_size_min = 1.000;
				};
			ImGui.PopID();
			ImGui.PushID("SizeSliderMax");
				emitter_selected.part_size_max = ImGui.SliderFloat("",emitter_selected.part_size_max,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("max")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_size_max = 1.000;
				};
			ImGui.PopID();
			ImGui.PushID("SizeSliderIncrease");
				emitter_selected.part_size_increase = ImGui.SliderFloat("",emitter_selected.part_size_increase,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("increase")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_size_increase = 0.000;
				};
			ImGui.PopID();
				ImGui.PushID("SizeSliderWobble");
				emitter_selected.part_size_wobble = ImGui.SliderFloat("",emitter_selected.part_size_wobble,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("wobble")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_size_wobble = 0.000;
				};
			ImGui.PopID();

			//Particle Scale Sliders
			ImGui.NewLine()
			ImGui.Unindent();
			ImGui.Text("Scale");
			ImGui.SameLine();
			ImGui.PushID("ScaleValuesRandomize");
				if (ImGui.SmallButton("random")){
					emitter_selected.part_scale_h = random_range(0.000,5.000);
					emitter_selected.part_scale_v = random_range(0.000,5.000);
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("ScaleValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_scale_h = 1.000;
					emitter_selected.part_scale_v = 1.000;
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("ScaleSliderHorizontal");
				emitter_selected.part_scale_h = ImGui.SliderFloat("",emitter_selected.part_scale_h,0.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("horizontal")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_scale_h = 1.000;
				};
			ImGui.PopID();
			ImGui.PushID("ScaleSliderVertical");
				emitter_selected.part_scale_v = ImGui.SliderFloat("",emitter_selected.part_scale_v,0.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("vertical")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_scale_v = 1.000;
				};
			ImGui.PopID();
					
			//Particle Lifetime Sliders
			ImGui.NewLine()
			ImGui.Unindent();
			ImGui.Text("Lifetime");
			ImGui.SameLine();
			ImGui.PushID("LifetimeValuesRandomize");
				if (ImGui.SmallButton("random")){
					emitter_selected.part_lifetime_min = random_range(0.000,300.000);
					emitter_selected.part_lifetime_max = random_range(0.000,300.000);
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("LifetimeValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_lifetime_min = 30.000;
					emitter_selected.part_lifetime_max = 30.000;
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("LifetimeSliderMin");
				emitter_selected.part_lifetime_min = ImGui.SliderFloat("",emitter_selected.part_lifetime_min,0.000,300.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("min")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_lifetime_min = 30.000;
				};
			ImGui.PopID();
			ImGui.PushID("LifetimeSliderMax");
				emitter_selected.part_lifetime_max = ImGui.SliderFloat("",emitter_selected.part_lifetime_max,0.000,300.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("max")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_lifetime_max = 30.000;
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
					emitter_selected.part_speed_min		= random_range(-5.000,5.000);
					emitter_selected.part_speed_max		= random_range(-5.000,5.000);
					emitter_selected.part_speed_increase	= random_range(-5.000,5.000);
					emitter_selected.part_speed_wobble	= random_range(-5.000,5.000);
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("SpeedValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_speed_min		= 1.000;
					emitter_selected.part_speed_max		= 1.000;
					emitter_selected.part_speed_increase	= 0.000;
					emitter_selected.part_speed_wobble	= 0.000;
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("SpeedSliderMin");
				emitter_selected.part_speed_min = ImGui.SliderFloat("",emitter_selected.part_speed_min,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("min")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_speed_min = 1.000;
				};
			ImGui.PopID();
			ImGui.PushID("SpeedSliderMax");
				emitter_selected.part_speed_max = ImGui.SliderFloat("",emitter_selected.part_speed_max,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("max")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_speed_max = 1.000;
				};
			ImGui.PopID();
			ImGui.PushID("SpeedSliderIncrease");
				emitter_selected.part_speed_increase = ImGui.SliderFloat("",emitter_selected.part_speed_increase,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("increase")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_speed_increase = 0.000;
				};
			ImGui.PopID();
				ImGui.PushID("SpeedSliderWobble");
				emitter_selected.part_speed_wobble = ImGui.SliderFloat("",emitter_selected.part_speed_wobble,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("wobble")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_speed_wobble = 0.000;
				};
			ImGui.PopID();
					
			//Particle Direction Sliders
			ImGui.NewLine()
			ImGui.Unindent();
			ImGui.Text("Direction");
			ImGui.SameLine();
			ImGui.PushID("DirectionValuesRandomize");
				if (ImGui.SmallButton("random")){
					emitter_selected.part_direction_min		= random_range(0.000,359.000);
					emitter_selected.part_direction_max		= random_range(0.000,359.000);
					emitter_selected.part_direction_increase	= random_range(-5.000,5.000);
					emitter_selected.part_direction_wobble	= random_range(-5.000,5.000);
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("DirectionValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_direction_min		= 0.000;
					emitter_selected.part_direction_max		= 0.000;
					emitter_selected.part_direction_increase	= 0.000;
					emitter_selected.part_direction_wobble	= 0.000;
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("DirectionSliderMin");
				emitter_selected.part_direction_min = ImGui.SliderFloat("",emitter_selected.part_direction_min,0.000,359.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("min")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_direction_min = 0.000;
				};
			ImGui.PopID();
			ImGui.PushID("DirectionSliderMax");
				emitter_selected.part_direction_max = ImGui.SliderFloat("",emitter_selected.part_direction_max,0.000,359.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("max")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_direction_max = 0.000;
				};
			ImGui.PopID();
			ImGui.PushID("DirectionSliderIncrease");
				emitter_selected.part_direction_increase = ImGui.SliderFloat("",emitter_selected.part_direction_increase,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("increase")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					part_direction_increase = 0.000;
				};
			ImGui.PopID();
				ImGui.PushID("DirectionSliderWobble");
				emitter_selected.part_direction_wobble = ImGui.SliderFloat("",emitter_selected.part_direction_wobble,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("wobble")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_direction_wobble = 0.000;
				};
			ImGui.PopID();

			//Particle Orientation Sliders
			ImGui.NewLine()
			ImGui.Unindent();
			ImGui.Text("Orientation");
			ImGui.SameLine();
			ImGui.PushID("OrientationValuesRandomize");
				if (ImGui.SmallButton("random")){
					emitter_selected.part_orientation_min		= random_range(0.000,359.000);
					emitter_selected.part_orientation_max		= random_range(0.000,359.000);
					emitter_selected.part_orientation_increase	= random_range(-5.000,5.000);
					emitter_selected.part_orientation_wobble		= random_range(-5.000,5.000);
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("OrientationValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_orientation_min		= 0.000;
					emitter_selected.part_orientation_max		= 0.000;
					emitter_selected.part_orientation_increase	= 0.000;
					emitter_selected.part_orientation_wobble		= 0.000;
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("OrientationSliderMin");
				emitter_selected.part_orientation_min = ImGui.SliderFloat("",emitter_selected.part_orientation_min,0.000,359.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("min")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_orientation_min = 0.000;
				};
			ImGui.PopID();
			ImGui.PushID("OrientationSliderMax");
				emitter_selected.part_orientation_max = ImGui.SliderFloat("",emitter_selected.part_orientation_max,0.000,359.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("max")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_orientation_max = 0.000;
				};
			ImGui.PopID();
			ImGui.PushID("OrientationSliderIncrease");
				emitter_selected.part_orientation_increase = ImGui.SliderFloat("",emitter_selected.part_orientation_increase,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("increase")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_orientation_increase = 0.000;
				};
			ImGui.PopID();
				ImGui.PushID("OrientationSliderWobble");
				emitter_selected.part_orientation_wobble = ImGui.SliderFloat("",emitter_selected.part_orientation_wobble,-5.000,5.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("wobble")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_orientation_wobble = 0.000;
				};
			ImGui.PopID();
					
			//Particle Gravity Sliders
			ImGui.NewLine()
			ImGui.Unindent();
			ImGui.Text("Gravity");
			ImGui.SameLine();
			ImGui.PushID("GravityValuesRandomize");
				if (ImGui.SmallButton("random")){
					emitter_selected.part_gravity_amount	= random_range(0.000,15.000);
					emitter_selected.part_gravity_direction	= random_range(0.000,359.000);
				};
			ImGui.PopID();
			ImGui.SameLine();
			ImGui.PushID("GravityValuesReset");
				if (ImGui.SmallButton("reset")){
					emitter_selected.part_gravity_amount	= 0.000;
					emitter_selected.part_gravity_direction	= 0.000;
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("GravitySliderAmount");
				emitter_selected.part_gravity_amount = ImGui.SliderFloat("",emitter_selected.part_gravity_amount,0.000,15.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("amount")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_gravity_amount = 0.000;
				};
			ImGui.PopID();
			ImGui.PushID("GravitySliderDirection");
				emitter_selected.part_gravity_direction = ImGui.SliderFloat("",emitter_selected.part_gravity_direction,0.000,359.000)
				if(ImGui.IsItemHovered()) {
					ImGui.SetTooltip("direction")
				}
				ImGui.SameLine();
				if (ImGui.Button("reset")){ 
					emitter_selected.part_gravity_direction = 0.000;
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
			ImGui.Indent(__indent);
			ImGui.PushID("AdditiveValueComboBox");
				if(ImGui.BeginCombo(" ",emitter_selected.part_additive.name,ImGuiComboFlags.None)){
					for (var __n = 0; __n < array_length(additive_items); __n++){
						var __is_selected = (emitter_selected.part_additive.key == additive_items[__n].key);
						if (ImGui.Selectable(additive_items[__n].name, __is_selected)){
							emitter_selected.part_additive = additive_items[__n];
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
			ImGui.Indent(__indent);
			ImGui.PushID("ColorTypeValueComboBox");
				if(ImGui.BeginCombo(" ",emitter_selected.part_color_type.name,ImGuiComboFlags.None)){
					for (var __n = 0; __n < array_length(color_type_items); __n++){
						var __is_selected = (emitter_selected.part_color_type.key == color_type_items[__n].key);
						if (ImGui.Selectable(color_type_items[__n].name, __is_selected)){
							emitter_selected.part_color_type = color_type_items[__n];
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
			ImGui.Text(emitter_selected.part_color_type.name == "Gradient"? "Color Start": "Color A");
			ImGui.SameLine();
			ImGui.PushID("ColorAValueRandomize");
				if (ImGui.SmallButton("random")){
					emitter_selected.part_color_a = irandom_range(c_white,c_black)
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("ColorAEditor");
			emitter_selected.part_color_a = ImGui.ColorEdit3("", emitter_selected.part_color_a);
			ImGui.PopID();
			ImGui.Unindent();
					
			//Particle Color B Editor
			ImGui.NewLine()
			ImGui.Text(emitter_selected.part_color_type.name == "Gradient"? "Color Middle": "Color B");
			ImGui.SameLine();
			ImGui.PushID("ColorBValueRandomize");
				if (ImGui.SmallButton("random")){
					emitter_selected.part_color_b = irandom_range(c_white,c_black)
				};
			ImGui.PopID();
			ImGui.Indent(__indent);
			ImGui.PushID("ColorBEditor");
			emitter_selected.part_color_b = ImGui.ColorEdit3("", emitter_selected.part_color_b);
			ImGui.PopID();
			ImGui.Unindent();
			
			if(emitter_selected.part_color_type.name == "Gradient"){
				//Particle Color C Editor
				ImGui.NewLine()
				ImGui.Text("Color End");
				ImGui.SameLine();
				ImGui.PushID("ColorBValueRandomize");
					if (ImGui.SmallButton("random")){
						emitter_selected.part_color_c = irandom_range(c_white,c_black)
					};
				ImGui.PopID();
				ImGui.Indent(__indent);
				ImGui.PushID("ColorBEditor");
				emitter_selected.part_color_c = ImGui.ColorEdit3("", emitter_selected.part_color_c);
				ImGui.PopID();
				ImGui.Unindent();
			}
					
            ImGui.EndTabItem();
        }
		if (ImGui.BeginTabItem("Export"))
        {
            ImGui.NewLine()
			ImGui.Text("Export Type");
			ImGui.Indent(__indent);
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
				if (ImGui.Button("Export",ImGui.GetContentRegionAvailX())){
					show_message("Exporting some bullshit")
				};
			ImGui.PopID();
            ImGui.EndTabItem();
        }
				
        ImGui.EndTabBar();
    }
ImGui.End();
#endregion
#region Emitter View
var __emitter_view_width = __main_width/5;
var __emitter_view_height = __main_height-19;
ImGui.SetNextWindowSize(__emitter_view_width, __emitter_view_height, ImGuiCond.Once);
ImGui.SetNextWindowPos(0,19,ImGuiCond.Once);
ImGui.Begin("Emitter Information", undefined, ImGuiWindowFlags.None, ImGuiReturnMask.Both);
	//if ImGui.IsWindowDocked() show_message(ImGui.GetWindowDockID());
	ImGui.Text("Emitters");
	var __list_width = ImGui.GetContentRegionAvailX();
	var __list_height = ImGui.GetContentRegionAvailY();
	var __indent = 20;
	if(ImGui.BeginListBox("",__list_width ,__list_height/2 )){
		for (var __n = 0; __n < array_length(global.emitter_layers); __n++){
			var __is_selected = (emitter_selected.name == global.emitter_layers[__n].name);
			if (ImGui.Selectable(global.emitter_layers[__n].name, __is_selected)){
				emitter_selected = global.emitter_layers[__n];
			}
			if (__is_selected){
				ImGui.SetItemDefaultFocus();
			}
		}
		ImGui.EndListBox()
	}
	ImGui.PushID("AddEmitter");
		if (ImGui.Button(" + ")){
			var __new_emitter = new EmitterLayer();
			array_push(global.emitter_layers, __new_emitter);
			emitter_selected = __new_emitter;
		};
	ImGui.PopID();
	ImGui.SameLine();
	ImGui.PushID("RemoveEmitter");
		if (ImGui.Button(" - ")){
			var __current_index = array_find_index(global.emitter_layers,function(_val){return _val.layer_id == emitter_selected.layer_id})
			array_delete(global.emitter_layers,__current_index,1);
			emitter_selected = array_length(global.emitter_layers)>0
							   ? global.emitter_layers[0]
							   : emitter_dummy;
		};
	ImGui.PopID();
		
	ImGui.NewLine();
	ImGui.Text("Emitter Properties");
	ImGui.Separator()
			
	ImGui.BeginDisabled(emitter_selected.layer_id==-1);
	ImGui.NewLine();
	ImGui.Text("Emitter");
	ImGui.Indent(__indent);
	ImGui.PushID("EmitterWidth");
		ImGui.PushItemWidth(ImGui.GetContentRegionAvailX()-__indent);
		emitter_selected.width = ImGui.SliderFloat("",emitter_selected.width,0.000,512.000)
		if(ImGui.IsItemHovered()) {
			ImGui.SetTooltip("width")
		}
		ImGui.PopItemWidth();
	ImGui.PopID();
	ImGui.PushID("EmitterHeight");
		ImGui.PushItemWidth(ImGui.GetContentRegionAvailX()-__indent);
		emitter_selected.height = ImGui.SliderFloat("",emitter_selected.height,0.000,512.000)
		if(ImGui.IsItemHovered()) {
			ImGui.SetTooltip("height")
		}
		ImGui.PopItemWidth();
	ImGui.PopID();
	ImGui.Unindent();
				
	ImGui.NewLine()
	ImGui.Text("Shape");
	ImGui.Indent(__indent);
	ImGui.PushID("EmitterShape");
		ImGui.PushItemWidth(ImGui.GetContentRegionAvailX()-__indent);
		if(ImGui.BeginCombo("",emitter_selected.shape.name,ImGuiComboFlags.None)){
			for (var __n = 0; __n < array_length(emitter_shapes); __n++){
				var __is_selected = (emitter_selected.shape.key == emitter_shapes[__n].key);
				if (ImGui.Selectable(emitter_shapes[__n].name, __is_selected)){
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
	ImGui.Indent(__indent);
	ImGui.PushID("EmitterDistribution");
		ImGui.PushItemWidth(ImGui.GetContentRegionAvailX()-__indent);
		if(ImGui.BeginCombo("",emitter_selected.distribution.name,ImGuiComboFlags.None)){
			for (var __n = 0; __n < array_length(emitter_distributions); __n++){
				var __is_selected = (emitter_selected.distribution.key == emitter_distributions[__n].key);
				if (ImGui.Selectable(emitter_distributions[__n].name, __is_selected)){
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
	ImGui.Indent(__indent);
	ImGui.PushID("EmitterParticleCount");
		ImGui.PushItemWidth(ImGui.GetContentRegionAvailX()-__indent);
		emitter_selected.particle_count = ImGui.SliderInt("",emitter_selected.particle_count,1,64)
		ImGui.PopItemWidth();
	ImGui.PopID();
	ImGui.Unindent();
	
	ImGui.NewLine();
	ImGui.Text("Stream Particles");
	ImGui.Indent(__indent);
	ImGui.PushID("EmitterStreamParticles");
		emitter_selected.stream = ImGui.Checkbox("",emitter_selected.stream)
	ImGui.PopID();
	
	ImGui.PushID("EmitterBurst");
		if (ImGui.Button("Burst",ImGui.GetContentRegionAvailX()-__indent)){
			show_message("Bursting everywhere.")
		};
	ImGui.PopID();
	ImGui.Unindent();
	
	ImGui.EndDisabled()

ImGui.End();
#endregion