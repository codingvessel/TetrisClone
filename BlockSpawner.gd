extends Node2D

export (Array, PackedScene) var blocks

onready var tick = $Tick
onready var spawn_position = $SpawnPosition

var active_block :GeneralBlock

var landing_grid = []
var landing_grid_width = 10
var landing_grid_height = 16



func _ready():
	init_landing_grid()
	spawn_block()
	tick.start()
	
func init_landing_grid():
	for x in landing_grid_width:
		landing_grid.append([])
		for y in landing_grid_height:
			landing_grid[x].append(null)
	

	
func active_block_landed():
	add_landed_block_to_grid()
	spawn_block()
	
func add_landed_block_to_grid():
	for square in active_block.get_children():
		
		var rounded_x = round(square.global_position.x) 
		var rounded_y = round(square.global_position.y)
		
		landing_grid[rounded_x/8][rounded_y/8] = square
	
func spawn_block():
	randomize()
	blocks.shuffle()
	active_block = blocks[0].instance()
	active_block.position = spawn_position.position
	add_child(active_block)

func _on_Tick_timeout():
	active_block.move_down()
	if(!check_valid_position()):
		active_block.move_up()
		active_block_landed()
		check_lines()

func check_lines():
	for y in landing_grid_height:
		if(is_full_line(y)):
			delete_line(y)
			push_down(y)
		
			
#checks if every cell in line y is occupied and only then returns true
func is_full_line(y) -> bool:
	for x in landing_grid_width:
		if(landing_grid[x][y] == null):
			return false
			
	return true
	
func delete_line(y):
	for x in landing_grid_width:
		var block_to_delete = landing_grid[x][y]
		block_to_delete.queue_free()
		landing_grid[x][y] = null
		
func push_down(y):
	#for every line above y
	for j in range(y, 0, -1):
		#for every occupied cell in this line
		#move cell down and delete old cell
		#also update visual component with global position
		for x in landing_grid_width:
			if(landing_grid[x][j] != null):
				landing_grid[x][j+1] = landing_grid[x][j]
				landing_grid[x][j] = null
				landing_grid[x][j+1].global_position += Vector2(0,8)
	

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
			
		if (landing_grid[rounded_x/8][rounded_y/8] != null):
			return false

	return true


