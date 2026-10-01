@tool
class_name GDCR_IntentionPopup extends PopupMenu

var intention_manager : GDCR_IntentionManager; 

func initialize( manager : GDCR_IntentionManager) -> void :
	if ( !is_instance_valid(manager) ) : return; 
	intention_manager = manager;
	# TODO Connect id_pressed, populate items, position near caret, etc.
	hide();
	pass;
