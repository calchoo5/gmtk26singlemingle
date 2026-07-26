extends Control

@onready var dgb = $DialogueBox
@onready var chars = load("res://dialogues/characters.tres")
@onready var room = load("res://assets/images/Bedroom_Day.png")
@onready var cafe = load("res://assets/images/Cafeteria_Day.png")
@onready var store = load("res://assets/images/Backstreet_Summer_Day.png")



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
	'sad': load("res://assets/images/ppl/thehilaryclark-man-2285605_1920.png")
}

@onready var likes = {
	"irish": ["alcohol","woodworking"],
	"martial":["fighting","sticks"],
	"anon": ["masks","dancing"],
	'horse': ["hay","carrots"],
	"wbook": ["books","yaoi"],
	'jester': ["flutes","poker"],
	'posed': ["posing","standing"],
	'mbook': ["matcha","Clairo"],
	'omisido': ["smiling","work"],
	'thumbs': ["thumbs","approving"],
	'stare': ["staring","stalking"],
	'girl': ["beach","desserts"],
	'suit': ["aurafarming","flappy bird"],
	'asian': ["eating","exploring"],
	'camera': ["paparazzi","ginger"],
	'doc': ["air fryers","being smug"],
	'thinker': ["pondering","wondering"],
	'sad': ["nothing","smoking"]
}
@onready var dislikes = {
	"irish": ["england","rain"],
	"martial":["kids","losing"],
	"anon": ["government","dogs"],
	'horse': ["benadryl","bars"],
	"wbook": ["larping","men"],
	'jester': ["execution","disease"],
	'posed': ["sitting","gold"],
	'mbook': ["periods","men"],
	'omisido': ["not working","frowning"],
	'thumbs': ["thumbs down","disapproving"],
	'stare': ["blinking","sleeping"],
	'girl': ["rain","spiders"],
	'suit': ["sweating","work"],
	'asian': ["casinos","fried foods"],
	'camera': ["phones","basil"],
	'doc': ["patients","nurses"],
	'thinker': ["knowing","understanding"],
	'sad': ["everything","lotion"]
}

var gonow = false
var once = true
var starter
var random_pool: Array = []
var main_array: Array = []
var counter = 0
var correct = 0
var friends = 0
var dates = 0
var enemies = 0
var allowance = 0
var prevdate
var smart = 1
var cashieronce = true

var prebiscount = 0
var texted = true

var juststarted = true


func _ready() -> void:
	dgb.characters.clear()
	for character in chars.characters:
		dgb.characters.append(character)
	if juststarted:
		dgb.start('intro')
	else:
		$starting.visible = true
	$BG.texture = room
	%mone.text = "$" + str(allowance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.die && once:
		once = false
		$dater.visible = false
		$choices.visible = false
		$paper.visible = false
		Bgm.relax()
		$result.visible = true
		%frenct.text = str(friends)
		%date2.text = str(dates)
		%hate2.text = str(enemies)
		allowance = friends*smart + (dates*1.5) - (enemies*2)
		%allow2.text = "$" +str(allowance)
		%mone.text = "$" + str(allowance)
	%mone.text = "$" + str(allowance)


func _on_setbutton_pressed() -> void:
	$settings.visible = true


func _on_date_pressed() -> void:
	Global.die = false
	once = true
	friends = 0
	dates = 0
	enemies = 0
	$BG.texture = cafe
	$starting.visible = false
	Bgm.gotime()
	$timer.time_left = 10
	$timer.timerstart = true
	$timer.is_running = true
	if Global.firstplay:
		dgb.start('datetest')
	else:
		dgb.start('datestart')
	


func _on_store_pressed() -> void:
	if Global.firstplay:
		dgb.start("firstplay")
		return
	$BG.texture = store
	$starting.visible = false
	Bgm.shop()
	$cashier.visible = true
	$shop.visible = true
	if cashieronce:
		dgb.start("store")
		cashieronce = false
	else:
		$gohome.visible = true
	


func _on_dialogue_box_dialogue_signal(value: String) -> void:
	if value == "finito":
		$starting.visible = true
	if value == "datego":
		nextdate()
	if value == "finalend":
		$BG.texture = room
		$starting.visible = true
	if value == "cashierend":
		$gohome.visible = true
	if value == "smart":
		smart = 1.25
	if value == "dead":
		$died.visible = true
		$died/Label.text = "Died of Dr. Prebis Overdose."
	if value == "theend":
		$winner.visible = true
	if value == "datedead":
		$died.visible = true
		$died/Label.text = "Died of Lying Too Damn Much."
	if value == "enemydead":
		$died.visible = true
		$died/Label.text = "Died of Getting Butt Kicked."

func nextdate() -> void:
	main_array.clear()
	counter = 0
	correct = 0
	starter = suitors.keys()[randi()%suitors.size()]
	while starter == prevdate:
		starter = suitors.keys()[randi()%suitors.size()]
	prevdate = starter
	$dater.texture = suitors[starter]
	$dater.visible = true
	$timer.visible = true
	$timer.timerstart = true
	$paper.visible = true
	$choices.visible = true
	main_array = [likes[starter][0],likes[starter][1],dislikes[starter][0],dislikes[starter][1]]
	%likes.text = "• %s\n• %s\n" % [main_array[0],main_array[1]]
	%dislikes.text = "• %s\n• %s\n" % [main_array[2],main_array[3]]
	randobutton()

func _on_quitting_pressed() -> void:
	#nextdate()
	#$dater.texture = suitors[suitors.keys()[randi()%suitors.size()]]
	get_tree().change_scene_to_file("res://menu.tscn")
	
func get_random_without_repeats():
	# If the pool is empty, refill it from the master list and shuffle
	if random_pool.is_empty():
		random_pool = main_array.duplicate()
		random_pool.shuffle()
	# pop_back() removes and returns the last element efficiently
	return random_pool.pop_back()


func _on_choice_1_pressed() -> void:
	if $choices/choice1.text in likes[starter]:
		Sfx.right()
		counter += 1
		correct += 1
	else:
		Sfx.wrong()
		counter += 1
	checktwice()


func _on_choice_2_pressed() -> void:
	if $choices/choice2.text in likes[starter]:
		Sfx.right()
		counter += 1
		correct += 1
	else:
		Sfx.wrong()
		counter += 1
	checktwice()


func _on_choice_3_pressed() -> void:
	if $choices/choice3.text in likes[starter]:
		Sfx.right()
		counter += 1
		correct += 1
	else:
		Sfx.wrong()
		counter += 1
	checktwice()

func _on_choice_4_pressed() -> void:
	if $choices/choice4.text in likes[starter]:
		Sfx.right()
		counter += 1
		correct += 1
	else:
		Sfx.wrong()
		counter += 1
	checktwice()

	
func checktwice():
	if counter >= 2:
		if correct == 1:
			friends += 1
		elif correct == 2:
			dates += 1
		else:
			enemies += 1
		nextdate()
		randobutton()
		return
	else:
		randobutton()

func randobutton():
	$choices/choice1.text = get_random_without_repeats()
	$choices/choice2.text = get_random_without_repeats()
	$choices/choice3.text = get_random_without_repeats()
	$choices/choice4.text = get_random_without_repeats()
	

func _on_button_pressed() -> void:
	if enemies > 7:
		dgb.start("enemied")
	elif dates > 7:
		dgb.start("dated")
	elif Global.firstplay:
		dgb.start("end")
		Global.firstplay = false
		$timer.timerstart = false
	else:
		dgb.start("ended")
		$timer.timerstart = false
	$result.visible = false
	$timer.visible = false


func _on_gohome_pressed() -> void:
	$cashier.visible = false
	$shop.visible = false
	$gohome.visible = false
	$starting.visible = true
	$BG.texture = room
	Bgm.relax()


func _on_soda_pressed() -> void:
	if allowance >=5:
		allowance -= 5
		prebiscount += 1
		if prebiscount < 20:
			dgb.start("prebis")
		else:
			dgb.start("overdose")
	else:
		dgb.start("broke")


func _on_textbook_pressed() -> void:
	if (allowance >= 20) && texted:
		allowance -= 20
		dgb.start("textbook")
		texted = false
	elif !texted:
		dgb.start("gone")
	else:
		dgb.start("broke")


func _on_winb_pressed() -> void:
	if allowance >=169:
		allowance -= 169
		dgb.start("win")
	else:
		dgb.start("broke")
