extends Area2D

var main

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Platfrom_end_body_entered(body):
	if body.is_in_group("enemy"):
		main.get_node(body.name).platform_end = true
