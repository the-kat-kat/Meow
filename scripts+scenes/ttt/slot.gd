extends Button

var row: int
var col: int

var filled: bool = false

@export var x_image: PackedScene
@export var o_image: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	print("pressed", GameManager.who_won)
	if GameManager.who_won != 1:
		return
	
	add_to_board(1)
	
func add_to_board(type: int):
	filled = true
	if type ==1: 
		add_child(x_image.instantiate())
	else:
		add_child(o_image.instantiate())
	GameManager.ttt_board[row][col] = type
