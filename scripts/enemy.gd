extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var harmanimation: AnimatedSprite2D = $HarmAnimation
@onready var attacksounds: Dictionary = {
	"bite": $BiteSound,
	"scratch": $ScratchSound
}

@onready var units: Dictionary = {
	"Archer": {"active": 0, "icon": $Icons/Archer}, 
	"Warrior": {"active": 0, "icon": $Icons/Warrior}, 
	"Wizard": {"active": 0, "icon": $Icons/Wizard}, 
	"Bard": {"active": 0, "icon": $Icons/Bard}
}

var difficulty: int = 8
var cooldown: int = 0
var health = 100

const UNIT_ACTIVE_TIME = 10000
const MIN_ACTIVATION = 4000
const MAX_ACTIVATION = 6000

var rng = RandomNumberGenerator.new()
	
func _process(delta: float) -> void:
	cooldown -= delta * 1000
	
	# Dont activate a new character while the bard is still active
	if cooldown < 1 and units["Bard"].active < 1:
		var unit = units.keys().pick_random()
		if units[unit].active < 1:
			cooldown = rng.randi_range(MIN_ACTIVATION, MAX_ACTIVATION)
			units[unit].active = UNIT_ACTIVE_TIME
		
	for u in units.keys():
		if units[u].active > 0:
			if u != "Bard": units[u].active -= delta * 1000
			units[u].icon.value = max(0, 100 * (units[u].active / UNIT_ACTIVE_TIME))

func get_health():
	return health
	
func harm(type: String) -> bool:
	if units[type].active < 1:
		return false
		
	units[type].active = 0
	units[type].icon.value = 0
	
	harmanimation.play(type)
	health -= 5		
	return true

func attack(type: String):
	sprite.animation = "attack"
	attacksounds[type].play()

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
