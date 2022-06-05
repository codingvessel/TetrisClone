extends Node2D

var active_block
onready var tick = $Tick

export (PackedScene) var SBlock
export (PackedScene) var ZBlock
export (PackedScene) var OBlock
export (PackedScene) var JBlock
export (PackedScene) var LBlock
export (PackedScene) var IBlock

onready var blocks = [SBlock, ZBlock, OBlock, JBlock, LBlock, IBlock]

func _ready():
	spawn_block()
	tick.start()
	
func spawn_block():
	randomize()
	blocks.shuffle()
	var block = blocks[0].instance()
	active_block = block
	add_child(block)



func _on_Tick_timeout():
	active_block.move_one_step()
