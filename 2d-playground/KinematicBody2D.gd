extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()

signal mined_at(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var jumps_left = 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# reset jumpcount when on floor
	if is_on_floor():
		jumps_left = 2
	
	# handle jump
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		jumps_left -= 1
		velocity.y -= 100
		
	# else handle gravity
	else:
		velocity.y += 5
	
	if Input.is_key_pressed(KEY_TAB):
		$AnimatedSprite2.play("attack")
	
	# maximum speed
	var max_speed = 80
	var acceleration = 5 * 50
	
	if Input.is_action_pressed("move_right"):
		velocity.x = min(max_speed, velocity.x + acceleration * delta) 
		
	elif Input.is_action_pressed("move_left"):
		velocity.x = max(-max_speed, velocity.x - acceleration * delta)
	else:
		velocity.x *= 0.6
		if abs(velocity.x) < 0.001:
			velocity.x = 0
	
	$RayCast2D.cast_to = get_local_mouse_position().normalized() * 20
	
	if Input.is_action_just_pressed("activate"):
		var collider = $RayCast2D.get_collider()
		if collider is TileMap:
			
			var collision_point = $RayCast2D.get_collision_point() + $RayCast2D.cast_to.normalized()
			
			emit_signal("mined_at", collision_point)
	
	if velocity.x != 0:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("default")	
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	pass

