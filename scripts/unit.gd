extends Node2D

@export var file: Resource
@onready var sprite = $AnimatedSprite2D
@onready var label: RichTextLabel = $RichTextLabel

var data: Array = []
var word: String
var available = true

func trigger():
	sprite.animation = "attack"
	word = data.pick_random()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	word = data.pick_random()
	label.text = word


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
