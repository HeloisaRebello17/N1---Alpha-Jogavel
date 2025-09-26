extends Node2D 

# Mantenha o caminho exato que você copiou:
const CENA_ALVO = "res://Assets/Levels/area_1.tscn"

func _on_area_mouse_entered():
	# Removidas as linhas que buscavam e tentavam desativar o Player.
	# Na cena do mapa, basta mudar a cena.
	
	# Chama a transição de cena de forma assíncrona.
	call_deferred("mudar_cena")

func mudar_cena():
	# Executa a mudança de cena.
	var erro = get_tree().change_scene_to_file(CENA_ALVO)
	
	if erro != OK:
		print("ERRO ao carregar a cena: ", CENA_ALVO)
		# Se você ainda está vendo este erro, o caminho está incorreto!
