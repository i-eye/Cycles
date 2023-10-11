extends Node2D

@onready var number: Label = $DayNumber
@onready var affix: Label = $DayAffix
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
