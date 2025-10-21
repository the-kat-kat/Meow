#global
extends Node2D

var grid_container
#general
var bids_done: int = 0
var rows = 3
var cols = 3
var ttt_board = [] #0 for none, 1 for p1 x, 2 for p2 o
var who_won: int = 0 #1 for p1, 2 for p2, who won the bet
var corners = [Vector2(0,0), Vector2(0,2), Vector2(2,0), Vector2(2,2)]

#player 1 (you)
var p1_coins_left: int = 10
var p1_current_bid: int = 0

#player 2 (computer)
var p2_coins_left: int = 10
var p2_current_bid: int = 10

var player_bid_history: Array = []
var placed_xo:bool = false
var getting_p2_move:bool = false
var someone_won = false

var p1_has_winner = false
var p2_has_winner = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(rows):
		ttt_board.append([])
		for j in range(cols):
			ttt_board[i].append(0)

func _unhandled_input(event: InputEvent) -> void:
	if placed_xo && event.is_action_pressed("ui_accept"):
		next_bid()
	
#type: 0 -> empty, 1 -> x, 2-> o
func set_square(row: int, col: int, type: int):
	ttt_board[row][col] = type
	

func get_best_bid() -> int: 
	p1_has_winner = false
	p2_has_winner = false
	
	if bids_done == 0:
		p2_current_bid = randi_range(2,5)
		return p2_current_bid
	
	var target_square: Vector2 = find_best_square(2)
	
	var estimated_player_bid: int = 0
	if player_bid_history.size() > 0:
		var sum = 0
		for b in player_bid_history:
			sum += b
		estimated_player_bid = int(sum / player_bid_history.size())
		
	var bid: int = min(estimated_player_bid + 1, p2_coins_left)
	p2_current_bid = bid
	
	ttt_board[target_square.x][target_square.y] = 0
	
	# if p1 is about to win, must win
	var p1_sq = find_winning_square(1)
	if p1_has_winner and p1_coins_left < p2_coins_left:
		bid = p1_coins_left + 1
	
	print("p2 bid: ", bid)
	p2_current_bid = bid
	return bid
	
func get_p2_move():
	getting_p2_move = true
	var sq = find_best_square(2)
	var i = sq.x
	var j = sq.y
	ttt_board[i][j]= 2
	var slot = grid_container.get_children()[3*i+j] #i is the row, j is the column
	slot.add_to_board(2)
	
#will the square make it winn?
func find_best_square(player: int) -> Vector2:
	var sq
	#if p2 has a winning square, take it 
	sq = find_winning_square(2)
	print("sq2", sq)
	if sq != Vector2(-1, -1):
		return sq
	#if p1 has a winning square, take it so they can't win
	sq = find_winning_square(1)
	print("sq1", sq)
	if sq != Vector2(-1, -1):
		return sq
		
	#if there is one corner and an open corner, take the open corner
	var p2_has_corner = false
	for c in corners:
		var across_x
		var across_y
		if ttt_board[c.x][c.y] == 2:
			p2_has_corner = true
		if ttt_board[c.x][c.y] == 2:
			across_x = (int(c.x) + 2) % 2
			across_y = (int(c.y) + 2) % 2
			if ttt_board[across_x][across_y]== 0:
				if getting_p2_move:
					ttt_board[across_x][across_y] = 2
					placed_xo = true
					getting_p2_move = false
				return Vector2(across_x, across_y)		
	
	#if no corners yet, take a corner
	if !p2_has_corner:
		for c in corners:
			if ttt_board[c.x][c.y] == 0:
				return c
	
	#take the center
	if ttt_board[1][1] == 0:
		return Vector2(1, 1)
		
	#take a random corner
	for c in corners:
		if ttt_board[c.x][c.y] == 0:
			return c
		
	for i in range(rows):
		for j in range(cols):
			if ttt_board[i][j] == 0:
				return Vector2(i,j)
	return Vector2(-1,-1) #if it failed
	
func find_winning_square(player: int) -> Vector2:
	var last_empty = Vector2(0,0)
	for i in range(rows):
		for j in range(cols):
			if ttt_board[i][j] == 0:
				last_empty = Vector2(i, j)
				ttt_board[i][j] = player
				
				if check_winner(player): #check in i j is a winning pos for player
					ttt_board[i][j] = 0
					if getting_p2_move:
						ttt_board[i][j] = 2 #set that tile as x
						placed_xo = true
						getting_p2_move = false
					has_winner(player)
					return Vector2(i, j)
				ttt_board[i][j] = 0
	return Vector2(-1, -1) #no winning move
	
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
	print("p1 is: and p2 is: ", p1_current_bid, p2_current_bid)
	if p1_current_bid >= p2_current_bid:
		print("p1")
		who_won = 1
	else:
		print("p2")
		who_won = 2
		
func next_bid():
	player_bid_history.append(p1_current_bid)
	bids_done += 1
	if who_won == 1:
		p1_coins_left -= p1_current_bid
		p2_coins_left += p1_current_bid
	else:
		p2_coins_left -= p2_current_bid
		p1_coins_left += p2_current_bid
	placed_xo = false
	
	if check_winner(who_won):
		print("someone one", who_won)
		someone_won = true
		get_tree().change_scene_to_file("res://scripts+scenes/win.tscn")
	else:	
		get_tree().change_scene_to_file("res://scripts+scenes/ttt/choose_bid.tscn")
	
		
func has_winner(player: int):
	if player == 1:
		p1_has_winner = true
	else:
		p2_has_winner = true
