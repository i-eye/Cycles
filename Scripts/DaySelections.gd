extends Control

@export var buttonScene: PackedScene
@export var monthLabel: Label
var viewYear: int
var viewMonth: int
#@export var otherMonth: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var today = Time.get_datetime_dict_from_system()
	viewMonth = today.month
	viewYear = today.year
	#print(viewMonth)
	CreateIcons(viewMonth,viewYear)
	#DeleteIcons()

func CreateIcons(month,year):
	monthLabel.text = getMonth(month)
	var day = 1
	var todayColumn = get_weekday(day,month,year) - 1
	var todayRow: int = 0
	if(todayColumn == -1):
		todayColumn = 6
	
	
	MakeIcon(todayColumn,todayRow,day, true)
	#print(todayColumn)
	#print(todayRow)
	var backNumber = todayColumn + (todayRow)*7
	var frontNumber = (6 - todayColumn) + (5-todayRow)*7
	#print(backNumber)
	#print(frontNumber)
	
	for i in range(backNumber + 1):
		var dayTemp = day - i
		var monthTemp = month
		var yearTemp = month
		if(dayTemp < 1):
			dayTemp += MonthLength(monthTemp,yearTemp)
			monthTemp -= 1
		var column = todayColumn - i
		var row = todayRow
		while(column < 0):
			column += 7
			row -=1
		MakeIcon(column,row,dayTemp, monthTemp == month)
	
	for i in range(frontNumber + 1):
		var dayTemp = day + i
		var monthTemp = month
		var yearTemp = year
		if(dayTemp > MonthLength(monthTemp,yearTemp)):
			dayTemp -= MonthLength(monthTemp,monthTemp)
			monthTemp += 1
		var column = todayColumn + i
		var row = todayRow
		while(column > 6):
			column -= 7
			row += 1
		MakeIcon(column,row,dayTemp,monthTemp == month)
	
	
func getMonth(number: int) -> String:
	match number:
		1: return "January"
		2: return "February"
		3: return "March"
		4: return "April"
		5: return "May"
		6: return "June"
		7: return "July"
		8: return "August"
		9: return "September"
		10: return "October"
		11: return "November"
		12: return "December"
		_: return "wtf"
		
func DeleteIcons():
	var icons = get_children()
	for icon in icons:
		icon.queue_free()

func MonthLength(month, year) -> int:
	#print(month)
	if(month == 2 and (year % 4) == 0 and (year % 100) != 0):
		return 29
	if(month == 2):
		return 28
	if(month == 4 or month == 6 or month == 9 or month == 11):
		return 30
	return 31
	

func MakeIcon(column: int,row: int,day: int, thisMonth: bool) -> void:
	var scene: Button = buttonScene.instantiate() as Button
	add_child(scene)
	scene.global_position = Vector2(5+(column*80),360+(row*70))
	scene.get_node("Label").text = str(day)
	if(!thisMonth): scene.icon = (load("res://Sprites/otherDay.png"))

func get_weekday(d, m, y):
	# Returns the weekday (int)
	var t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
	if m < 3: y -= 1
	return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_left_arrow_pressed():
	viewMonth -= 1
	if(viewMonth == 0):
		viewMonth = 12
		viewYear -= 1
	DeleteIcons()
	CreateIcons(viewMonth,viewYear)
	


func _on_right_arrow_pressed():
	viewMonth += 1
	if(viewMonth > 12):
		viewMonth = 1
		viewYear += 1 # Replace with function body.
	DeleteIcons()
	CreateIcons(viewMonth,viewYear)
