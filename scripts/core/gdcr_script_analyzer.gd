@tool
class_name GDCR_ScriptAnalyzer extends RefCounted

static func build_context( edit : CodeEdit ) -> GDCR_ScriptContext :
	var ctx : GDCR_ScriptContext = GDCR_ScriptContext.new(edit);
	
	# basic extraction: expand later
	ctx.word_under_caret = _get_word_under_caret(edit);
	ctx.line_until_caret = ctx.current_line_text.substr(0, ctx.caret_col);
	
	# look for parenthesis at the end of word_under_caret and fill out variables
	if ( ctx.current_line_text.find("(", 0) >= 0) :
		# has opening parenthesis, dont need to check for closing until 
		# we implement member extraction
		ctx.has_parentheses = true;
	ctx.is_function_call = ctx.has_parentheses;
	
	print( "Is word under text a function call? ", ctx.is_function_call)
	
	# TODO: Detect if inside a function, current function name, etc
	# TODO: Regex for function calls, signal emits, connects...
	
	return ctx
	
static func _get_word_under_caret( edit : CodeEdit ) -> String :
	var line : String = edit.get_line(edit.get_caret_line());
	var col : int = edit.get_caret_column();
	
	# very simple word boundary - improve later
	var start : int = col;
	while ( start > 0 && (line[start - 1].is_valid_identifier() || line[start - 1] == "_") ) :
		start -= 1;
	var end : int = col;
	while ( end < line.length() && (line[end].is_valid_identifier() || line[end] == "_") ) :
		end += 1;
	
	return line.substr(start, end - start);
