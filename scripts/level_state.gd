extends Node2D

var selected_unit: Unit:
	set(new_unit):
		if selected_unit != null and selected_unit != new_unit:
			selected_unit.unselected.emit()
		selected_unit = new_unit
