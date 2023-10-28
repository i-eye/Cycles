extends TextureButton
@export var SymptomScene: PackedScene
@export var PeriodScene: PackedScene
var isThisMonth: bool = true
var symptom = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tint.modulate = Color(1,1,1,.65)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setTint(value: bool):
	$Tint.visible = value
func ToggleTint():
	$Tint.visible = !$Tint.visible

func _on_button_down():
	print(symptom)
	if isThisMonth:
		if(!symptom):
			var scene = SymptomScene.instantiate()
			get_tree().current_scene.add_child(scene)
			scene.deleteOnEnd = true
			scene.day = int(get_node("Label").text)
			scene.month = get_parent().get_parent().viewMonth
			scene.year = get_parent().get_parent().viewYear
			scene.readyTwo()
		else:
			ToggleTint()
			SaveObject()
	
func SaveObject():
	var info = get_node("/root/SymptomInformation")
	var object: SymptomInformation.SymptomsObject
	var day = int(get_node("Label").text)
	var month = get_parent().get_parent().viewMonth
	var year = get_parent().get_parent().viewYear 
	if(!info.hasData(day,month,year)):
		object = info.SymptomsObject.new()
		object.day = day
		object.month = month
		object.year = year
	else:
		object = info.getData(day,month,year)
	object.isPeriod = $Tint.visible
	info.appendData(object)
