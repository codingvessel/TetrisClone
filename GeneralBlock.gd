extends Area2D
class_name GeneralBlock

var step :float = 8

func move_one_step():
	position += Vector2(0,step)

func move_right():
	position += Vector2(step,0)
	if (!check_valid_position()):
		position -= Vector2(step,0)
	
func move_left():
	position -= Vector2(step,0)
	if (!check_valid_position()):
		position += Vector2(step,0)
	
func rotate_block():
	rotation_degrees += 90
	if (!check_valid_position()):
		rotation_degrees -= 90


func check_valid_position() -> bool:
	for square in get_children():
		
		var rounded_x = round(square.global_position.x) 
		
		print(rounded_x)
		if (rounded_x < -60) || (rounded_x > 16):
			return false
#
	return true
