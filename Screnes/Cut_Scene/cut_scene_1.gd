extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://Screnes/levels/1_1.tscn")



func _on_player_reset_body_entered(body: Node2D) -> void:
	if body is Player:
		print("yea")
		body.new_player()
