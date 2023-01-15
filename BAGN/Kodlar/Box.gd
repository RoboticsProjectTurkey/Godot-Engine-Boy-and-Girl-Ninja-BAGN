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


func _on_Box_body_entered(body):
	if body.name == "Player":
		main_scene.get_node("Player").score += 1
		main_scene.get_node("HUD").update_score(main_scene.get_node("Player").score)
		queue_free()
