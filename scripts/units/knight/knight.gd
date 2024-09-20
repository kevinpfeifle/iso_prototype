class_name Knight
extends Unit

func _process(_delta):
	if health == 2:
		health_tracker.frame = 0
	elif health == 1:
		health_tracker.frame = 1
	elif health == 0:
		health_tracker.frame = 2
