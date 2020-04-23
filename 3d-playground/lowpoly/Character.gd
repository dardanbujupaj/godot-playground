extends KinematicBody


const gravity = Vector3(0, -90, 0)
var velocity = Vector3()
const SPEED = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var horizontal_sensitivity = 0.05
var vertical_sensitivity = 0.005

var camera_rotation = Vector2()

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("look_around"):
		camera_rotation = (event as InputEventMouseMotion).relative
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = 25



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	rotate_y(-camera_rotation.x * horizontal_sensitivity)
	$FirstPersonCamera.rotate_x(camera_rotation.y * vertical_sensitivity)
	
	camera_rotation *= 0.8
	
	velocity.x *= .8
	velocity.z *= .8
	
	velocity += gravity * delta
	
	var input_direction = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		input_direction += transform.basis.z
	if Input.is_action_pressed("move_backward"):
		input_direction -= transform.basis.z
	if Input.is_action_pressed("move_left"):
		input_direction += transform.basis.x
	if Input.is_action_pressed("move_right"):
		input_direction -= transform.basis.x
	
	velocity += input_direction.normalized() * SPEED
	
	move_and_slide(velocity, Vector3(0, 1, 0))
