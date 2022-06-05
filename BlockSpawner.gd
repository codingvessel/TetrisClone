extends Node2D

var active_block

export (PackedScene) var SBlock
export (PackedScene) var ZBlock
export (PackedScene) var OBlock
export (PackedScene) var JBlock
export (PackedScene) var LBlock
export (PackedScene) var IBlock



# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_block()
	
func spawn_block():
	var block = SBlock.instance()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
