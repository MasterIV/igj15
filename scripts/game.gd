extends Node2D





@onready var archer = $Units/Archer
@onready var warrior = $Units/Warrior

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	archer.trigger()

func _process(delta: float) -> void:
	# the enemy will attack regularly
	pass

func _on_line_edit_text_changed(new_text: String) -> void:
	# check if the entered word is one of the units and if it is trigger the unit
	# triggering the unit will set a new word for the unit and reset the input
	pass
