extends Node


const MAPA_MUNDIAL_PATH = "res://Assets/Mains/world.tscn"

var current_area = 1
var area_path = "res://Assets/Scenes/Areas/"

var energy_cells = 0

func _ready():
	reset_energy_cells()

func _input(event):
	# Lógica para sair do jogo e voltar ao mapa (tecla ESC)
	if event.is_action_pressed("ui_cancel"):
		return_to_map()

# Chamado pela AreaExit quando o jogador completa a fase.
func end_current_level_and_return_to_map():
	print("FASE CONCLUÍDA! Retornando ao mapa mundial.")
	# Inicia o processo de transição para o mapa
	return_to_map()

# Função principal para retornar ao mapa.
# Usa call_deferred() para EVITAR o erro de "CollisionObject" durante o ciclo de física.
func return_to_map():
	# 1. Reseta a área para 1 para começar o jogo do início na próxima vez
	current_area = 1 
	
	# 2. CHAMA A MUDANÇA DE CENA DE FORMA ATRASADA (Deferred Call)
	call_deferred("executar_mudanca_cena")

# NOVA FUNÇÃO: Executa a transição no próximo ciclo de inatividade
func executar_mudanca_cena():
	# Carrega a cena do mapa mundial
	var erro = get_tree().change_scene_to_file(MAPA_MUNDIAL_PATH)
	
	if erro != OK:
		print("ERRO CRÍTICO: Não foi possível carregar a cena do mapa: ", MAPA_MUNDIAL_PATH)

func next_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("The player has moved to area " + str(current_area))
	set_up_area()

# Chamado por cada célula de energia que o jogador coleta
func add_energy_cell():
	energy_cells += 1
	print("Células coletadas: ", energy_cells)
	if energy_cells >= 4:
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		if is_instance_valid(portal):
			portal.open()
		else:
			print("Alerta: AreaExit não encontrada no grupo 'area_exits'.")

func set_up_area():
	reset_energy_cells()

func reset_energy_cells():
	energy_cells = 0
