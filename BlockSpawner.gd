extends Node2D

export (Array, PackedScene) var blocks

onready var tick = $Tick
onready var spawn_position = $SpawnPosition

var active_block :GeneralBlock


func _ready():
	EventBus.connect("block_landed", self, "active_block_landed")
	spawn_block()
	tick.start()
	
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




