extends Label

@onready var choose_bid = get_tree().get_nodes_in_group("choose_bid")[0]
@export var coins_left: int = 10

var num: int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	text = str(num)
	coins_left = choose_bid.coins_left

func increment():
	num += 1
	if num > coins_left:
		num = 0
