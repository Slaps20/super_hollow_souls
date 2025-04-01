extends CharacterBody2D

var player 
var chase = false
var speed = 175

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") 
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
			#enemy player interaction
	if get_node("AnimatedSprite2D").animation != "Death":
		if chase == true:
				get_node("AnimatedSprite2D").play("Walk")
				
				var direction = (player.position - self.position).normalized()
				if direction.x > 0:
						get_node("AnimatedSprite2D").flip_h = false
				else:
						get_node("AnimatedSprite2D").flip_h = true
				velocity.x = direction.x * speed

		else:
				get_node("AnimatedSprite2D").play("Idle")
				velocity.x = 0

	move_and_slide()

#detacts and kills off enemy 
func _on_death_body_entered(body: Node2D) -> void:
	if body is Player:
		death()
		
func death():
	get_node("AnimatedSprite2D").play("Death")
	chase = false
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()

func _on_player_dectection_body_entered(body: Node2D) -> void:
	if body is Player:
		chase = true

func _on_player_dectection_body_exited(body: Node2D) -> void:
	if body is Player:
		chase = false


func _on_player_colosion_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.health -= 1
