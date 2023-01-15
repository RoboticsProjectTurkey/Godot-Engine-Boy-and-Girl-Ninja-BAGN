extends KinematicBody2D

var direction = 0
var speed = 1000
var jump_deger = 5500
var gravity = 150
var velocity = Vector2()

var score = 0
var health = 100

var is_pressed_buton = false

var kuani = preload("res://Sahneler/kunai.tscn")
var can_fire = false
var is_in_the_car = false

var is_dead = false
var is_slide = false

var main
var attack = false
var attack_real = false

var is_in_spike = false
var is_in_stairs = false

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_current_scene()


func _process(_delta):
	if is_in_the_car == true:
		$AnimatedSprite.visible = false
		$CollisionShape2D.disabled = true
		return
	dead_animations()
	if is_dead == true:
		return
	
	attack_to_enemy()
	
	if is_in_stairs == true:
		if Input.is_key_pressed(KEY_D):
			climb()
			return
	
	if Input.is_key_pressed(KEY_G):
		shoot()
	
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	slide()
	
	if Input.get_action_strength("ui_select"):
		if is_on_floor():
			velocity.y += -jump_deger
	
	velocity.x = direction * speed
	velocity.y = velocity.y + gravity
	
	
	velocity = move_and_slide(velocity, Vector2.UP)
	player_animation()

func Jump_Player_Spike():
	velocity.y += -8000

func player_animation():
	if is_on_floor() and attack == false:
		if is_slide == true:
			$AnimatedSprite.play("Slide")
			if direction == 1:
				$AnimatedSprite.flip_h = false
			if direction == -1:
				$AnimatedSprite.flip_h = true
		elif direction == 1:
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
		if Input.get_action_strength("ui_select") or is_in_spike == true:
			$AnimatedSprite.play("Jump")

func climb():
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * 100
	$AnimatedSprite.play("Climb")
	if Input.get_action_strength("ui_up"):
		velocity.y -= 5
	if Input.get_action_strength("ui_down"):
		velocity.y += 5 
	velocity = move_and_slide(velocity, Vector2.UP)

func dead_animations():
	main.get_node("HUD").update_health(health)
	if health <= 0:
		is_dead = true
		if not is_on_floor():
			velocity.y += gravity
			velocity = move_and_slide(velocity, Vector2.UP)
			return
		$AnimatedSprite.play("Dead")
		if $AnimatedSprite.frame == 9:
			get_tree().reload_current_scene()
		else:
			return true

func slide():
	if Input.get_action_strength("ui_down"):
		$CollisionShape2D.rotation_degrees = 90
		$CollisionShape2D.shape.radius = 150
		is_slide = true
	if Input.get_action_strength("ui_up"):
		$CollisionShape2D.rotation_degrees = 0
		$CollisionShape2D.shape.radius = 120
		is_slide = false
		main.get_node("Player").is_on_floor()

func attack_to_enemy():
	if attack == true:
		if is_on_floor():
			if Input.is_key_pressed(KEY_S):
				$AnimatedSprite.play("knife_attack")
				$attack_to_enemy_area.attackk()
			elif Input.is_key_pressed(KEY_W):
				$AnimatedSprite.play("throw")
				$attack_to_enemy_area.attackk()
		if not is_on_floor():
			if Input.is_key_pressed(KEY_A):
				$AnimatedSprite.play("jump_attack")
				$attack_to_enemy_area.attackk()
				velocity.y = velocity.y + gravity
				velocity = move_and_slide(velocity, Vector2.UP)
	if attack_real == true:
		return

func shoot():
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

func _on_kunai_timer_timeout():
	can_fire = true
