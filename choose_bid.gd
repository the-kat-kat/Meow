extends Control

#the number shown on screen
@onready var betting_number: Label = $BettingNumber
#the number of coins left for p1
@onready var coin_counter: Label = $CoinCount

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coin_counter.text = "Coins left: " + str(GameManager.p1_coins_left)
	pass

func _on_up_pressed() -> void:
	betting_number.increment()
	betting_number.text = str(betting_number.num)

func _on_ok_pressed() -> void:
	#switch to show results of the bidding
	GameManager.p1_current_bid = int(betting_number.text)
	GameManager.p1_coins_left -= int(betting_number.text)
	get_tree().change_scene_to_file("res://scripts+scenes/ttt/bid_result.tscn")
