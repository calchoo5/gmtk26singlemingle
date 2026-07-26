extends Control

@onready var dgb = $DialogueBox
@onready var chars = load("res://dialogues/characters.tres")
@onready var room = load("res://assets/images/Bedroom_Day.png")
@onready var cafe = load("res://assets/images/Cafeteria_Day.png")
@onready var cafebgm = load("res://assets/audio/atlasaudio-energetic-energetic-music-507828.mp3")

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
	Global.firstplay = false
	Bgm.stream = cafebgm
	Bgm.play()
	


func _on_store_pressed() -> void:
	if Global.firstplay:
		dgb.start("firstplay")


func _on_dialogue_box_dialogue_signal(value: String) -> void:
	if value == "finito":
		$starting.visible = true


func _on_quitting_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
