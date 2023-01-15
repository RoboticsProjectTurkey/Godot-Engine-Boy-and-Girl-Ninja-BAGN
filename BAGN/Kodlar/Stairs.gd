extends Area2D


var main


# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Stairs_body_entered(body):
	if body.name == "Player":
		main.get_node("Player").is_in_stairs = true


func _on_Stairs_body_exited(body):
	if body.name == "Player":
		main.get_node("Player").is_in_stairs = false
