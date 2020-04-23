extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	for x in range(10):
		for y in range(10):
			pass #$TileMap.set_cell(x, y, randi() % 2 - 1)
	
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton:
		var button = event as InputEventMouseButton
		if button.pressed:
			pass
			#$TileMap.set_cell(int(button.position.x / 8), int(button.position.y / 8), -1)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func place_material(position, material):
	var mat_scene = preload("res://GenericMaterial.tscn")
	var node = mat_scene.instance()
	node.translate(position)
	add_child(node)


func _on_KinematicBody2D_mined_at(position):
	print("player mined ad ", position)
	var map_point = $TileMap.world_to_map(position)
	
	var material = $TileMap.get_cellv(map_point)
	print(material)
	place_material(position, material)
	$TileMap.set_cellv(map_point, -1)
	
	pass # Replace with function body.


func _on_AnimatedSprite2_animation_finished():
	if $KinematicBody2D/AnimatedSprite2.animation == "attack":
		$KinematicBody2D/AnimatedSprite2.play("default")
