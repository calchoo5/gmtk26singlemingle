extends AudioStreamPlayer

@onready var yes = preload("res://assets/audio/correct.mp3")
@onready var no = preload("res://assets/audio/answer-wrong.mp3")



func right():
	self.stream = yes
	self.play()

func wrong():
	self.stream = no
	self.play()
