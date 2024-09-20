class_name Unit
extends CharacterBody2D

@export var unit_name: String
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var health_tracker: Sprite2D
@export var health: int:
	set(new_health):
		health = new_health
		if (health_tracker != null):
			health_tracker.frame = health
@export var attack_damage: int

# Temp export for debugging.
@export var label: Label

@onready var ground_layer = %GroundLayer

signal clicked()

## This signal is consumed in one of the Unit State classes.
@warning_ignore("unused_signal") 
signal unselected()

var SPEED = 75.00

var cur_tile: Tile
var prev_tile: Tile
var hovered: bool

func _ready():	
	var current_tile_pos = ground_layer.local_to_map(position)
	cur_tile = ground_layer.tile_coords[current_tile_pos]
	prev_tile = null
	cur_tile.occupant = self
	
	hovered = false
	label.text = unit_name
	label.visible = false
	health_tracker.visible = false
			
func _physics_process(_delta):
	if position != Vector2(cur_tile.game_coords):
		velocity = position.direction_to(cur_tile.game_coords) * SPEED
	if position.distance_to(cur_tile.game_coords) > 1:
		if velocity.x < 0:
			sprite.scale.x = -1
		else: 
			sprite.scale.x = 1
	else: 
		velocity = Vector2(0,0)
	move_and_slide()

func _on_mouse_entered():
	# label.visible = true
	hovered = true
	health_tracker.visible = true

func _on_mouse_exited():
	# label.visible = false
	hovered = false
	health_tracker.visible = false

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_pressed():
		clicked.emit()
		get_viewport().set_input_as_handled()
