@tool
class_name GDRF_Intention_DeclareFunction extends GDRF_IntentionBase

func get_id() -> String : 
	return "declare_function";
	
func get_text( context : GDRF_ScriptContext ) -> String :
	return "Declare function \"{func_name}\"".format({func_name = context.word_under_caret});

func is_available( context : GDRF_ScriptContext ) -> bool :
	# TODO: Real detection - look for function call or signal connection
	return !context.word_under_caret.is_empty() && context.word_under_caret.is_valid_identifier();
	
func apply( context : GDRF_ScriptContext ) -> void :
	# TODO: Insert empty func at bottom of script (or after current function)
	print("[GDRF] Would declare function: ", context.word_under_caret);
	pass;
