class_name UnitAttackState
extends UnitState

var target: Unit

## Simple attack state. Will need to be overriden for any that aren't simple melee attacks.
## When attacking, args[0] should be the targeted tile.
func enter(args):
	super(args)
	if (args[0].occupied()):
		target = args[0].occupant

		# Make the Unit face its target before attacking.
		if target.position.x > unit.position.x:
			unit.sprite.scale.x = 1
		elif target.position.x < unit.position.x:
			unit.sprite.scale.x = -1

		# Unit animations.  
		unit.animation_player.connect("animation_finished", _on_attack_complete)
		unit.animation_player.speed_scale = 1.75
		unit.animation_player.play("attack")

		# Deal with target health and animations.
		target.health -= unit.attack_damage
		target.animation_player.speed_scale = 1.75
		target.animation_player.play("hurt")
		if target.health <= 0:
			# TODO: If the target's state changes while dead is queued or running, but before
			# queue_free() is called, the target will not be removed from the scene tree.
			target.animation_player.queue("dead") # The "dead" animation will call queue_free().
			args[0].occupant = null
		else:
			
			target.animation_player.queue("idle")
	else:
		push_warning("Unit attempted to attack an empty tile. This shouldn't be possible!")
		transition.emit("idle", [])

func exit():
	super()
	unit.animation_player.speed_scale = 1
	if target != null:
		target.animation_player.speed_scale = 1

func _on_attack_complete(animation_name):
	if (animation_name == "attack"):
		transition.emit("idle", [])