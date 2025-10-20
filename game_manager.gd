#global
extends Node2D

#general
var bids_done: int = 0
var rows = 3
var cols = 3
var ttt_board = [] #0 for none, 1 for p1 x, 2 for p2 o
var who_won: int = 0 #1 for p1, 2 for p2, who won the bet

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
	if p2_coins_left > 0:
		print("p2 has coints")
		p2_current_bid = 1
		get_bid_winner()
		return 1
	else:
		p2_current_bid = 0
		get_bid_winner()
		return 0
		
#who had the higher bid
func get_bid_winner():
	#greater than or EQUAL to
	if p1_current_bid >= p2_current_bid:
		print("p1")
		who_won = 1
	else:
		who_won = 2
		
		
		
