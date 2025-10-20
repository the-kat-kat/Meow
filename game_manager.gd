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

var player_bid_history: Array = []

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
	var target_square: Vector2 = find_best_square()
	
	var estimated_player_bid: int = 0
	if player_bid_history.size() > 0:
		var sum = 0
		for b in player_bid_history:
			sum += b
		estimated_player_bid = int(sum / player_bid_history.size())
		
	var bid: int = min(estimated_player_bid + 1, p2_coins_left)
	p2_current_bid = bid
	
	ttt_board[target_square.x][target_square.y] = 0
	print("p2 bid: ", bid)
	p2_current_bid = bid
	return bid
	
func find_best_square() -> Vector2:
	var sq = find_winning_square(2)
	print("sq2", sq)
	if sq != null:
		return sq
	sq = find_winning_square(1)
	print("sq1", sq)
	if sq != null:
		return sq
	if ttt_board[1][1] == 0:
		return Vector2(1, 1)
	var corners = [Vector2(0,0), Vector2(0,2), Vector2(2,0), Vector2(2,2)]
	for c in corners:
		if ttt_board[c.x][c.y] == 0:
			return c
	for i in range(rows):
		for j in range(cols):
			if ttt_board[i][j] == 0:
				return Vector2(i,j)
	return Vector2(0,0)
	
func find_winning_square(player: int) -> Vector2:
	for i in range(rows):
		for j in range(cols):
			if ttt_board[i][j] == 0:
				ttt_board[i][j] = player
				if check_winner(player):
					ttt_board[i][j] = 0
					return Vector2(i, j)
			ttt_board[i][j] = 0
	return Vector2(-1, -1)
	
func check_winner(player: int):
	#check the rwosss
	for i in range(rows):
		if ttt_board[i][0] == player && ttt_board[i][1] == player && ttt_board[i][2] == player:
			print("row won", i)
			return true
	#cols
	for j in range(cols):
		if ttt_board[0][j] == player && ttt_board[1][j] == player && ttt_board [2][j] == player:
			print ("col won", j)
			return true
		
	#diagonals
	if ttt_board[0][0] == player && ttt_board[1][1] == player && ttt_board[2][2] == player:
		print("dialgal1")
		return true
	if ttt_board[2][0] == player && ttt_board[1][1] == player && ttt_board[0][2] == player:
		print("diagonal2")
		return true
	return false

#who had the higher bid
func get_bid_winner():
	#greater than or EQUAL to
	print("p1 is: nd p2 is: ", p1_current_bid, p2_current_bid)
	if p1_current_bid >= p2_current_bid:
		print("p1")
		who_won = 1
	else:
		print("p2")
		who_won = 2
		
		
		
