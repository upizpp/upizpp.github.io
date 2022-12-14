extends Node2D
class_name Arena


const BorderSize = 5.0 # 边框厚度
const Thickness = 25.0 # 碰撞箱宽度，宽度越大，出框的几率越小，适量即可。
const Weight = 0.1 # 将Weight定义为常量以便于使用


export(Vector2) var target_position = Vector2(320, 320)
export(Vector2) var target_size = Vector2(155, 130)
export(float) var target_rotation = 0.0


onready var inner = $Inner
onready var outer = $Outer
onready var static_body = $StaticBody2D


var current_position = Vector2(320, 320)
var current_size = Vector2.ZERO
var current_rotation = 0.0


func _process(_delta):
	# 修改值（以Lerp缓动）
	current_position.x = lerp(current_position.x, target_position.x, Weight)
	current_position.y = lerp(current_position.y, target_position.y, Weight)
	current_size.x = lerp(current_size.x, target_size.x, Weight)
	current_size.y = lerp(current_size.y, target_size.y, Weight)
	current_rotation = lerp(current_rotation, target_rotation, Weight)

	# 将得到的值进行修改
	self.position = current_position
	self.rotation_degrees = current_rotation # 这里使用角度制
	outer.scale = current_size
	inner.scale = current_size - Vector2.ONE * 10 # 边框宽度为10 / 2 = 5

	init_shape()


# 更新碰撞箱的信息
func init_shape():
	static_body.get_child(0).position = Vector2(0.0, -((current_size.y + Thickness - BorderSize * 2.0) * 0.5))
	static_body.get_child(0).scale = Vector2(current_size.x + Thickness * 2.0, Thickness)
	static_body.get_child(1).position = Vector2(0.0, +((current_size.y + Thickness - BorderSize * 2.0) * 0.5))
	static_body.get_child(1).scale = Vector2(current_size.x + Thickness * 2.0, Thickness)
	static_body.get_child(2).position = Vector2(-((current_size.x + Thickness - BorderSize) * 0.5), 0.0)
	static_body.get_child(2).scale = Vector2(Thickness + BorderSize, current_size.y - BorderSize * 2.0)
	static_body.get_child(3).position = Vector2(+((current_size.x + Thickness - BorderSize) * 0.5), 0.0)
	static_body.get_child(3).scale = Vector2(Thickness + BorderSize, current_size.y - BorderSize * 2.0)
