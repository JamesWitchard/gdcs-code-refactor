@tool
class_name GDRF_Intention_IntroduceVariable extends GDRF_IntentionBase

func get_id() -> String : 
	return "introduce_variable";
	
func get_text( context : GDRF_ScriptContext ) -> String :
	return "Introduce local variable";

func is_available( context : GDRF_ScriptContext ) -> bool :
	return !context.selected_text.is_empty();
	
func apply( context : GDRF_ScriptContext ) -> void :
	# TODO: Replace selection with a new variable and declare it above.
	print("[GDRF] Would introduce variable for: ", context.selected_text);
	pass;
