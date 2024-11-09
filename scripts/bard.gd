extends Node2D

@export var file: Resource
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: RichTextLabel = $RichTextLabel
@onready var harmanimation: AnimatedSprite2D = $Harm
@onready var attackanimation: AnimatedSprite2D = $Attack

var data: Dictionary
var word: String
var available: bool = true

var rng = RandomNumberGenerator.new()

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
	
func typing(text: String):
	if text == label.text and text != word:
		label.text = word
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	select_word()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_typo(text: String) -> String:
	var l: int = len(text)
	var a: int = rng.randi_range(0, l)
	var b: int = rng.randi_range(0, l)
	var c: String = text[a]
	text[a] = text[b]
	text[b] = c
	return text
	
func select_word():
	var type: String = ["typo", "long", "continuous"].pick_random()
	match type:
		"typo":
			word = create_typo(data["typo"].pick_random())
			label.text = word
		"long":
			word = data["long"].pick_random()
			label.text = word
		"continuous":
			word = data["continuous"].pick_random()
			label.text = word.split(" ")[0]

func _on_animation_looped() -> void:
	if sprite.animation == "attack":
		sprite.animation = "default"
		select_word()
		available = true
