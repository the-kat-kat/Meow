extends Control

@onready var results_panel: Panel = $Results
@onready var p1_bid = $Player1/BettingNumber
@onready var p2_bid = $Player2/BettingNumber

@export var winner_image_scene: PackedScene

var proceed_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	results_panel.visible = true
	p1_bid.text = str(GameManager.p1_current_bid)
	p2_bid.text = str(GameManager.get_best_bid()) ##whyyyyyyy

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if proceed_index == 0:
			proceed_index = 1
			show_bid_winner()
		elif proceed_index >= 1:
			proceed_index = 2
			if GameManager.who_won == 2:
				GameManager.getting_p2_move = true
			else:
				GameManager.getting_p2_move = false
			GameManager.placed_xo = false
			get_tree().change_scene_to_file("res://scripts+scenes/ttt/ttt_main.tscn")
			
func show_bid_winner():
	GameManager.get_bid_winner()
	results_panel.visible = false
	print("who won", GameManager.who_won)
	if GameManager.who_won == 1:
		$Player1.add_child(winner_image_scene.instantiate())
	else:
		$Player2.add_child(winner_image_scene.instantiate())
		
		
	
		
		
		
		
	
		
		
		
		
		
		
