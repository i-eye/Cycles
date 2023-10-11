extends Control

@export var thisMonth: PackedScene

#@export var otherMonth: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var today = Time.get_datetime_dict_from_system(false)
	var todayColumn = today.weekday - 1
	if(todayColumn == -1):
		todayColumn = 6
	var todayRow: int = floor(today.day / 7)
	makeIcon(todayColumn,todayRow,today.day)
	var backNumber = ((todayRow + 1) + (todayColumn - 1) * 7)
	var frontNumber = (5 - todayRow) + (4 - todayColumn) * 7
	print(backNumber)
	print(frontNumber)
	#for i in range()
	
	
	
	

func makeIcon(column: int,row: int,day: int) -> void:
	
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
