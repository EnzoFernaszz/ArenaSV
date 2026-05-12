extends Area2D

signal chest_touched(chest)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		chest_touched.emit(self)
