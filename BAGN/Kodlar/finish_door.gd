extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_finish_door_body_entered(body):
	if body.name == "Player":
		if body.is_pressed_buton == true and body.score == 5:
			$Timer.start()
			$open.visible = true
			$unlocked.visible = false
	elif body.name == "Car":
			$Timer.start()
			$locked.visible = false
			$open.visible = true
			$unlocked.visible = false


func _on_Timer_timeout():
	get_tree().change_scene("res://Sahneler/Deneme_Sahnesi2.tscn")
