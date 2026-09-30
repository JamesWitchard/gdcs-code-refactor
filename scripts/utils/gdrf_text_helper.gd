@tool
class_name GDRF_TextHelper extends RefCounted

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
