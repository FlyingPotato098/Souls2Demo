extends Label

@export var healthnode : Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_health_current_health(x: int) -> void:
	text = "health =" + str(x)
