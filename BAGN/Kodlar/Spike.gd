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



func _on_Spike_body_entered(body):
	if body.name == "Player":
		main_scene.get_node("Player").health -= 10
		main_scene.get_node("HUD").update_health(main_scene.get_node("Player").health)
		main_scene.get_node("Player").Jump_Player_Spike()
		main_scene.get_node("Player").is_in_spike = true


func _on_Spike_body_exited(body):
	if main_scene.get_node("Player").is_in_spike == true:
		$Spike_Timer.start()


func _on_Spike_Timer_timeout():
	main_scene.get_node("Player").is_in_spike = false
