extends Button

var row: int
var col: int

var filled: bool = false

@export var x_image: PackedScene
@export var o_image: PackedScene

func _on_pressed() -> void:
	print("pressed", GameManager.who_won)
	if GameManager.who_won != 1 or GameManager.placed_xo:
		return
	
	add_to_board(1)
	
func add_to_board(type: int):
	filled = true
	if type ==1: 
		add_child(x_image.instantiate())
	else:
		add_child(o_image.instantiate())
	GameManager.ttt_board[row][col] = type
	GameManager.placed_xo = true
