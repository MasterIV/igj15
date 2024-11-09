extends Node2D

@export var file: Resource
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: RichTextLabel = $RichTextLabel

var data: Dictionary
var word: String
var available: bool = true

func trigger():
	sprite.animation = "attack"
	label.text = ""
	available = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	word = data["typo"].pick_random()
	label.text = word

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
		word = data["typo"].pick_random()
		label.text = word
		available = true
