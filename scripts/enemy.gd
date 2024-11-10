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
var health:int = 100
var not_bard:int = 0

const UNIT_ACTIVE_TIME:int = 10000
const MIN_ACTIVATION:int = 4000
const MAX_ACTIVATION:int = 6000

var rng = RandomNumberGenerator.new()

func activate_hero():
	var u = units.keys().pick_random()
	
	# we need more bard in our lifes
	if u != "Bard": not_bard += 1
	if not_bard > 3: 
		u = "Bard"
		not_bard = 0
	
	if units[u].active < 1:
		cooldown = rng.randi_range(MIN_ACTIVATION, MAX_ACTIVATION)
		units[u].active = UNIT_ACTIVE_TIME
		units[u].icon.value = 100
	
func _process(delta: float) -> void:
	cooldown -= delta * 1000
	
	# Dont activate a new character while the bard is still active
	if cooldown < 1 and units["Bard"].active < 1:
		activate_hero()
		
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
	
	var active_heros:int = 0
	for u in units.keys():
		if units[u].active > 0: active_heros += 1
	if active_heros < 1: activate_hero()
	
	harmanimation.play(type)
	health -= 10		
	return true

func attack(type: String):
	sprite.animation = "attack"
	attacksounds[type].play()

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
