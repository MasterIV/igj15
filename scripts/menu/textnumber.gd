extends RichTextLabel

var count = 3

func countdown() -> void:
	count -= 1
	self.set_text("[tornado radius=10.0 freq=5.0 connected=1][center]%s[/center][/tornado]" % count)
