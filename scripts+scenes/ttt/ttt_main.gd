extends Control

@onready var x_image: Control = $CanvasLayer/X_image
@onready var o_image: Control = $CanvasLayer/O_image

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.who_won == 1:
		x_image.modulate.a = 1.0
		o_image.modulate.a = 0.2
	elif GameManager.who_won == 2:
		o_image.modulate.a = 1.0
		x_image.modulate.a = 0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
