extends AudioStreamPlayer

func play_song(song_file: AudioStream) -> void:
	self.stream = song_file
	self.play()
