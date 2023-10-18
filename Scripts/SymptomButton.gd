extends TextureButton

@export_enum("Mood", "Physical", "Exercise", "Meditation", "Other") var symptomType: int
@export var symptomName: String
var toggly: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = symptomName
	

func changeSize():
	#print("Changing Size")
	var size = $Label.size.x
	scale = Vector2(.085+(size/241),.5)
	$Label.scale = Vector2(1/scale.x,2)


func toggle():
	toggleBool(!toggly)
	
func toggleBool(state: bool):
	#toggling
	if(state):
		texture_normal = load("res://Sprites/SymptomButtonToggled.png")
		toggly = true
	else:
		texture_normal = load("res://Sprites/SymptomButton.png")
		toggly = false
	


func _on_label_item_rect_changed():
	changeSize()




func _on_button_down():
	toggle()
