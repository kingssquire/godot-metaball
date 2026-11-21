extends Node2D

@export var mushroom_bloom : PackedScene

func _ready() -> void:
	SignalBus.mushroom_bloomed.connect(func(mushspawner : Sprite2D):
		var new_mushroom : Sprite2D = mushroom_bloom.instantiate()
		var top_world = get_tree().get_first_node_in_group("topworld")
		top_world.add_child(new_mushroom)
		new_mushroom.position = mushspawner.position
		
		)
		
		
		
