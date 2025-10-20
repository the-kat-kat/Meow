extends GridContainer

@export var slot: PackedScene

func _ready() -> void:
	print("im making the gridd", GameManager.ttt_board)
	for i in range(GameManager.rows):
		for j in range(GameManager.cols):
			var new_slot = slot.instantiate()
			add_child(new_slot)
			new_slot.row = i
			new_slot.col = j
			if GameManager.ttt_board[i][j] != 0:
				print("there is smthing at ", i, j)
				new_slot.add_to_board(GameManager.ttt_board[i][j])
			new_slot.connect("pressed", Callable(new_slot, "_on_pressed"))
			
	if GameManager.getting_p2_move:
		GameManager.grid_container = self
		print("GC", GameManager.grid_container)
		GameManager.get_p2_move()
