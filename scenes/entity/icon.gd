extends TextureProgressBar

@onready var arrow: Sprite2D = $Arrow
@onready var icon: TextureProgressBar = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	arrow.visible = icon.value > 0
