extends Node2D
class_name PlayerController

# TODO: Determine if this state is necessary. If you do "turns" it is needed.
## When the PlayerController is in an ACTIVE state, the player can interact with the game.
## When in IDLE state, they can only view the game (move camera, hover for info, etc).
enum State { ACTIVE, IDLE }

var cur_state: State
var units: Array[Unit]

var selected_unit: Unit:
	set(new_unit):
		if selected_unit != null and selected_unit != new_unit:
			selected_unit.unselected.emit()
		selected_unit = new_unit

func _ready():
	for unit in $PlayerUnits.get_children():
		units.append(unit)

	cur_state = State.ACTIVE
