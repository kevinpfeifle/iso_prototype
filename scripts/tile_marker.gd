class_name TileMarker
extends Sprite2D

@export var animation_player: AnimationPlayer

enum Variant { SELECTED, BLOCKED }

signal clicked(tile: Tile, variant: Variant)

var variant: Variant:
	set(marker_variant):
		variant = marker_variant
		start_animation()
		
var hovered: bool

func start_animation():
	match variant:
		Variant.SELECTED:
			animation_player.play("selected")
			animation_player.speed_scale = 0.75
		Variant.BLOCKED:
			animation_player.play("blocked")
			animation_player.speed_scale = 0.75

func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_pressed():
		if variant == Variant.SELECTED:
			clicked.emit(get_parent(), variant)
