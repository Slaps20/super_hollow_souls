extends Area2D

var count= 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if count == 1:
		get_tree().change_scene_to_file("res://Screnes/death_screen/death_screen.tscn")

#looks at tilemap too
func _on_body_entered(body: Node2D) -> void:
	count +=1
