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
	self.newText("You are victorious. You have done something that no one else could achieve. You defeated a mighty Dragon. Your names will forever be sung in song. Future generations will remember you as the Slayers of the Dragon.
Content, the Heroes return to town. They thank the Bard for the great help and praise the energy he has put into the fight.
They wish him good luck and never speak to him again.")

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
