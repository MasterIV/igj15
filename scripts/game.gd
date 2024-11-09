extends Node2D

@onready var units = [$Units/Archer,  $Units/Warrior, $Units/Wizard, $Units/Bard]
@onready var enemy = $Enemy
@onready var input: LineEdit = $LineEdit


var hp: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_line_edit_text_changed(new_text: String) -> void:
	for unit in units:
		if unit.word == new_text and unit.available:
			unit.trigger()
			input.text = ""

func _on_attack_timer_timeout() -> void:
	hp -= 5
	enemy.attack()
