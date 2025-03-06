extends CanvasLayer

@onready var main_buttons_container: VBoxContainer = $MainButtonsContainer
@onready var boss_one_button: Button = $BossSelectContainer/BossOneButton
@onready var boss_select_container: VBoxContainer = $BossSelectContainer
@onready var start_game_button: Button = $MainButtonsContainer/StartGameButton
const TITLE_SONG: AudioStream = preload("res://songs/title.mp3")

func _ready() -> void:
	main_buttons_container.show()
	boss_select_container.hide()
	start_game_button.grab_focus()
	Transition.fade_in()
	Music.play_song(TITLE_SONG)

func _on_start_game_button_pressed() -> void:
	start_game_button.release_focus()
	Transition.fade_out()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("uid://b88jiv1oxbim5")

func _on_boss_select_button_pressed() -> void:
	main_buttons_container.hide()
	boss_select_container.show()
	boss_one_button.grab_focus()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_boss_one_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://b88jiv1oxbim5")

func _on_boss_two_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://qdkpf1kaj3ag")
