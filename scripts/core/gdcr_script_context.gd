@tool
class_name GDCR_ScriptContext extends RefCounted

var _edit : CodeEdit;
var source_code : String;
var caret_line : int;
var caret_col : int;
var current_line_text : String;
var selected_text : String;

# filled by analyzer - expand as needed 
var word_under_caret : String = "";
var line_until_caret : String = "";
var col_after_word : int = 0;
var is_inside_function : bool = false;
var current_function_name : String = "";
var is_function_call : bool = false;
var function_call_name : String = "";
var has_parentheses : bool = false;
var parenthesis_col : int = 0;
var function_exists : bool = false;



# add more fields later (parsed calls, signals, local vars, etc.)

func _init( edit : CodeEdit ) -> void :
	_edit = edit;
	source_code = _edit.text;
	caret_line = _edit.get_caret_line();
	caret_col = _edit.get_caret_column();
	current_line_text = _edit.get_line(caret_line);
	selected_text = _edit.get_selected_text();
