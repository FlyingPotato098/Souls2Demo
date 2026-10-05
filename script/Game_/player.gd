extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Player_ASprite
@onready var sword: CollisionShape2D = $Hitbox/Sword


var lattack_cooldown_timer = 0.0
var lattack_doration = 0.0

var s = 400.0
var j = 600.0
var dash_speed = 800.0
var is_dashing = false
var dash_timer = 0.0
var dash_duration = 0.2

var lattack = false
var dash_cooldown = 1.0
var dash_cooldown_timer = 0.0
var attack_cooldown = 0.0

var last_direction = 1.0
var q_was_pressed = false

func _ready() -> void:
	add_to_group("player")

func _process(delta: float) -> void:
	if lattack_doration > 0:
		lattack_doration -= 1

	if lattack_cooldown_timer > 0:
		lattack_cooldown_timer -= delta

func _physics_process(delta: float) -> void:
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false

	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

	var up = Input.is_action_just_pressed("ui_accept")
	var right = Input.is_key_pressed(KEY_D)
	var left = Input.is_key_pressed(KEY_A)
	var q_is_pressed = Input.is_key_pressed(KEY_Q)

	if right:
		last_direction = 1.0
	elif left:
		last_direction = -1.0

	if q_is_pressed and not q_was_pressed and not is_dashing and dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown
		velocity.y = 0

	q_was_pressed = q_is_pressed

	if up and is_on_floor() and not is_dashing:
		velocity.y = -j

	if is_dashing:
		velocity.x = last_direction * dash_speed
	else:
		if right:
			velocity.x = s
		elif left:
			velocity.x = -s
		else:
			velocity.x = 0

	if Input.is_action_just_released("ui_accept") and velocity.y <= 0:
		velocity.y = 0

	if lattack_doration <= 0:
		lattack = false

	if Input.is_action_just_pressed("lattack") and lattack_doration == 0:
		sprite.play("lattack")
		lattack = true
		lattack_doration = 45
		
	if lattack == false:
		sword.disabled = true
	if lattack == true:
		sword.disabled = false

	animation()
	move_and_slide()

func animation():
	if velocity.x > 0:
		sprite.flip_h = false
		if sword.position.x != 24:
			sword.position.x += 48
	elif velocity.x < 0:
		sprite.flip_h = true
		if sword.position.x != -24:
			sword.position.x -= 48
		
		

	if not lattack:
		if velocity.x == 0 and is_on_floor():
			sprite.play("idle")
		elif velocity.x != 0 and is_on_floor():
			sprite.play("move")
		elif velocity.y < 0:
			sprite.play("jump")
		elif velocity.y > 0:
			sprite.play("falldown")


func _on_on_level_entered_body_entered(body: Node2D) -> void:
	print("on level")
