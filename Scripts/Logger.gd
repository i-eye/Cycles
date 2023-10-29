extends Node2D

var info: SymptomInformation
var deleteOnEnd: bool = false;
var day = Time.get_datetime_dict_from_system().day
var month = Time.get_datetime_dict_from_system().month
var year = Time.get_datetime_dict_from_system().year

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("ready")
	info = get_node("/root/SymptomInformation") as SymptomInformation
	
	
	
func readyTwo():
	#print("ready2")
	var dateString = str(year) + "-" + str(month) + "-" + str(day) 
	$Date.text = dateString
	#print(info.hasData(day,month,year))
	if(info.hasData(day,month,year)):
		fillData(info.getData(day,month,year))

func fillData(information: SymptomInformation.SymptomsObject):
	#(str(information.day))
	var buttons = $SymptomButtons.get_children()
	for button in buttons:
		button.toggleBool(false)
		var string = button.symptomName
		#print(string)
		match button.symptomType:
			0: if(information.mood.has(string)): button.toggleBool(true)
			1: if(information.physical.has(string)): button.toggleBool(true)
			2: if(information.exercise.has(string)): button.toggleBool(true)
			3: if(information.medication.has(string)): button.toggleBool(true)
			4: if(information.other.has(string)): button.toggleBool(true)
	$TextEdit.text = information.comments

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_down():
	var parent = get_parent()
	if(parent and parent.name == "Calender"):
		parent.DeleteIcons()
		parent.CreateIcons(parent.viewMonth,parent.viewYear)
	
	queue_free()
		#get_tree().change_scene_to_file("res://Scenes/home.tscn")

func logSymptoms():
	var object: SymptomInformation.SymptomsObject
	if(!info.hasData(day,month,year)):
		object = info.SymptomsObject.new()
		object.day = day
		object.month = month
		object.year = year
	else:
		object = info.getData(day,month,year)
	
	var buttons = $SymptomButtons.get_children()
	for button in buttons:
		var string = button.symptomName
		if(button.toggly):
			match button.symptomType:
				0: if(!object.mood.has(string)): object.mood.append(string)
				1: if(!object.physical.has(string)): object.physical.append(string)
				2: if(!object.exercise.has(string)): object.exercise.append(string)
				3: if(!object.medication.has(string)): object.medication.append(string)
				4: if(!object.other.has(string)): object.other.append(string)
				
		else:
			match button.symptomType:
				0: 
					object.mood.sort()
					if(object.mood.has(string)): object.mood.remove_at(object.mood.bsearch(string))
				1: 
					object.physical.sort()
					if(object.physical.has(string)): object.physical.remove_at(object.physical.bsearch(string))
				2: 
					object.exercise.sort()
					if(object.exercise.has(string)): object.exercise.remove_at(object.exercise.bsearch(string))
				3: 
					object.medication.sort()
					if(object.medication.has(string)): object.medication.remove_at(object.medication.bsearch(string))
				4: 
					object.other.sort()
					if(object.other.has(string)): object.other.remove_at(object.other.bsearch(string))
	if(!$TextEdit.text.is_empty()):
		object.comments = $TextEdit.text
	info.appendData(object)


func _on_log_button_button_down():
	#print("backButton")
	logSymptoms()
	var parent = get_parent()
	if(parent and parent.name == "Calender"):
		parent.DeleteIcons()
		parent.CreateIcons(parent.viewMonth,parent.viewYear)
	
	queue_free()
