extends Node2D

var active_block

export (PackedScene) var SBlock
export (PackedScene) var ZBlock
export (PackedScene) var OBlock
export (PackedScene) var JBlock
export (PackedScene) var LBlock
export (PackedScene) var IBlock

onready var blocks = [SBlock, ZBlock, OBlock, JBlock, LBlock, IBlock]

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_block()
	
func spawn_block():
	randomize()
	blocks.shuffle()
	var block = blocks[0].instance()
	add_child(block)
