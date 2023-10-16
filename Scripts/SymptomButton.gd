extends TextureButton
@export_enum("Mood", "Physical", "Exercise", "Meditation", "Other") var symptomType: int
@export var symptomName: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = symptomName

