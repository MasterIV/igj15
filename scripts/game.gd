extends Node2D


@onready var units = [$Units/Archer,  $Units/Warrior, $Units/Wizard]
@onready var input: LineEdit = $LineEdit

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# the enemy will attack regularly
	pass

func _on_line_edit_text_changed(new_text: String) -> void:
	for unit in units:
		if unit.word == new_text and unit.available:
			unit.trigger()
			input.text = ""
