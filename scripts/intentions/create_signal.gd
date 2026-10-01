@tool
class_name GDCR_Intention_CreateSignal extends GDCR_IntentionBase


func get_id() -> String : 
	return "create_signal";
	
func get_text( context : GDCR_ScriptContext ) -> String :
	return "Create signal \"%s\"" % context.word_under_caret;

func is_available( context : GDCR_ScriptContext ) -> bool :
	# TODO: Detect emit_signal("name") or name.emit(...)
	return false; # disabled until detection is written.
	
func apply( context : GDCR_ScriptContext ) -> void :
	print("[{plugin_name}] Would create signal: {word}".format({
		plugin_name = GDCR_Constants.PLUGIN_NAME,
		word = context.word_under_caret
	}));
	pass;
