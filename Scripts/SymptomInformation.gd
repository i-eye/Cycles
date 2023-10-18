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

var symptoms: Array[SymptomsObject]
# Called when the node enters the scene tree for the first time.
func _ready():
	#print(SMake(PackedStringArray(["game","lame"])))
	loadInfo()
	pass


func loadInfo():
	var saved_game = FileAccess.open("user://savegame.save", FileAccess.READ)
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
			symptoms.append(object)
		else:
			break

func saveInfo():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	for object in symptoms:
		#print(object.mood)
		var array: Array[String] = [str(object.day),str(object.month),str(object.year),SMake(object.mood),SMake(object.physical),SMake(object.exercise),SMake(object.medication),SMake(object.other),object.comments]
		var strings = PackedStringArray(array)
		save_game.store_csv_line(strings)
	
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
			if(!symptom.mood.is_empty() or !symptom.exercise.is_empty() or !symptom.medication.is_empty() or !symptom.other.is_empty() or !symptom.physical.is_empty() or !symptom.comments.is_empty()):
				return true
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
				print(i)
				symptoms[i] = data
	else:
		symptoms.append(data)
