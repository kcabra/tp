extends Node2D

onready var player = $jumper

var playertp

func _ready():
	playertp = preload("res://particles/playertp.tscn")

func spawn_tp_part():
	var inst = load("res://particles/playertp.tscn").instance()
	inst.position = player.global_position
	inst.rotation = player.global_rotation
	add_child(inst)