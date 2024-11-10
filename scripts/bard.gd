extends "res://scripts/unit.gd"

var rng = RandomNumberGenerator.new()

func typing(text: String):
	if text == label.text and text != word:
		label.text = word
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	select_word()
	
func create_typo(text: String) -> String:
	var l: int = len(text)
	var a: int = rng.randi_range(0, l-1)
	var b: int = rng.randi_range(0, l-1)
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
	if sprite.animation == "attack" or sprite.animation == "shrug":
		sprite.animation = "default"
		select_word()
		available = true
