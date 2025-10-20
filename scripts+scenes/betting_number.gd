extends Label

@export var coins_left: int

var num: int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	text = str(num)
	coins_left = GameManager.p1_coins_left

func increment():
	num += 1
	if num > coins_left:
		num = 0
