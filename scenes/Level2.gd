extends Node

func _ready():
	$Plataforma2.primary = false
	$Plataforma.plataformas_a_mover.append($Plataforma2)
