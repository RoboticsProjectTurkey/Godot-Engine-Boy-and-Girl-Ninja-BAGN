extends Area2D


var main


# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimationPlayer.play("ratotion")


func _on_Saw_body_entered(body):
	if body.name == "Player":
		main.get_node("Player").health -= 20
		main.get_node("HUD").update_health(main.get_node("Player").health)
