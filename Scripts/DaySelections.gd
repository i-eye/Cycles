extends Control

@export var thisMonth: PackedScene

#@export var otherMonth: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var today = Time.get_datetime_dict_from_system(false)
	var todayColumn = today.weekday - 1
	if(todayColumn == -1):
		todayColumn = 6
	var todayRow: int = floor(today.day / 7) + 1
	MakeIcon(todayColumn,todayRow,today.day)
	var backNumber = ((todayRow) + (todayColumn) * 7)
	var frontNumber = (5 - todayRow) + (4 - todayColumn) * 7
	print(backNumber)
	print(frontNumber)
	for i in range(backNumber + 1):
		var dayTemp = today.day - i
		var monthTemp = today.month
		var yearTemp = today.month
		if(dayTemp < 1):
			dayTemp += MonthLength(monthTemp,monthTemp)
			monthTemp -= 1
		var column = todayColumn - i
		var row = todayRow
		while(column < 0):
			column += 7
			row -=1
		
		MakeIcon(column,row,dayTemp, monthTemp == today.month)
		
	#for i in range()
	
func MonthLength(month, year) -> int:
	print(month)
	if(month == 1 and (year % 4) == 0):
		return 29
	if(month == 1):
		return 28
	if(month == 3 or month == 5 or month == 8 or month == 10):
		return 30
	return 31
	

func MakeIcon(column: int,row: int,day: int, thisMonth: true) -> void:
	
	var scene: Sprite2D = thisMonth.instantiate()
	add_child(scene)
	scene.global_position = Vector2(40+(column*80),400+(row*70))
	scene.get_node("Label").text = str(day)

func get_weekday(d, m, y):
	# Returns the weekday (int)
	var t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
	if m < 3: y -= 1
	return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
