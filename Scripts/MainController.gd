extends Node2D

@onready var number: Label = $TextureBackground/DayDisplay/DayNumber
@onready var affix: Label = $TextureBackground/DayDisplay/DayAffix
@export var symptomScene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var time = Time.get_date_dict_from_system(false);
	var day = time.day
	var affixText;
	number.text = str(day)
	if(day % 10 == 1 and day != 11): affixText = "st"
	elif(day % 10 == 2 and day != 12): affixText = "nd"
	elif(day % 10 == 3 and day != 13): affixText = "rd"
	else: affixText = "th"
	affix.text = affixText
	pass

func _on_log_symptoms_button_button_down():
	var scene = symptomScene.instantiate()
	get_tree().current_scene.add_child(scene)
	scene.deleteOnEnd = true
	scene.readyTwo()
	
func calculateNextPeriod() -> String:
	var time = Time.get_date_dict_from_system(false);
	var info = $"/root/SymptomInformation"
	var periodTime = 25
	var day = time.day
	var month = time.month
	var year = time.year
	for i in range(25):
		print("die")
	return "cry"
