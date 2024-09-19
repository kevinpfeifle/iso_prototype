class_name UnitState
extends Node

signal transition(new_state: StringName, args: Array) # args is optional, if the state needs it.

@export var unit: Unit

var active: bool

## The State's setup function.
func enter(_args: Array) -> void:
	active = true
	
## The State's breakdown function.
func exit() -> void:
	active = false

## Mimics _process for the State, and gets called by StateManager if this is the active State.
func update(_delta: float) -> void:
	pass

## Mimics _physics_process for the State, and gets called by StateManager if this is the active State.
func physics_update(_delta: float) -> void:
	pass
