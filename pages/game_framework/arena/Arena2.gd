extends Node2D
class_name Arena


export(Vector2) var target_position = Vector2(320, 320)
export(Vector2) var target_size = Vector2(155, 130)
export(float) var target_rotation = 0.0


onready var inner = $Inner
onready var outer = $Outer
onready var static_body = $StaticBody2D


var current_position = Vector2(320, 320)
var current_size = Vector2.ZERO
var current_rotation = 0.0
