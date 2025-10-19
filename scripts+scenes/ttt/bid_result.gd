extends Control

@onready var thinking_text: Label = $Thinking
@onready var p2_bid = $Player2/BettingNumber

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thinking_text.visible = true
	p2_bid = GameManager.get_best_bid()
	await get_tree().create_timer(2.0).timeout
	thinking_text.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
