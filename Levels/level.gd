extends Node2D

@onready var dead_sound: AudioStreamPlayer = $DeadSound
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var resume_button: Button = $PauseMenu/Overlay/ButtonsContainer/ResumeButton
@export var next_level: PackedScene
@export var song: AudioStream

var boss_killed: bool = false

func _ready() -> void:
	get_tree().paused = false
	Bus.boss_dead.connect(on_boss_dead)
	Bus.player_dead.connect(on_player_dead)
	Transition.fade_in()
	Music.play_song(song)
	pause_menu.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not get_tree().paused:
		pause_menu.show()
		resume_button.grab_focus()
		get_tree().paused = true

func on_boss_dead() -> void:
	boss_killed = true
	dead_sound.play()
	await get_tree().create_timer(2).timeout
	$BossDeadLabel.show()
	Transition.fade_out()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(next_level)

func on_player_dead() -> void:
	dead_sound.play()
	if boss_killed: return
	Transition.fade_out()
	await get_tree().create_timer(4).timeout
	get_tree().reload_current_scene()

#region Pause menu buttons:

func _on_resume_button_pressed() -> void:
	pause_menu.hide()
	get_tree().paused = false

func _on_reset_button_pressed() -> void:
	$PauseMenu/Overlay/ButtonsContainer/ResetButton.release_focus()
	Transition.fade_out()
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	$PauseMenu/Overlay/ButtonsContainer/ResetButton.release_focus()
	Transition.fade_out()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("uid://bn0jv6rimentm")

func _on_quit_button_pressed() -> void:
	$PauseMenu/Overlay/ButtonsContainer/ResetButton.release_focus()
	Transition.fade_out()
	await get_tree().create_timer(2).timeout
	get_tree().quit()
