extends Node2D

var deleteOnEnd: bool = false;
var day = Time.get_datetime_dict_from_system().day
var month = Time.get_datetime_dict_from_system().month
var year = Time.get_datetime_dict_from_system().year
# Called when the node enters the scene tree for the first time.
func _ready():
	var dateString = str(year) + "-" + str(month) + "-" + str(day) 
	$Date.text = dateString


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_down():
	if(deleteOnEnd):
		queue_free()
	else:
		get_tree().change_scene_to_file("res://Scenes/home.tscn")
