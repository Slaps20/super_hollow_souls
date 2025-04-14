class_name Player 
extends CharacterBody2D

@onready var a_tree: AnimationTree = $AnimationTree

const SPEED = 700.0
const JUMP_VELOCITY = -1000.0
var jumped = 0
var save_path = "user://variable.save"
var max_health = 1
var health = 1
var lives = 10
var can_move: bool = true
var right: bool = true

func _ready() -> void:
	load_data()
	add_to_group("player")
	#get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += 1.37*(get_gravity() * delta)

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumped = 1
	if Input.is_action_just_released("space") and jumped < 2:
		velocity.y += 400 
		
	if is_on_floor():
		jumped = 0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction:= Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#handles animation
	if Input.is_action_just_pressed("right"):
		right = true
	elif Input.is_action_just_pressed("left"):
		right = false
	else:
		pass
	
	if right:
		scale = Vector2(1.0, 1.0)
		scale.x = 1
		#position = Vector2(0.0, 0.0)
	else:
		scale = Vector2(-1.0, 1.0)
		scale.x = -1
		#position = Vector2(0.0, 0.0)
		
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		a_tree["parameters/conditions/is_walking"] = true
		a_tree["parameters/conditions/is_idle"] = false
	else:
		a_tree["parameters/conditions/is_walking"] = false
		a_tree["parameters/conditions/is_idle"] = true
		
	move_and_slide()
	
	if health <= 0 and lives > 0:
		lives -= 1
		health = max_health
		save()
		death()
	if health <= 0 and lives <= 0:
		lives = 5
		health = max_health
		save()
		game_over()
#handles players death
func death():
	queue_free()
	get_tree().change_scene_to_file("res://Screnes/death_screen/death_screen.tscn")

func game_over():
	queue_free()
	

#Handles all Saving load aspec
func save():
	print("Looking good so far")
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(lives)
	file.store_var(health)
	file.store_var(max_health)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		lives = file.get_var(lives)
		health = file.get_var(health)
		max_health = file.get_var(max_health)
	else:
		print("NA")
		lives = 5
		health = 5
		max_health = 5

func new_player():
	lives = 5
	health = 5
	max_health = 5
	save()

func cant_movement():
	can_move = false

func can_movement():
	can_move = true
