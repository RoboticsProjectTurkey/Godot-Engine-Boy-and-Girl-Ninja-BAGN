extends KinematicBody2D


var direction = -1
var speed = 350
var jump_deger = 5500
var gravity = 250
var velocity = Vector2()

var kuani = preload("res://Sahneler/kunai_enemy.tscn")
var can_fire = false

var score = 0
var health = 100

var real_dead = false

var attack = false
var player_position_x
var player_position_y

var is_dead = false
var attack_to_player = false

var platform_end = false

var main

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_current_scene()


func _process(_delta):
	
	if real_dead == true:
		$AnimatedSprite.play("real_dead")
		return
	dead_animations()
	if is_dead == true:
		return
	
	if attack_to_player == true:
		return
	
	if platform_end == true:
		direction = direction * -1
		platform_end = false
	
	see_player()
	attack_func()
	
	velocity.x = direction * speed
	velocity.y = velocity.y + gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	player_animation()

func player_animation():
	if is_on_floor():
		if direction == 1:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("Run")
		elif direction == -1:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("Run")
		else:
			$AnimatedSprite.play("Idle")
	else:
		if direction == 1:
			$AnimatedSprite.flip_h = false
		if direction == -1:
			$AnimatedSprite.flip_h = true

func dead_animations():
	$HUD_Enemy.update_health(health)
	if health <= 0:
		is_dead = true
		if not is_on_floor():
			velocity.y += gravity
			velocity = move_and_slide(velocity, Vector2.UP)
			return
		$AnimatedSprite.play("Dead")
		if $AnimatedSprite.frame == 9:
			$CollisionShape2D.disabled = true
			real_dead = true
		else:
			return true

func see_player():
	$RayCast2D.cast_to.x = 2500 * direction
	if $RayCast2D.is_colliding():
		main.get_node("HUD").update_message("Fark Edildiniz")
		attack = true
		
		if can_fire == true:
			var kp = kuani.instance()
			main.add_child(kp)
			if direction == -1:
				kp.direction = -1
			elif direction == 1:
				kp.direction = 1
			elif direction == 0:
				if $AnimatedSprite.flip_h == true:
					kp.direction = -1
				elif $AnimatedSprite.flip_h == false:
					kp.direction = 1
			kp.transform = $Muzzle.global_transform
			can_fire = false

func attack_func():
	if attack == true:
		player_position_x = main.get_node("Player").position.x
		player_position_y = main.get_node("Player").position.y
		if is_on_floor():
			if player_position_x - position.x > 0:
				direction  = 1
			elif player_position_x - position.x < 0:
				direction = -1
			elif player_position_y - position.y < 0:
				direction = 0
	velocity.x = direction * speed
	velocity.y = velocity.y + gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	player_animation()
	return


func _on_VisibilityNotifier2D_screen_entered():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for e in enemies:
		if self.name == e.name:
			e.get_node("HUD_Enemy").update_health(health)
			e.get_node("HUD_Enemy").show_health(true)
		else:
			e.get_node("HUD_Enemy").show_health(false)


func _on_VisibilityNotifier2D_screen_exited():
	$HUD_Enemy.show_health(false)


func _on_Attack_To_Player_Area_body_entered(body):
	if body.name == "Player":
		$attack_timer.start()
		attack_to_player = true


func _on_Attack_To_Player_Area_body_exited(body):
	attack_to_player = false


func _on_attack_timer_timeout():
	if attack_to_player == true and is_dead == false:
		$AnimatedSprite.play("knife_attack")
		direction = 0
		main.get_node("Player").health = 0
		attack_to_player = true


func _on_kunai_timer_timeout():
	can_fire = true
