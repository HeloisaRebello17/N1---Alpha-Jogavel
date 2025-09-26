extends Control
const GAME_SCENE_PATH := "res://assets/Mains/world.tscn"

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE_PATH)

func _on_play_button_2_pressed() -> void:
	get_tree().quit()
