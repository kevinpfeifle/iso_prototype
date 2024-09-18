class_name UnitIdleState
extends UnitState

func enter(args: Array) -> void:
	super(args)
	unit.clicked.connect(_on_unit_clicked)
	unit.velocity = Vector2(0, 0)
	if unit.animation_player.current_animation != "idle":
		unit.animation_player.play("idle")
	
func exit() -> void:
	super()
	unit.clicked.disconnect(_on_unit_clicked)

#func process(_delta) -> void:
	## Transition to Walk State if velocity is ever non-zero.
	#if unit.velocity != Vector2(0, 0):
		#transition.emit("Walk")

# TODO: Add logic here to conditionally allow when a click selects the unit.
func _on_unit_clicked():
	if active:
		transition.emit("Selected", [])
