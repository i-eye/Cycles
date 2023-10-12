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
	pass # Replace with function body.


func loadInfo():
	pass

func saveInfo():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	for object in symptoms:
		var array: Array[String] = [str(object.day),str(object.month),str(object.year),SMake(object.mood),SMake(object.physical),SMake(object.exercise),SMake(object.medication),SMake(object.other),object.comments]
		var strings = PackedStringArray(array)
		save_game.store_csv_line(strings)
	
func SMake(array: PackedStringArray) -> String:
	var string: String
	for element in array:
		string += (element + ";")
	string.erase(string.length())
	return string

func hasData(d,m,y) -> bool:
	return false

func getData():
	pass
