extends Node2D

var info: SymptomInformation
var deleteOnEnd: bool = false;
var day = Time.get_datetime_dict_from_system().day
var month = Time.get_datetime_dict_from_system().month
var year = Time.get_datetime_dict_from_system().year
# Called when the node enters the scene tree for the first time.
func _ready():
	info = get_node("/root/SymptomInformation") as SymptomInformation
	var dateString = str(year) + "-" + str(month) + "-" + str(day) 
	$Date.text = dateString
	print(info.hasData(day,month,year))
	if(info.hasData(day,month,year)):
		fillData(info.getData(day,month,year))
	
	

func fillData(information: SymptomInformation.SymptomsObject):
	print(information.mood)
	var buttons = $SymptomButtons.get_children()
	for button in buttons:
		if(button.toggly):
			var string = button.symptomName
			match button.symptomType:
				0: if(information.mood.has(string)): button.toggleBool(true)
				1: if(information.physical.has(string)): button.toggleBool(true)
				2: if(information.exercise.has(string)): button.toggleBool(true)
				3: if(information.medication.has(string)): button.toggleBool(true)
				4: if(information.other.has(string)): button.toggleBool(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_down():
	logSymptoms()
	if(deleteOnEnd):
		queue_free()
	else:
		get_tree().change_scene_to_file("res://Scenes/home.tscn")

func logSymptoms():
	var object = info.SymptomsObject.new()
	object.day = day
	object.month = month
	object.year = year
	var buttons = $SymptomButtons.get_children()
	for button in buttons:
		if(button.toggly):
			var string = button.symptomName
			match button.symptomType:
				0: object.mood.append(string)
				1: object.physical.append(string)
				2: object.exercise.append(string)
				3: object.medication.append(string)
				4: object.other.append(string)
	info.appendData(object)
