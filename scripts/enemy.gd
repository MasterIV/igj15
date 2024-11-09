extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var icons: GridContainer = $Icons


var difficulty = 8
var units = {
	"Archer": load("res://assets/icons/archer.png"), 
	"Warrior": load("res://assets/icons/warrior.png"), 
	"Wizard": load("res://assets/icons/wizard.png"), 
	"Bard": load("res://assets/icons/bard.png")
}

var weaknesses: Array[Dictionary] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, difficulty):
		var unit = units.keys().pick_random()
		var icon = load("res://scenes/entity/icon.tscn").instantiate()
		
		weaknesses.append({"unit": unit, "icon": icon })
		icon.texture = units[unit]
		icons.add_child(icon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func harm(type: String):
	if type == weaknesses[0]["unit"]:
		var w = weaknesses.pop_front()
		w["icon"].queue_free()
		
	if len(weaknesses) < 1:
		pass #victory

func attack():
	sprite.animation = "attack"

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
