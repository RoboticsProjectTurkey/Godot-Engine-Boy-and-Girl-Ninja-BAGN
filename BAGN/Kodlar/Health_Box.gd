extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var main_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	main_scene = get_tree().get_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Health_Box_body_entered(body):
	if body.name == "Player":
		main_scene.get_node("Player").health += 50
		if main_scene.get_node("Player").health > 100:
			 main_scene.get_node("Player").health = 100
		main_scene.get_node("HUD").update_health(main_scene.get_node("Player").health)
		queue_free()
