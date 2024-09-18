extends Node2D

@export var selected_unit: Unit:
	set(new_unit):
		if selected_unit != null:
			selected_unit.unselected.emit()
		selected_unit = new_unit
