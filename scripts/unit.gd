extends Node2D

@export var file: Resource
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: RichTextLabel = $RichTextLabel
@onready var harmanimation: AnimatedSprite2D = $Harm
@onready var attackanimation: AnimatedSprite2D = $Attack
@onready var hit_flash: AnimationPlayer = $HitFlash

var data: Array = []
var word: String
var available: bool = true

func trigger(success: bool):
	if success:
		sprite.animation = "attack"
		attackanimation.play()
	else:
		sprite.animation = "shrug"
	label.text = ""
	available = false

func harm(type: String):
	harmanimation.play(type)
	hit_flash.play("flash")

func typing(text: String):
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	word = data.pick_random()
	label.text = word

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_animation_looped() -> void:
	if sprite.animation == "attack" or sprite.animation == "shrug":
		sprite.animation = "default"
		word = data.pick_random()
		label.text = word
		available = true
