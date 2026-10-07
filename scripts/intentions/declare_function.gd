@tool
class_name GDCR_Intention_DeclareFunction extends GDCR_IntentionBase

func get_id() -> String : 
    return "declare_function";
    
func get_text( context : GDCR_ScriptContext ) -> String :
    return "Declare function \"{func_name}\"".format({func_name = context.function_call_name});

func is_available( context : GDCR_ScriptContext ) -> bool :
    var is_available : bool = false;
    if ( context.word_under_caret.is_empty() ) : return false;
    # TODO: Real detection - look for function call or signal connection
    # check to see if function call
    is_available = context.is_function_call && !context.function_exists;
    return is_available;
    
func apply( context : GDCR_ScriptContext ) -> void :
    # TODO: Insert empty func at bottom of script (or after current function)
    #print("[{plugin_name}] Would declare function: {word}".format({
        #plugin_name = GDCR_Constants.PLUGIN_NAME,
        #word = context.function_call_name
    #}));
    var edit = context._edit;
    var source = context.source_code;
    var function = _build_function(context);
    var insert_line : int = edit.get_line_count();
    var insert_line_end : int = edit.get_caret_column(edit.get_line(insert_line).length())
            
    GDCR_TextHelper.insert_text(edit, insert_line, insert_line_end, function);
    edit.set_caret_line(insert_line + 1) # + 1 because for some reason this puts the caret in the new function line
    edit.set_caret_column(insert_line_end)
    insert_line = edit.get_line_count()
    source = edit.text;
    
    pass;

func _build_function( context : GDCR_ScriptContext ) -> String :
    var settings : EditorSettings = EditorInterface.get_editor_settings();
    var indent_type : String = "\t"
    
    if ( settings.get_setting("text_editor/behavior/indent/type") == 1 ) :
        indent_type = "";
        for i in int(settings.get_settings("text_editor/behavior/indent/size")) :
            indent_type += "1"
    print(indent_type);
    var func_string : String = "\nfunc {name}({args}) -> {ret} : \n{tab}\n{tab}return\n".format({
        name = context.function_call_name,
        args = "",
        ret = "void",
        tab = "\t"
    })
    return func_string;
