extends Node2D

@export var file: Resource

var data: Array = []

func trigger():
	print("unit was triggered")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Common.load_data(file)
	print(data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
