class_name UnitStateMachine
extends Node

@export var current_state: UnitState
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is UnitState:
			states[child.name.to_lower()] = child
			child.transition.connect(_on_child_transition)
			
	current_state.enter([]) # Initial state.

func _process(delta):
	current_state.update(delta)
		
func _physics_process(delta):
	current_state.physics_update(delta)

func _on_child_transition(new_state: StringName, args: Array) -> void:
	var next_state = states.get(new_state.to_lower())
	if (next_state != null and next_state != current_state):
		current_state.exit()
		next_state.enter(args)
		current_state = next_state
