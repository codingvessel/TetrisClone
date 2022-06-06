extends Area2D
class_name GeneralBlock

var step :float = 8

func move_one_step():
	position += Vector2(0,step)
	if (!check_valid_position()):
		position -= Vector2(0,step)
		EventBus.emit_signal("block_landed")

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
		var rounded_y = round(square.global_position.y)
		
		print(rounded_x)
		print(rounded_y)
		if (rounded_x < -60) || (rounded_x > 16) || rounded_y > 192:
			return false
#
	return true
