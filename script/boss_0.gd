extends CharacterBody2D

@export var player: Node2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
var random = 1
var health: int = 4

func _ready() -> void:
	if not player:
		find_player()

func find_player() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	elif get_parent().has_node("Player"):
		player = get_parent().get_node("Player")

func _on_area_det_small_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		random = randi_range(0, 1)
		print(random + "player entered small detection area")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not player:
		find_player()

	if player:
		walk_to_player(40.0)
	
	
	
	animation_simple()
	
	move_and_slide()

func animation_simple() -> void:
	if sprite:
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0:
			sprite.flip_h = true

		if is_on_floor():
			if velocity.x != 0:
				sprite.play("move")
			else:
				sprite.play("idle")

func walk_to_player(minimal_distance: float) -> void:
	var distance_x = player.global_position.x - global_position.x

	if abs(distance_x) > minimal_distance :
		if distance_x > 0:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
	else:
		velocity.x = 0
