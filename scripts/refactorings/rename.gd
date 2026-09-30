@tool

class_name GDRF_Refector_Rename extends RefCounted

# Skeleton for in-file rename (will be called from an intention or menu later)
static func rename_in_file( edit : CodeEdit, old_name : String, new_name : String ) -> void :
	# TODO: Proper scoped rename (respect comments, strings, word boundaries).
	var text : String = edit.text;
	# Very naive version - replace later
	text = text.replace(old_name, new_name);
	edit.text = text;	
	pass;
