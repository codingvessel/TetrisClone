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
	EventBus.connect("block_landed", self, "active_block_landed")
	spawn_block()
	tick.start()
	
func init_landing_grid():
	for i in landing_grid_width:
		landing_grid.append([])
		for j in landing_grid_height:
			landing_grid[i].append(0) # Set a starter value for each position
	
func spawn_block():
	randomize()
	blocks.shuffle()
	var block = blocks[0].instance()
	block.position = spawn_position.position
	active_block = block
	add_child(block)
	
func active_block_landed():
	active_block = null
	spawn_block()

func _on_Tick_timeout():
	active_block.move_one_step()

func _process(delta):
	
	if Input.is_action_just_pressed("ui_right"):
		active_block.move_right()
		
	if Input.is_action_just_pressed("ui_left"):
		active_block.move_left()
		
	if Input.is_action_pressed("ui_down"):
		active_block.move_one_step()
	
	if Input.is_action_just_pressed("ui_up"):
		active_block.rotate_block()




