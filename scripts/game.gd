extends Node2D

@onready var units = [$Units/Archer,  $Units/Warrior, $Units/Wizard, $Units/Bard]
@onready var enemy = $Enemy
@onready var input: LineEdit = $LineEdit

@onready var party_health: TextureProgressBar = $PartyHealth
@onready var dragon_health: TextureProgressBar = $DragonHealth

@onready var defeat_timer: Timer = $Timers/Defeat
@onready var victory_timer: Timer = $Timers/Victory
@onready var attack_timer: Timer = $Timers/Attack


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
	
	if hp <= 0:
		for unit in units:
			unit.available = false
			unit.die()
			
		enemy.breath()
		defeat_timer.start()
		attack_timer.stop()
		input.visible = false
		
	else:
		var type = ["scratch", "bite"].pick_random()
		units.pick_random().harm(type)
		enemy.attack(type)


func _on_defeat_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/defeat.tscn")

func _on_victory_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/victory.tscn")
