@tool
class_name GDCR_Intention_DeclareFunction extends GDCR_IntentionBase

func get_id() -> String : 
	return "declare_function";
	
func get_text( context : GDCR_ScriptContext ) -> String :
	return "Declare function \"{func_name}\"".format({func_name = context.word_under_caret});

func is_available( context : GDCR_ScriptContext ) -> bool :
	# TODO: Real detection - look for function call or signal connection
	return !context.word_under_caret.is_empty() && context.word_under_caret.is_valid_identifier();
	
func apply( context : GDCR_ScriptContext ) -> void :
	# TODO: Insert empty func at bottom of script (or after current function)
	print("[{plugin_name}] Would declare function: {word}".format({
		plugin_name = GDCR_Constants.PLUGIN_NAME,
		word = context.word_under_caret
	}));
	pass;
