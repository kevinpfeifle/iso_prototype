class_name UnitSelectedState
extends UnitState

var marked_tiles: Array = []

func enter(args: Array) -> void:
	super(args)
	unit.sprite.material.set_shader_parameter("progress", 1) # Outline the selected Unit.
	unit.unselected.connect(_on_unit_unselected)
	unit.owner.selected_unit = unit
	if unit.animation_player.get_assigned_animation() != "idle":
		unit.animation_player.play("idle")
		
func exit() -> void:
	super()
	unit.sprite.material.set_shader_parameter("progress", 0) # Remove the outline.

# TODO: THIS WHOLE THING MIGHT BE THROWN OUT.
# Perhaps opt for the current selected unit to be saved by the root scene, and have a button to cancel
# selection. If a unit other than the current selected unit is clicked, set the old one to idle, and 
# new one to the selected one?
func _unhandled_input(event):
	if active and event.is_pressed():
		# TODO: Will need to set these also on all clickable areas, and then check all of them each time.
		# still easier than checking coords... there must be a better way?
		if not unit.hovered and not is_marked_tile_hovered():
			transition.emit("Idle", [])

func is_marked_tile_hovered():
	for tile in marked_tiles:
		if tile.marked() and tile.marker.hovered:
			return true
	return false
	
func _on_unit_unselected():
	transition.emit("Idle", [])
	
#func process(delta) -> void:
	## Transition to Walk State if velocity is ever non-zero.
	#if unit.velocity != Vector2(0, 0):
		#transition.emit("Walk")
