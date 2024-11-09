extends Node2D

@export var file: Resource
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: RichTextLabel = $RichTextLabel
@onready var harmanimation: AnimatedSprite2D = $Harm

var data: Array = []
var word: String
var available: bool = true

func trigger():
	sprite.animation = "attack"
	label.text = ""
	available = false

func harm(type: String):
	harmanimation.play(type)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	word = data.pick_random()
	label.text = word

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
		word = data.pick_random()
		label.text = word
		available = true
