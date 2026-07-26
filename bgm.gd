extends AudioStreamPlayer

@onready var chill = preload("res://assets/audio/andriih-bossa-nova-jazz-music-572268.mp3")
@onready var energy = preload("res://assets/audio/atlasaudio-energetic-energetic-music-507828.mp3")
@onready var shopping = preload("res://assets/audio/prettyjohn1-chill-chill-music-505125.mp3")



func relax():
	self.stream = chill
	self.play()

func gotime():
	self.stream = energy
	self.play()
	
func shop():
	self.stream = shopping
	self.play()
