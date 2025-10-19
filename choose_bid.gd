extends Control

var coins_left: int = 10

@onready var betting_number: Label = $BettingNumber
@onready var coin_counter: Label = $CoinCount

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coin_counter.text = "Coins left: " + str(coins_left)
	pass

func _on_up_pressed() -> void:
	betting_number.increment()
	betting_number.text = str(betting_number.num)

func _on_ok_pressed() -> void:
	#switch to show results of the bidding
	var next_scene = preload("res://scripts+scenes/ttt/bid_result.tscn")
	var player1_bid = next_scene.get_node("Player1").get_node("BettingNumber")
	player1_bid.text = betting_number.text
	get_tree().current_scene = next_scene
