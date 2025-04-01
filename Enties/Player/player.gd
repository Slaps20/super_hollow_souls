class_name Player 
extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -1000.0
var jumped = 0
var save_path = "user://variable.save"
var max_health = 1
var health = 1
var lives = 10

func _ready() -> void:
	load_data()
	add_to_group("player")
	get_node("AnimatedSprite2D").play("Idle")
	
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
		get_node("AnimatedSprite2D").play("Walk")
		velocity.x = direction * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0:
		get_node("AnimatedSprite2D").flip_h = true
	if direction > 0:
		get_node("AnimatedSprite2D").flip_h = false
		
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
