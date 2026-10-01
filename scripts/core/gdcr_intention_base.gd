@tool
class_name GDCR_IntentionBase extends RefCounted

# Override these in every intention
func get_id() -> String : 
	return "base";
	
func get_text( context : GDCR_ScriptContext ) -> String :
	return "Base Intention";

func is_available( context : GDCR_ScriptContext ) -> bool :
	return false;
	
func apply( context : GDCR_ScriptContext ) -> void :
	pass;
	
