extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()

func _on_text_changed(new_text: String) -> void:
	print(new_text) # Replace with function body.

func _on_focus_exited() -> void:
	grab_focus()
