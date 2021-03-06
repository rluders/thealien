extends Node


onready var World : = $World

var _game_owner : int


func init(game_owner: int) -> void:
	_game_owner = game_owner


func add_player(player: Player) -> void:
	var r = (randi() % 200) / 200.0
	var g = (randi() % 200) / 200.0
	var b = (randi() % 200) / 200.0
	player.player_info.color = Color(r, g, b)
	World.add_child(player)


func remove_player(player_id: int):
	if not World.has_node(str(player_id)):
		return
	var player := World.get_node(str(player_id))
	World.remove_child(player)
	return player


func get_players() -> Array:
	var players := []
	for p in World.get_children():
		players.append(p)
	return players


func serialize():
	var players := []
	for p in get_players():
		players.append(p.serialize())
	
	return {
		"name": name, 
		"players": players,
		"num_players": World.get_child_count(),
		"max_players": 10, 
		"mode": "default"
	}
