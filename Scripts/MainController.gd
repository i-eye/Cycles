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
	var periodLength = 28
	var bleedTime = 6
	var d = time.day
	var m = time.month
	var y = time.year
	
	
	if(SymptomInformation.isPeriod(d,m,y)):
		var isPeriod: bool = true
		var calcDay: int = d
		var calcMonth: int = m
		var calcYear: int = y
		var day: int = 0
		while(isPeriod):
			calcDay -= 1
			if(calcDay == 0):
				calcMonth -=1
				if(calcMonth == 0):
					calcYear -=1
				calcDay = DaySelections.MonthLength(calcMonth,calcYear)
			day += 1
			if(!SymptomInformation.isPeriod(calcDay,calcMonth,calcYear)):
				isPeriod = false
		var timeLeft = bleedTime - day
		if(timeLeft == 0 or timeLeft == 1):
			return "Last Day!"
		elif(timeLeft == -1 or timeLeft == -2):
			return "Lasting long\n"+str(-1 * timeLeft)+" days over"
		elif(timeLeft <= -3):
			return str(-1 * timeLeft) +" days over\n seek medical attention"
		else:
			return str(timeLeft) + " days left"
	else:
		var isPeriod: bool = false
		var calcDay: int = d
		var calcMonth: int = m
		var calcYear: int = y
		var day: int = 0
		var count: int = 0
		var noData: bool = false
		while(!isPeriod):
			calcDay -= 1
			if(calcDay == 0):
				calcMonth -=1
				if(calcMonth == 0):
					calcYear -=1
				calcDay = DaySelections.MonthLength(calcMonth,calcYear)
			day += 1
			count += 1
			if(SymptomInformation.isPeriod(calcDay,calcMonth,calcYear)):
				isPeriod = true
			if(count > 31):
				noData = true
				break;
		var nextPeriod: int = periodLength - day
		if(noData):
			return "No Data \n Log Something!"
		if(nextPeriod > 0):
			return "In "+str(nextPeriod)+" days"
		elif(nextPeriod == 0):
			return "Period today :("
		else:
			return "Period should've occured"
	return "Error"
