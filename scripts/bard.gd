extends Node2D

@export var file: Resource
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: RichTextLabel = $RichTextLabel

var data: Dictionary
var word: String
var available: bool = true

var rng = RandomNumberGenerator.new()

func trigger():
	sprite.animation = "attack"
	label.text = ""
	available = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	select_word()
	label.text = word

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_typo(text: String) -> String:
	var l: int = len(text)
	var a: int = rng.randi_range(0, l)
	var b: int    = rng.randi_range(0, l)
	var c: String = text[a]
	text[a] = text[b]
	text[b] = c
	return text
	
func select_word():
	var type: String = ["typo", "long"].pick_random()
	match type:
		"typo":
			word = create_typo(data["typo"].pick_random())
		"long":
			word = data["long"].pick_random()
		"continuus":
			pass

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
		select_word()
		label.text = word
		available = true
