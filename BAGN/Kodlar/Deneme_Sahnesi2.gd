extends Node2D

var load_file = "user://User_File/game_file"

var duty = "Burası Zaten Deneme"

func _ready():
	$HUD.update_health($Player.health)
	$HUD.update_message("Deneme")
	$HUD.update_duty(duty)
	if get_tree().get_current_scene().name == "Deneme_Sahnesi":
		$HUD/menu1.show()
		get_tree().paused = true
	else:
		$HUD/menu1.hide()
		get_tree().paused = false
	
	var d = Directory.new()
	if not d.dir_exists("user://User_File"):
		d.make_dir("user://User_File")
		var save_game = File.new()
		save_game.open(load_file, File.WRITE)
		save_game.store_string("")
		save_game.close()


func _process(delta):
	if Input.get_action_strength("ui_cancel"):
		$HUD/menu2.show()
		get_tree().paused = true


func _on_HUD_exit():
	get_tree().quit()


func _on_HUD_start():
	get_tree().paused = false
	$HUD/menu1.hide()

func _on_HUD_save():
	var save_game = File.new()
	save_game.open(load_file, File.WRITE)
	save_game.store_string(get_tree().get_current_scene().get_name())
	save_game.close()


func _on_HUD_load_game():
	var load_game = File.new()
	if load_game.file_exists(load_file):
		load_game.open(load_file, File.READ)
		if load_game.get_as_text() == "Deneme_Sahnesi":
			get_tree().change_scene("res://Sahneler/Deneme_Sahnesi2.tscn")

func _on_HUD_resume():
	$HUD/menu2.hide()
	get_tree().paused = false


func _on_HUD_restart():
	get_tree().paused = false
	$HUD/menu2.hide()
	get_tree().reload_current_scene()


func _on_HUD_informations():
	$HUD/menu1.hide()
	$HUD/menu3.show()


func _on_HUD_ok():
	$HUD/menu3.hide()
	$HUD/menu1.show()
