extends Control

@onready var dgb = $DialogueBox
@onready var chars = load("res://dialogues/characters.tres")
@onready var room = load("res://assets/images/Bedroom_Day.png")
@onready var cafe = load("res://assets/images/Cafeteria_Day.png")
@onready var cafebgm = load("res://assets/audio/atlasaudio-energetic-energetic-music-507828.mp3")



@onready var suitors = {
	"irish": load("res://assets/images/ppl/12022868-isolated-4570748_1920.png"),
	"martial": load("res://assets/images/ppl/alvorcem-arnis-kali-3342113_1920.png"),
	"anon": load("res://assets/images/ppl/geierweb-guy-4628808_1920.png"),
	'horse': load("res://assets/images/ppl/maja7777-horse-head-3730326_1920.png"),
	"wbook": load("res://assets/images/ppl/maja7777-woman-5309387_1920.png"),
	'jester': load("res://assets/images/ppl/momentmal-jester-2835285_1920.png"),
	'posed': load("res://assets/images/ppl/nati0988-boy-1080167_1920.png"),
	'mbook': load("res://assets/images/ppl/omerzarnaab-student-3496312_1920.png"),
	'omisido': load("res://assets/images/ppl/omisido-smile-3660166_1920.png"),
	'thumbs': load("res://assets/images/ppl/publicdomainpng-guy-3220439_1920.png"),
	'stare': load("res://assets/images/ppl/publicdomainpng-guy-3237859_1920.png"),
	'girl': load("res://assets/images/ppl/publicdomainpng-model-3296470_1920.png"),
	'suit': load("res://assets/images/ppl/publicdomainpng-photo-shoot-3321569_1920.png"),
	'asian': load("res://assets/images/ppl/rauschenberger-person-3248202_1920.png"),
	'camera': load("res://assets/images/ppl/thehilaryclark-isolated-1182220_1920.png"),
	'doc': load("res://assets/images/ppl/thehilaryclark-isolated-1188036_1920.png"),
	'thinker': load("res://assets/images/ppl/thehilaryclark-isolated-1197345_1920.png"),
	'sad': load("res://assets/images/ppl/thehilaryclark-man-2285605_1920.png"),
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 1. Clear any broken editor-canned data safely
	dgb.characters.clear()
	
	# 2. Append the elements one by one to preserve the plugin's exact internal type
	for character in chars.characters:
		dgb.characters.append(character)
	
	# 3. Print to confirm the list is populated and valid
	print("Loaded Characters: ", dgb.characters)
	dgb.start('intro')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_setbutton_pressed() -> void:
	$settings.visible = true


func _on_date_pressed() -> void:
	$BG.texture = cafe
	$starting.visible = false
	Bgm.stream = cafebgm
	Bgm.play()
	if Global.firstplay:
		dgb.start('datetest')
		Global.firstplay = false
	else:
		dgb.start('date')
	


func _on_store_pressed() -> void:
	if Global.firstplay:
		dgb.start("firstplay")


func _on_dialogue_box_dialogue_signal(value: String) -> void:
	if value == "finito":
		$starting.visible = true
	if value == "datego":
		$dater.texture = suitors[suitors.keys()[randi()%suitors.size()]]


func _on_quitting_pressed() -> void:
	$dater.texture = suitors[suitors.keys()[randi()%suitors.size()]]
	#get_tree().change_scene_to_file("res://menu.tscn")
