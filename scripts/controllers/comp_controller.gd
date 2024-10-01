extends Node2D
class_name CompController

enum State { ACTIVE, IDLE }

signal turn_completed

var cur_state: State
var units: Array[Unit]

var selected_unit: Unit:
	set(new_unit):
		if selected_unit != null and selected_unit != new_unit:
			selected_unit.unselected.emit()
		selected_unit = new_unit

func _ready():
	for unit in $Units.get_children():
		unit.resting.connect(_on_unit_resting)
		units.append(unit)

	cur_state = State.ACTIVE

func _on_unit_resting():
	var remaining_units: bool = false
	for unit in units:
		var unit_state_machine: Node2D = unit.get_node("$StateMachine")
		if unit_state_machine.current_state != unit_state_machine.UnitState.resting:
			remaining_units = true
	
	if !remaining_units:
		# Handle transitioning to the comp's turn.
		cur_state = State.IDLE
		turn_completed.emit()
