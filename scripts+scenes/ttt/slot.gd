extends Button

@export var x_image: PackedScene
@export var o_image: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	if GameManager.who_won != 1:
		return
		
	add_child(x_image.instantiate())
	
