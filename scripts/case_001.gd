extends Control

var call_listened := false
var messages_found := false
var photo_found := false
var evidence_found := 0
var theory_answered := false
var case_solved := false


func _ready() -> void:
	$MessagesPanel.hide()
	$PhotoPanel.hide()
	$CallPanel.hide()
	$Content/MainContainer/TheoryButton.hide()

	update_evidence_counter()


func update_evidence_counter() -> void:
	$Content/MainContainer/EvidenceCounter.text = "УЛИКИ: %d / 3" % evidence_found

	if evidence_found >= 3 and not theory_answered:
		$Content/MainContainer/TheoryButton.show()


# =========================
# СООБЩЕНИЯ
# =========================

func _on_messages_button_pressed() -> void:
	if not messages_found:
		messages_found = true
		evidence_found += 1
		update_evidence_counter()

	$Content.hide()
	$MessagesPanel.show()


func _on_back_button_pressed() -> void:
	$MessagesPanel.hide()
	$Content.show()


# =========================
# ФОТО
# =========================

func _on_photo_button_pressed() -> void:
	if not photo_found:
		photo_found = true
		evidence_found += 1
		update_evidence_counter()

	$Content.hide()
	$PhotoPanel.show()


func _on_photo_back_button_pressed() -> void:
	$PhotoPanel.hide()
	$Content.show()


# =========================
# ЗВОНОК
# =========================

func _on_call_button_pressed() -> void:
	$Content.hide()
	$CallPanel.show()


func _on_listen_button_pressed() -> void:
	if not call_listened:
		call_listened = true
		evidence_found += 1
		update_evidence_counter()

	$CallPanel/CallContent/CallStatus.text = "Статус: Прослушано"


func _on_call_back_button_pressed() -> void:
	$CallPanel.hide()
	$Content.show()



# =========================
# Теориии
# =========================


func _on_theory_button_pressed() -> void:
		$Content.hide()
		$TheoryPanel.show()


func _on_theory_button_1_pressed() -> void:
		show_result(
		"ВЕРСИЯ НЕ ПОДТВЕРДИЛАСЬ",
		"Илья не просто ушёл сам.\n\n"
		+ "Некоторые улики указывают на заранее подготовленное исчезновение, "
		+ "а не на спонтанный уход."
	)


func _on_theory_button_2_pressed() -> void:
		show_result(
		"ВЕРСИЯ НЕ ПОДТВЕРДИЛАСЬ",
		"Нет достаточных доказательств того, что Илью кто-то встретил "
		+ "после выхода из дома.\n\n"
		+ "Следы указывают на другую последовательность событий."
	)


func _on_theory_button_3_pressed() -> void:
		case_solved = true
		
		show_result(
		"ДЕЛО РАСКРЫТО",
		"Илья действительно планировал исчезновение заранее.\n\n"
		+ "Сообщение, отключённый телефон и подготовленные ключи указывают "
		+ "на то, что исчезновение не было спонтанным."
	)


func _on_back_to_case_button_pressed() -> void:
	$ResultPanel.hide()
	$Content.show()
	$Content/MainContainer/TheoryButton.hide()


func show_result(title: String, description: String) -> void:
	theory_answered = true

	$TheoryPanel.hide()
	$ResultPanel.show()

	$ResultPanel/ResultContent/ResultTitle.text = title
	$ResultPanel/ResultContent/ResultDescription.text = description


func _on_finish_case_button_pressed() -> void:
	$ResultPanel.hide()
	$EndPanel.show()

	if case_solved:
		$EndPanel/EndContent/EndDescription.text = "ДЕЛО №001 РАСКРЫТО\n\nТы правильно восстановил последовательность событий."
	else:
		$EndPanel/EndContent/EndDescription.text = "ДЕЛО №001 НЕ РАСКРЫТО\n\nТвоя версия не совпала с реальными событиями."


func _on_end_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
