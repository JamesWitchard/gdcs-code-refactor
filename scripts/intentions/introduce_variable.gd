@tool
class_name GDCR_Intention_IntroduceVariable extends GDCR_IntentionBase

func get_id() -> String : 
	return "introduce_variable";
	
func get_text( context : GDCR_ScriptContext ) -> String :
	return "Introduce local variable";

func is_available( context : GDCR_ScriptContext ) -> bool :
	return !context.selected_text.is_empty();
	
func apply( context : GDCR_ScriptContext ) -> void :
	# TODO: Replace selection with a new variable and declare it above.
	print("[{plugin_name}] Would introduce variable for: {word}".format({
		plugin_name = GDCR_Constants.PLUGIN_NAME,
		word = context.word_under_caret
	}));
	pass;
