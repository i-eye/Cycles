extends Button

@export var scene: PackedScene
@onready var currentScene = get_tree().current_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	print(currentScene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_down():
	get_tree().change_scene_to_packed(scene)
