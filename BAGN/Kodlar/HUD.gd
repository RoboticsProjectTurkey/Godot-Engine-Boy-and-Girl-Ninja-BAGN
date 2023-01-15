extends CanvasLayer

signal start
signal save
signal load_game
signal restart
signal ok
signal resume
signal options
signal informations
signal exit

# Called when the node enters the scene tree for the first time.
func _ready():
	$Message_Label.hide()


func _process(delta):
	$menu1/AnimationPlayer.play("Yeni Animasyon")

func update_score(score):
	$Score_Label.text = str(score)

func update_kill(kill):
	$Kill_Label.text = str(kill)

func update_duty(duty):
	$Duty_Label.text = str(duty)

func update_health(health):
	$Health_Bar.value = health

func update_message(message):
	$Message_Label.text = str(message)
	$Message_Label.show()
	$message_timer.start()


func _on_message_timer_timeout():
	$Message_Label.hide()


func _on_start_button_pressed():
	emit_signal("start")


func _on_load_button_pressed():
	emit_signal("load_game")


func _on_informations_pressed():
	emit_signal("informations")


func _on_options_button_pressed():
	emit_signal("options")


func _on_exit_button_pressed():
	emit_signal("exit")


func _on_resume_button_pressed():
	emit_signal("resume")


func _on_save_button_pressed():
	emit_signal("save")


func _on_OK_button_pressed():
	emit_signal("ok")


func _on_restart_pressed():
	emit_signal("restart")
