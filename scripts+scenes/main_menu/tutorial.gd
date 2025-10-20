extends Control

@export var dialogue: DialogueResource

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and DialogueManager.dialogue_started:
		DialogueManager.show_dialogue_balloon(dialogue)

func go_back():
	get_tree().change_scene_to_file("res://scripts+scenes/main_menu/main_menu.tcsn")
