extends Area2D

var main
var attack_to_enemy_name
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_current_scene()



func _on_attack_to_enemy_area_body_entered(body):
	main.get_node("Player").attack = true
	main.get_node("Player").attack_real = true
	self.attack_to_enemy_name = body.name


func _on_attack_to_enemy_area_body_exited(body):
	main.get_node("Player").attack = false
	main.get_node("Player").attack_real = false

func attackk():
	main.get_node(self.attack_to_enemy_name).health = 0
