extends Control

var mode := DisplayServer.window_get_mode()
var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN

var master = AudioServer.get_bus_index("Master")
var bgm = AudioServer.get_bus_index("BGM")
var sfx = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_window:
		%fullscreen.button_pressed = false
	else:
		%fullscreen.button_pressed = true
	%master.value = AudioServer.get_bus_volume_linear(master)
	%bgm.value = AudioServer.get_bus_volume_linear(bgm)
	%sfx.value = AudioServer.get_bus_volume_linear(sfx)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master,linear_to_db(value))


func _on_bgm_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm,linear_to_db(value))


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx,linear_to_db(value))


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

func _on_exit_pressed() -> void:
	self.visible = false
