@tool
class_name GDCR_ScriptAnalyzer extends RefCounted

static func build_context( edit : CodeEdit ) -> GDCR_ScriptContext :
	var ctx : GDCR_ScriptContext = GDCR_ScriptContext.new(edit);
	
	# basic extraction: expand later
	ctx.word_under_caret = _get_word_under_caret(edit);
	ctx.line_until_caret = ctx.current_line_text.substr(0, ctx.caret_col);
	ctx.col_after_word = GDCR_TextHelper.get_col_at_end_of_word(ctx.word_under_caret, edit);
	if ( ctx.col_after_word > ctx.current_line_text.length() ) : return null;
	var opening_parenthesis_col : int = _check_next_char_parenthesis(
		ctx.col_after_word, ctx.current_line_text);
	
	# look for parenthesis at the end of word_under_caret and fill out variables
	if ( opening_parenthesis_col != -1 ) :
		# has opening parenthesis, dont need to check for closing until 
		# we implement member extraction
		ctx.has_parentheses = true;
		ctx.function_call_name = ctx.word_under_caret;
		ctx.parenthesis_col = opening_parenthesis_col;
		ctx.function_exists = GDCR_TextHelper.does_function_exist(ctx.source_code, 
			ctx.function_call_name, edit);
			
		# For now just set is class function so we can not apply intention if true.
		# TODO: Add ability to add nonexistent functions to their respective class.
		ctx.is_class_function = _is_class_function(ctx.caret_col, ctx.current_line_text) != -1;
		
	ctx.is_function_call = ctx.has_parentheses;
	
	# TODO: Detect if inside a function, current function name, etc
	# TODO: Regex for function calls, signal emits, connects...
	return ctx
	
static func _get_word_under_caret( edit : CodeEdit ) -> String :
	var line : String = edit.get_line(edit.get_caret_line());
	var col : int = edit.get_caret_column();
	
	# very simple word boundary - improve later
	var start : int = col;
	while ( start > 0 && (line[start - 1].is_valid_ascii_identifier() || line[start - 1] == "_") ) :
		start -= 1;
	var end : int = col;
	while ( end < line.length() && (line[end].is_valid_ascii_identifier() || line[end] == "_") ) :
		end += 1;
	return line.substr(start, end - start);

static func _check_next_char_parenthesis( start : int, line : String) -> int :
	while ( start < line.length() && (line[start] == " " || line[start] == "\t") ) :
		start += 1;
	if ( start < line.length() && line[start] == "(" ) :
		return start;
	return -1;

static func _is_class_function( start : int, line : String ) -> int :
	if ( line[0] == "\t" ) :
		start += 4;
	while ( start > 0 ) :
		start -= 1;
		if ( start >= 0 && line[start] == "." ) : 		# is member variable
			return start;	
	return -1;
