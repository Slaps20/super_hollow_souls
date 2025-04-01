extends Node2D

var player

func _on_load_pressed() -> void:
	get_tree().change_scene_to_file("res://Screnes/levels/1_1.tscn")


func _on_new_game_pressed() -> void:
	'player = get_tree().get_first_node_in_group("player")'
	'player.new_player()'
	get_tree().change_scene_to_file("res://Screnes/Cut_Scene/cut_scene_1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
