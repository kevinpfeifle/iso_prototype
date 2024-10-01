class_name UnitRestingState
extends UnitState

func enter(args):
	super(args)
	if unit.animation_player.current_animation != "idle":
		unit.animation_player.play("idle")
	unit.sprite.modulate = Color("#676767")
	# This enables/disables the _input function for a class if it was
	# overriden. So, this would help to disable a unit in the player's
	# turn.
	#unit.set_process_input(false)
	unit.propagate_call("set_process_input", [false])
	
func exit():
	super()
	unit.sprite.modulate = Color("#FFFFFF")
	#unit.set_process_input(true)
	unit.propagate_call("set_process_input", [true])
