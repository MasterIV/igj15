extends Node2D

@onready var units = [$Units/Archer,  $Units/Warrior, $Units/Wizard, $Units/Bard]
@onready var enemy = $Enemy
@onready var input: LineEdit = $LineEdit
@onready var health_bar: ProgressBar = $HealthBar


var hp: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_line_edit_text_changed(new_text: String) -> void:
	for unit in units:
		unit.typing(new_text)
		if unit.word == new_text and unit.available:
			unit.trigger(true)
			enemy.harm(unit.name)
			input.text = ""

func _on_attack_timer_timeout() -> void:
	hp -= 5
	health_bar.value = hp
	enemy.attack()
	
	if hp <= 0:
		# you died!
		get_tree().reload_current_scene()
