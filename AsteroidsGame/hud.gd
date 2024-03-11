extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Another one, lost to the void...")
	await $Timer.timeout

	$StartMessage.text = "Void Traveler"
	$StartMessage.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$Score.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_timer_timeout():
	$Message.hide()
