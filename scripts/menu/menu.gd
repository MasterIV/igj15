extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenu/StartButton.grab_focus()
	if OS.has_feature("web"):
		$MainMenu/ExitButton.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$MainMenu.visible = false
	$InfoText.visible = false
	$StartGameText.visible = true
	$ButtonClicked.play()
	await get_tree().create_timer(1.0).timeout
	$StartGameText/Number.countdown()
	await get_tree().create_timer(1.0).timeout
	$StartGameText/Number.countdown()
	await get_tree().create_timer(1.0).timeout
	$MainMenu.visible = true
	$InfoText.visible = true
	$StartGameText.visible = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	$Logo.visible = false
	$InfoText.visible = true
	$ButtonClicked.play()
	$InfoText.newText("Welcome Dungeon Dwellers!
Will you slay the horrific Dragon? Or will the Dragon feed on your corpses? Who knows!

Credits:
created @IGJam15, 2024
Judith Gastell (Head of 2D)
Tamara Meyendriesch (Expert of 2D)
Tobias Rojahn (Expert Senior Dev)
Felix Wagner (Expert Dev)
Marcel Zons (Expert Designer)
Manuel Kuczynski (Expert Motion Designer)")
