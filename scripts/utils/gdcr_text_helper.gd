@tool
class_name GDCR_TextHelper extends RefCounted

static func insert_text( edit : CodeEdit, line : int, column : int, text : String ) -> void :
	if (!is_instance_valid(edit)) : return; 
	
	edit.set_caret_line(line);
	edit.set_caret_column(column);
	edit.insert_text_at_caret(text);
	pass;
	
static func get_indent_for_line( edit : CodeEdit, line : int ) -> String :
	if ( !is_instance_valid(edit) ) : return ""	
	var line_text : String = edit.get_line(line);
	var indent : String = "";
	for i in line_text.length() :
		var c : String = line_text[i];
		if ( c == " " || c == "\t" ) :
			indent += c;
		else : 
			break;
	return indent;
	
static func get_col_at_end_of_word( word : String, edit : CodeEdit ) -> int :
	if ( word.is_empty() || !is_instance_valid(edit) ) : return -1;

	var col : int = edit.get_caret_column();
	var line : String = edit.get_line(edit.get_caret_line());
	var end : int = col;
	while ( end < line.length() && (line[end].is_valid_ascii_identifier() || line[end] == "_") ) :
		end += 1;
	return end;
	
static func get_beginning_of_word( word : String, edit : CodeEdit ) -> int :
	if ( word.is_empty() || !is_instance_valid(edit) ) : return -1;
	
	var col : int = edit.get_caret_column();
	var line : String = edit.get_line(edit.get_caret_line());
	var start : int = 0;
	while ( start < line.length() ) :
		pass
	
	
	return 0;


static func does_function_exist( source_code : String, new_function_name : String, edit : CodeEdit ) -> bool :
	var script : Script = EditorInterface.get_script_editor().get_current_script();
	if ( script ) :
		var methods : Array[Dictionary] = script.get_script_method_list();
		for method : Dictionary in methods : 
			if ( method["name"] == new_function_name ) :
				#print(method)
				return true;
	return false;
