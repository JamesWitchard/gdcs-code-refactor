@tool
class_name GDRF_Intention_CreateSignal extends GDRF_IntentionBase


func get_id() -> String : 
	return "create_signal";
	
func get_text( context : GDRF_ScriptContext ) -> String :
	return "Create signal \"%s\"" % context.word_under_caret;

func is_available( context : GDRF_ScriptContext ) -> bool :
	# TODO: Detect emit_signal("name") or name.emit(...)
	return false; # disabled until detection is written.
	
func apply( context : GDRF_ScriptContext ) -> void :
	print("[GDRF] Would create signal: ", context.word_under_caret);
	pass;
