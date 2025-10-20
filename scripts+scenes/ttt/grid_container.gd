extends GridContainer

@export var slot: PackedScene

func _ready() -> void:
	for i in range(GameManager.rows):
		for j in range(GameManager.cols):
			var new_slot = slot.instantiate()
			add_child(new_slot)
			new_slot.row = i
			new_slot.col = j
			new_slot.connect("pressed", Callable(new_slot, "_on_pressed"))
