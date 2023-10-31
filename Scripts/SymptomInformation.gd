extends Node

class SymptomsObject extends Object:
	var day: int
	var month: int
	var year: int
	var mood: PackedStringArray
	var physical: PackedStringArray
	var exercise: PackedStringArray
	var medication: PackedStringArray
	var other: PackedStringArray
	var comments: String
	var isPeriod: bool
var directory
var symptoms: Array[SymptomsObject]
# Called when the node enters the scene tree for the first time.
func _ready():
	#print(SMake(PackedStringArray(["game","lame"])))
	directory = OS.get_user_data_dir()
	loadInfo()
	
	pass


func loadInfo():
	if(FileAccess.file_exists(directory+"/savegame.txt")):
		var saved_game = FileAccess.open(directory+"/savegame.txt", FileAccess.READ)
		while(true):
			var objects = saved_game.get_csv_line(",")
			print(objects)
			if(objects.size() > 2):
				var object = SymptomsObject.new()
				object.day = int(objects[0])
				object.month = int(objects[1])
				object.year = int(objects[2])
				object.mood = objects[3].split(";")
				object.physical = objects[4].split(";")
				object.exercise = objects[5].split(";")
				object.medication = objects[6].split(";")
				object.other = objects[7].split(";")
				object.comments = objects[8]
				#if(objects.size() > 10):
					#print(objects[9])
				object.isPeriod = (int(objects[9]) == 1)
				symptoms.append(object)
			else:
				break

func saveInfo():
	var save_game = FileAccess.open(directory+"/savegame.txt", FileAccess.WRITE)
	for object in symptoms:
		#print(object.mood)
		var num
		if(object.isPeriod):
			num = 1
		else:
			num = 0
		#print(num)
		if(hasSubstance(object.day,object.month,object.year) or 
		   isPeriod(object.day,object.month,object.year)):
			var array: Array[String] = [str(object.day),str(object.month),str(object.year),SMake(object.mood),SMake(object.physical),SMake(object.exercise),SMake(object.medication),SMake(object.other),object.comments, str(num)]
			var strings = PackedStringArray(array)
			save_game.store_csv_line(strings)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		saveInfo()

func SMake(array: PackedStringArray) -> String:
	if(array.is_empty()):
		return ""
	var string: String
	for element in array:
		string += (element + ";")
	string = string.erase(string.length()-1)
	return string

func hasData(d,m,y) -> bool:
	for symptom in symptoms:
		if(symptom.day == d and symptom.month == m and symptom.year == y):
			return true
	return false
	
func hasSubstance(d,m,y) -> bool:
	for symptom in symptoms:
		if(symptom.day == d and symptom.month == m and symptom.year == y):
			if( (!symptom.mood.is_empty() and symptom.mood[0] != "") or
				(!symptom.physical.is_empty() and symptom.physical[0] != "") or
				(!symptom.exercise.is_empty() and symptom.exercise[0] != "") or
				(!symptom.medication.is_empty() and symptom.medication[0] != "") or
				(!symptom.other.is_empty() and symptom.other[0] != "") or
				(!symptom.comments.is_empty() and symptom.comments != "") 
				):
				#print(symptom.mood)
				return true
	return false
func isPeriod(d,m,y) -> bool:
	for symptom in symptoms:
		if(symptom.day == d and symptom.month == m and symptom.year == y):
			return symptom.isPeriod
	return false

func getData(d,m,y) -> SymptomsObject:
	for symptom in symptoms:
		if(symptom.day == d and symptom.month == m and symptom.year == y):
			return symptom
	return null
	
func appendData(data: SymptomsObject):
	symptoms.sort()
	#print(str(hasData(data.day,data.month,data.year)))
	if(hasData(data.day,data.month,data.year)):
		for i in range(symptoms.size()):
			if(symptoms[i].day == data.day and symptoms[i].month == data.month and symptoms[i].year == data.year):
				#(i)
				symptoms[i] = data
	else:
		symptoms.append(data)
	saveInfo()
