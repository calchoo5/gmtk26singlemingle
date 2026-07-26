extends Label

var time_left: float = 12.0 # Start time in seconds
var is_running: bool = true
var timerstart = false

func _process(delta: float) -> void:
	if timerstart:
		if is_running and time_left > 0.0:
			time_left -= delta
			if time_left <= 0.0:
				time_left = 0.0
				is_running = false
				text = "00:00"
			else:
				update_display()
		else:
			Global.die = true

func update_display() -> void:
	var total_seconds: int = int(time_left)
	var milliseconds: int = int((time_left - total_seconds) * 100)
	
	text = "%02d:%02d" % [total_seconds, milliseconds]
