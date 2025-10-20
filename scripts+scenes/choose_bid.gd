extends Control

#the number shown on screen
@onready var betting_number: Label = $BettingNumber
#the number of coins left for p1
@onready var p1_coin_counter: Label = $CoinCount/P1CoinCount
@onready var p2_coin_counter: Label = $CoinCount/P2CoinCount

func _ready() -> void:
	p1_coin_counter.text = "P1 Stars left: " + str(GameManager.p1_coins_left)
	p2_coin_counter.text = "P2 Stars left: " + str(GameManager.p2_coins_left)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		GameManager.p1_current_bid = int(betting_number.text)
		get_tree().change_scene_to_file("res://scripts+scenes/ttt/bid_result.tscn")
	
func _on_up_pressed() -> void:
	betting_number.increment()
	betting_number.text = str(betting_number.num)

func _on_ok_pressed() -> void:
	#switch to show results of the bidding
	GameManager.p1_current_bid = int(betting_number.text)
	get_tree().change_scene_to_file("res://scripts+scenes/ttt/bid_result.tscn")
	#set this so that p2 move can be gotten when grid_container is initialized
