@tool
extends EditorPlugin

var intention_manager : GDRF_IntentionManager; 
var intention_popup : GDRF_IntentionPopup; 

func _enter_tree() -> void:
	# Core systems
	intention_manager = GDRF_IntentionManager.new()
	intention_manager.initialize(self);
	
	# UI
	intention_popup = GDRF_IntentionPopup.new();
	intention_popup.initialize(intention_manager);
	get_editor_interface().get_base_control().add_child(intention_popup);
	
	var command_pallete : EditorCommandPalette = get_editor_interface().get_command_palette();
	command_pallete.add_command(
		"Show Intentions",
		GDRF_Constants.SHORTCUT_PATH,
		_show_intentions,
		"Alt + Enter"
	)
	
	_register_editor_shortcut();
	
	print("[%s] Plugin loaded." % GDRF_Constants.PLUGIN_NAME);
	pass

func _exit_tree() -> void:
	var command_palette : EditorCommandPalette = get_editor_interface().get_command_palette();
	command_palette.remove_command(GDRF_Constants.SHORTCUT_PATH);
	
	if (intention_popup && is_instance_valid(intention_popup) ) :
		intention_popup.queue_free();
	intention_manager = null;
	print("[%s] Plugin unloaded." % GDRF_Constants.PLUGIN_NAME);
	pass

func _shortcut_input(event: InputEvent) -> void:
	if ( !event.is_pressed() || event.is_echo() ) : return;
	
	var settings : EditorSettings = get_editor_interface().get_editor_settings();
	var shortcut : Shortcut = settings.get_shortcut(GDRF_Constants.SHORTCUT_PATH);
	
	if ( shortcut && shortcut.matches_event(event)) :
		_show_intentions();
		get_viewport().set_input_as_handled();
	pass;
	

func _show_intentions() -> void :
	var edit : CodeEdit = GDRF_EditorHelper.get_current_code_edit(self)
	if ( edit ) :
		intention_manager.show_intentions(edit);
	
	pass;

func _register_editor_shortcut() -> void :
	var settings : EditorSettings = get_editor_interface().get_editor_settings();
	if ( !settings.get_shortcut(GDRF_Constants.SHORTCUT_PATH) ) :
		var shortcut : Shortcut = Shortcut.new();
		var event : InputEventKey = InputEventKey.new();
		event.keycode = KEY_ENTER;
		event.alt_pressed = true;
		shortcut.events = [event];
		settings.add_shortcut(GDRF_Constants.SHORTCUT_PATH, shortcut);
	pass;
