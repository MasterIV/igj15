extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var icons: GridContainer = $Icons


var difficulty: int   = 8
var units: Dictionary = {
	"Archer": [load("res://assets/icons/archer.png"),load("res://assets/icons/archer_active.png")], 
	"Warrior": [load("res://assets/icons/warrior.png"),load("res://assets/icons/warrior_active.png")], 
	"Wizard": [load("res://assets/icons/wizard.png"), load("res://assets/icons/wizard_active.png")], 
	"Bard": [load("res://assets/icons/bard.png"), load("res://assets/icons/bard_active.png")]
}

var weaknesses: Array[Dictionary] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, difficulty):
		var unit = units.keys().pick_random()
		var icon = load("res://scenes/entity/icon.tscn").instantiate()
		
		weaknesses.append({"unit": unit, "icon": icon })
		icon.texture = units[unit][0]
		icons.add_child(icon)
		
	weaknesses[0]["icon"].texture = units[weaknesses[0]["unit"]][1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func harm(type: String) -> bool:
	if len(weaknesses) < 1 or type != weaknesses[0]["unit"]:
		return false
		
	var w = weaknesses.pop_front()
	w["icon"].queue_free()
	
	if len(weaknesses) < 1:
		pass #victory
	else:
		weaknesses[0]["icon"].texture = units[weaknesses[0]["unit"]][1]
		
	return true

func attack():
	sprite.animation = "attack"

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
