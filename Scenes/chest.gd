extends Area2D

signal chest_touched(chest)

func _on_body_entered(body: Node2D) -> void:
	chest_touched.emit(self)
