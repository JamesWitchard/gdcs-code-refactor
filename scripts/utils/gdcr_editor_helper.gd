@tool
class_name GDCR_EditorHelper extends RefCounted

static func get_current_code_edit( plugin : EditorPlugin ) -> CodeEdit :
	var script_editor : ScriptEditor = plugin.get_editor_interface().get_script_editor();
	if ( !script_editor ) : return null;
	
	var editor : ScriptEditorBase = script_editor.get_current_editor();
	if ( !editor ) : return null;
	
	return _find_code_edit(editor);

static func _find_code_edit( node : Node ) -> CodeEdit :
	if ( node is CodeEdit) : return node;
	for child in node.get_children() :
		var result : CodeEdit = _find_code_edit(child);
		if ( result ) : return result
	
	return null;
