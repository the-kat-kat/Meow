extends Control

@onready var num_coins: Label = $StartingCoins

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	num_coins.text = "Number of starting coins: "+ str(GameManager.p1_coins_left)

func _on_up_pressed() -> void:
	if GameManager.p1_coins_left == 25:
		GameManager.p1_coins_left = 7
		GameManager.p2_coins_left = 7
		return
	GameManager.p1_coins_left +=1
	GameManager.p2_coins_left +=1
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts+scenes/main_menu/main_menu.tscn")

func _on_down_pressed() -> void:
	if GameManager.p1_coins_left == 7:
		GameManager.p1_coins_left = 25
		GameManager.p2_coins_left = 25
		return
	GameManager.p1_coins_left -=1
	GameManager.p2_coins_left -=1
