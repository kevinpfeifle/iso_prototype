class_name TileMarker
extends Sprite2D

@export var animation_player: AnimationPlayer

enum Variant { SELECTED, BLOCKED, TARGETED }

signal clicked(tile: Tile, variant: Variant)

var variant: Variant:
	set(marker_variant):
		variant = marker_variant
		start_animation()
		
var hovered: bool

func start_animation():
	animation_player.speed_scale = 0.75
	match variant:
		Variant.SELECTED:
			animation_player.play("selected")
		Variant.BLOCKED:
			animation_player.play("blocked")
		Variant.TARGETED:
			animation_player.play("targeted")

func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_pressed():
		if [Variant.SELECTED, Variant.TARGETED].has(variant):
			clicked.emit(get_parent(), variant)
			get_viewport().set_input_as_handled()
