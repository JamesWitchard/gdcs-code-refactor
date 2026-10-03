@tool
class_name GDCR_ScriptContext extends RefCounted

var _edit : CodeEdit;
var _source_code : String;
var caret_line : int;
var caret_col : int;
var current_line_text : String;
var selected_text : String;

# filled by analyzer - expand as needed 
var word_under_caret : String = "";
var line_until_caret : String = "";
var is_inside_function : bool = false;
var current_function_name : String = "";
var is_function_call : bool = false;
var function_call_name : String = "";
var has_parentheses : bool = false;



# add more fields later (parsed calls, signals, local vars, etc.)

func _init( edit ) -> void :
	_edit = edit;
	_source_code = _edit.text;
	caret_line = _edit.get_caret_line();
	caret_col = _edit.get_caret_column();
	current_line_text = _edit.get_line(caret_line);
	selected_text = _edit.get_selected_text();
