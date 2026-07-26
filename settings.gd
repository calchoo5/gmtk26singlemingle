extends Control

var mode := DisplayServer.window_get_mode()
var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_window:
		%fullscreen.button_pressed = false
	else:
		%fullscreen.button_pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_master_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_bgm_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_sfx_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

func _on_exit_pressed() -> void:
	self.visible = false
