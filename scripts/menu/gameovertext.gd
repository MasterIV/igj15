extends RichTextLabel

var fulltext: String = text
var currenttext: String = ""
var currentindex = -1
var typingspeed = 0.4
var deltasave = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_text("")
	set_process(true)
	self.newText("You have lost this marvellous game.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentindex < len(fulltext):
		if delta + deltasave > typingspeed:
			while delta > 0:
				delta -= typingspeed
				writeNextCharacter()
			delta *= -1
			deltasave = delta
		else:
			deltasave += delta

func writeNextCharacter() -> void:
	if currentindex < len(fulltext)-1:
		currentindex += 1
		currenttext += fulltext[currentindex]
		self.set_text(currenttext)

func newText(newtext: String) -> void:
	fulltext = newtext
	currentindex = -1
	deltasave = 0
	currenttext = ""
	self.set_text("")
