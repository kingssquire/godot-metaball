class_name Spore extends Sprite2D

@export var max_spread : float = 5
@export var collision_area : Area2D


var max_scale = Vector2(max_spread, max_spread)
var time_scale : float = .8

var mushroom_bloomed : bool = false

var current_entered : PLAYER 
func _ready() -> void:
	if not collision_area:
		return
	
	collision_area.area_entered.connect(func(area):
		if not area is PLAYER:
			return
		area.boost = scale.x * 3
		if not area.areas_entered.has(name):
			area.areas_entered.append(name)
		)
	collision_area.area_exited.connect(func(area):
		if not area is PLAYER:
			return
		var array : Array = area.areas_entered
		if array.has(name):
			array.erase(name)
			
		
		if array.size() <= 0.0:
			area.boost = 0.0
		)
		


#rework this sometime
#func merge_spores():
	#var all_spores = get_tree().get_nodes_in_group("spore")
	#for spore in all_spores:
		#if spore == self:
			#continue
		#if (spore.position - position).length * scale.x <= max_spread:
			#spore.queue_free()
	
func _process(delta: float) -> void:
	scale = scale.lerp(max_scale, delta * time_scale )

	if scale.x >= max_scale.x - .5 and not mushroom_bloomed:
		mushroom_bloomed = true
		SignalBus.mushroom_bloomed.emit(self)
	
