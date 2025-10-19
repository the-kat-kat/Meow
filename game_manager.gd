#global
extends Node2D

#general
var bids_done: int = 0
var rows = 3
var cols = 3
var ttt_board = []

#player 1 (you)
var p1_coins_left: int = 10
var p1_current_bid: int = 0

#player 2 (computer)
var p2_coins_left: int = 10
var p2_current_bid: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(rows):
		ttt_board.append([])
		for j in range(cols):
			ttt_board[i].append(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#type: 0 -> empty, 1 -> x, 2-> o
func set_square(row: int, col: int, type: int):
	ttt_board[row][col] = type
	
func get_best_bid() -> int:
	return p2_coins_left
