extends VideoStreamPlayer

func _ready():
	connect("finished", _on_video_finished)
	play()  # Start playing the video

func _on_video_finished():
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://root.tscn")  # Change to your desired scene
