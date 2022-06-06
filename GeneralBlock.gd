extends Area2D
class_name GeneralBlock

var step :float = 8

func move_down():
	position += Vector2(0,step)

func move_up():
	position -= Vector2(0,step)

func move_right():
	position += Vector2(step,0)
	
func move_left():
	position -= Vector2(step,0)
	
func rotate_block():
	rotation_degrees += 90

func rotate_block_back():
	rotation_degrees -= 90
