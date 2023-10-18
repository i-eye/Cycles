extends Button
@export var SymptomScene: PackedScene
var isThisMonth: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	if isThisMonth:
		var scene = SymptomScene.instantiate()
		get_tree().current_scene.add_child(scene)
		scene.deleteOnEnd = true
		scene.day = int(get_node("Label").text)
		scene.month = get_parent().viewMonth
		scene.year = get_parent().viewYear
		scene.readyTwo()
	
