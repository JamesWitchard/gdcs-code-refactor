@tool
class_name GDRF_IntentionPopup extends PopupMenu

var intention_manager : GDRF_IntentionManager; 

func initialize( manager : GDRF_IntentionManager) -> void :
	if ( !is_instance_valid(manager) ) : return; 
	intention_manager = manager;
	# TODO Connect id_pressed, populate items, position near caret, etc.
	hide();
	pass;
