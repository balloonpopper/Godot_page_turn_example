extends Node

func _on_Button_pressed_2d() -> void:
	var response=get_tree().change_scene("res://2dPageTurn.tscn")
	#print_debug("Response="+response)


func _on_Button_pressed_3d() -> void:
	var response=get_tree().change_scene("res://3dPageTurn.tscn")
