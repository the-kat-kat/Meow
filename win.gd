extends Control

@export var dialogue: DialogueResource

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and DialogueManager.dialogue_started:
		if GameManager.who_won == 1:
			DialogueManager.show_dialogue_balloon(dialogue, "you_won")
		else:
			DialogueManager.show_dialogue_balloon(dialogue, "you_lost")

func go_back():
	get_tree().change_scene_to_file("res://scripts+scenes/main_menu/main_menu.tscn")
