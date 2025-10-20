extends Control

@export var dialogue: DialogueResource

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts+scenes/ttt/choose_bid.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts+scenes/main_menu/settings.tscn")

func _on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts+scenes/main_menu/tutorial.tscn")
