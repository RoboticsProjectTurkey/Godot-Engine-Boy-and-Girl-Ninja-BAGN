extends RigidBody2D

export var Speed = 20
var player_is_in_the_car = false

func _physics_process(delta):
	if player_is_in_the_car == true:
		$Camera2D.current = true
		if Input.is_action_pressed("ui_right"):
			$wheel1.angular_velocity = Speed
			$wheel2.angular_velocity = Speed
		elif Input.is_action_pressed("ui_left"):
			$wheel1.angular_velocity = -Speed
			$wheel2.angular_velocity = -Speed
		elif Input.is_action_pressed("ui_up"):
			position.y -= 100
			rotation_degrees = 0
		elif Input.is_action_pressed("ui_down"):
			player_is_in_the_car = false
			get_tree().get_current_scene().get_node("Player").get_node("CollisionShape2D").disabled = false
			get_tree().get_current_scene().get_node("Player").get_node("AnimatedSprite").visible = true
			get_tree().get_current_scene().get_node("Player").position = position
			get_tree().get_current_scene().get_node("Player").position.x = position.x + 750
			get_tree().get_current_scene().get_node("Player").get_node("Camera2D").current = true
			get_tree().get_current_scene().get_node("Player").is_in_the_car = false
			$wheel1.angular_velocity = 0
			$wheel2.angular_velocity = 0
	else:
		$Camera2D.current = false


func _on_player_area_body_entered(body):
	if body.name == "Player":
		body.is_in_the_car = true
		player_is_in_the_car = true
		body.get_node("Camera2D").current = true
