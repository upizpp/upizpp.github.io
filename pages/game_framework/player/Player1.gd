extends KinematicBody2D
class_name Player


# 每帧移动的像素数
export(float) var speed = 2.5


# 上下左右移动的四个按键
export(String) var up_key = "ui_up"
export(String) var down_key = "ui_down"
export(String) var left_key = "ui_left"
export(String) var right_key = "ui_right"


var input_vector := Vector2.ZERO
var velocity := Vector2.ZERO


func _process(delta):
	# 获取移动方向
	input_vector = Vector2(
		Input.get_axis(left_key, right_key),
		Input.get_axis(up_key, down_key)
	)
	# 根据移动方向计算速度
	velocity = input_vector * speed


func _physics_process(delta):
	# 移动
	velocity = move_and_slide(velocity / delta)
