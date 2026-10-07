extends Control

var call_listened := false
var messages_found := false
var photo_found := false
var evidence_found := 0


func _ready() -> void:
	$MessagesPanel.hide()
	$PhotoPanel.hide()
	$CallPanel.hide()

	update_evidence_counter()


func update_evidence_counter() -> void:
	$Content/MainContainer/EvidenceCounter.text = "УЛИКИ: %d / 3" % evidence_found


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
