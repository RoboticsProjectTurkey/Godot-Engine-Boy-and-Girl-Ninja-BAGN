extends Area2D

var speed = 2000
var direction
var main

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_current_scene()

func _physics_process(delta):
	position += transform.x * speed * delta * direction


func _on_kunai_body_entered(body):
	if body.name == "Player":
		body.health -= 20
	queue_free()


func _on_kunai_player_area_entered(area):
	queue_free()
