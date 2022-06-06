extends Node2D

export (Array, PackedScene) var blocks

onready var tick = $Tick
onready var spawn_position = $SpawnPosition

var active_block :GeneralBlock

var landing_grid = []
var landing_grid_width = 10 * 8
var landing_grid_height = 16 * 8



func _ready():
	init_landing_grid()
	spawn_block()
	tick.start()
	
func init_landing_grid():
	for i in landing_grid_width:
		landing_grid.append([])
		for j in landing_grid_height:
			landing_grid[i].append(null)
	

	
func active_block_landed():
	add_landed_block_to_grid()
	active_block = null
	spawn_block()
	
func add_landed_block_to_grid():
	for square in active_block.get_children():
		
		var rounded_x = round(square.global_position.x) 
		var rounded_y = round(square.global_position.y)
		
		landing_grid[rounded_x][rounded_y] = square.position
	
func spawn_block():
	randomize()
	blocks.shuffle()
	var block = blocks[0].instance()
	block.position = spawn_position.position
	active_block = block
	add_child(block)

func _on_Tick_timeout():
	active_block.move_down()
	if(!check_valid_position()):
		active_block.move_up()
		active_block_landed()

func _process(delta):
	
	if Input.is_action_just_pressed("ui_right"):
		active_block.move_right()
		if(!check_valid_position()):
			active_block.move_left()
		
	if Input.is_action_just_pressed("ui_left"):
		active_block.move_left()
		if(!check_valid_position()):
			active_block.move_right()
		
	if Input.is_action_pressed("ui_down"):
		_on_Tick_timeout()
	
	if Input.is_action_just_pressed("ui_up"):
		active_block.rotate_block()
		if(!check_valid_position()):
			active_block.rotate_block_back()


func check_valid_position() -> bool:
	for square in active_block.get_children():
		
		var rounded_x = round(square.global_position.x) 
		var rounded_y = round(square.global_position.y)
		
		if (rounded_x < 4) || (rounded_x > 76) || rounded_y > 124:
			return false
			
		if (landing_grid[rounded_x][rounded_y] != null):
			return false

	return true


