@tool
class_name GDCR_IntentionManager extends RefCounted

var plugin : EditorPlugin;
var intentions : Array[GDCR_IntentionBase];

func initialize( p_plugin : EditorPlugin ) -> void :
	if ( !is_instance_valid(p_plugin) ) : return;
	plugin = p_plugin;
	_register_intentions();
	

func show_intentions( edit : CodeEdit ) -> void :
	if ( !edit ) : return;
	var context : GDCR_ScriptContext = GDCR_ScriptAnalyzer.build_context(edit);
	var available : Array[GDCR_IntentionBase] = [];
	
	if ( !is_instance_valid(context) ) : return;
	
	for intention in intentions :
		if ( intention.is_available(context)) :
			available.append(intention);
	
	if ( available.is_empty() ) :
		print( "[%s] No Intentions Available" % GDCR_Constants.PLUGIN_NAME);
		return;
	
	# TODO: Hand over to the popup UI,
	# For now, just print them.
	print("[%s] Available intentions:" % GDCR_Constants.PLUGIN_NAME);
	for intention in available :
		print("  - ", intention.get_text(context));
		intention.apply(context);
	
	pass;

func _register_intentions() -> void :
	# append every intention here
	intentions.append(GDCR_Intention_DeclareFunction.new());
	intentions.append(GDCR_Intention_IntroduceVariable.new());
	intentions.append(GDCR_Intention_CreateSignal.new());
	# Later: intentions.append(preload("res://addons/gdcs/intentions/whatever.gd").new())
	pass;
