extends Node2D

@onready var units = [$Units/Archer,  $Units/Warrior, $Units/Wizard, $Units/Bard]
@onready var enemy = $Enemy
@onready var input: LineEdit = $LineEdit

@onready var party_health: TextureProgressBar = $PartyHealth
@onready var dragon_health: TextureProgressBar = $DragonHealth

var hp: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_line_edit_text_changed(new_text: String) -> void:
	for unit in units:
		unit.typing(new_text)
		if unit.word == new_text and unit.available:
			unit.trigger(enemy.harm(unit.name))
			dragon_health.value = enemy.get_health()
			input.text = ""

func _on_attack_timer_timeout() -> void:
	hp -= 5
	party_health.value = hp
	
	var type = ["scratch", "bite"].pick_random()
	units.pick_random().harm(type)
	enemy.attack(type)
	
	if hp <= 0:
		# you died!
		get_tree().reload_current_scene()
