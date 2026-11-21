class_name PLAYER extends Area2D

var direction : Vector2
var last_direction : Vector2

var target_position : Vector2
var last_position : Vector2

var acceleration : float = 200.0
var max_speed : float = 50.0

var max_dist : float = 200.0
var boost : float = 0.0

var held_timer : float = 0.0


var max_spore_cooldown : float = .8
var spore_cooldown : float = 0.0


@export var blob_body : Sprite2D
@export var spore_scene : PackedScene

func add_spore():
	var new_spore : Sprite2D = spore_scene.instantiate()
	var holder = get_tree().get_nodes_in_group("world")
	holder = holder[0]
	holder.add_child(new_spore)

	new_spore.position = last_position
	new_spore.look_at(position)

func _process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if spore_cooldown > 0.0:
		spore_cooldown -= delta

	if direction == Vector2.ZERO:
		scale = Vector2.ONE
		if target_position and (position - target_position).length() != 0.0 :
			boost = 0.0
			if spore_cooldown <= 0.0:
				spore_cooldown = max_spore_cooldown
				add_spore()
	else:

		held_timer += delta * acceleration
		held_timer = clamp(held_timer, 0, max_dist)
		
		scale.y += delta / 2
		scale.y = clamp(scale.y, 0, held_timer)
		


		rotation = lerp_angle(rotation, atan2(direction.x, -direction.y), delta *10.0)
		target_position = Vector2.ZERO
		
	
	
	last_direction = transform.basis_xform(Vector2.UP)

func _physics_process(delta: float) -> void:
	if not direction and not target_position:
		last_position = Vector2.ZERO
		var wanted_position
		if boost != 0.0:
			wanted_position = position + ((last_direction * max_dist) * boost)
		else:
			wanted_position = position + (last_direction * max_dist)
		target_position = position.move_toward(wanted_position , held_timer)
		held_timer = 0.0
		
	if not direction:
		if not last_position:
			last_position = position
		position = position.lerp(target_position, delta)
		position.x = clamp(position.x, 600, 1600)
		position.y = clamp(position.y, 800, 1200)
