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


func _on_button_body_entered(body):
	if body.name == "Player":
		body.is_pressed_buton = true
		get_tree().get_current_scene().get_node("finish_door").get_node("unlocked").visible = true
		get_tree().get_current_scene().get_node("finish_door").get_node("locked").visible = false
		$button2.visible = false
		$button.visible = true
