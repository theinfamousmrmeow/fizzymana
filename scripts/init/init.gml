gml_pragma("global", "init()");
function init(){

	//Dev Objects;
	
	room_instance_add( room_first, 0, 0, objImguiWrapper );
	//Debug Boi calls InitFirstRoom
	
	

		
	
	for (var i = room_first; i <= room_last; ++i) {
	    // code here
		room_set_view_enabled(i,true);
	}

	//SYSTEM INITS;

	
}
function initFirstRoom(){
	//LOG_I("init first room...");
}