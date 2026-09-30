@tool
class_name GDRF_IntentionBase extends RefCounted

# Override these in every intention
func get_id() -> String : 
	return "base";
	
func get_text( context : GDRF_ScriptContext ) -> String :
	return "Base Intention";

func is_available( context : GDRF_ScriptContext ) -> bool :
	return false;
	
func apply( context : GDRF_ScriptContext ) -> void :
	pass;
	
