extends Area2D
class_name AreaExit

@export var sprite : Sprite2D

# Variável que será preenchida com a referência do seu nó CanvasLayer (FimDeFaseUI)
# Assume que o FimDeFaseUI é IRMÃO do nó onde este script está.
@onready var fim_de_fase_ui = get_parent().get_node("FimDeFaseUI") 
var is_open = false
var fim_de_fase_ativo = false # Sinaliza que a tela de fim de fase está visível

func _ready():
	close()
	# Inicializa a escuta de input como FALSE, só ativamos quando a fase termina.
	set_process_input(false) 

func open():
	is_open = true
	sprite.region_rect.position.x = 22

func close():
	is_open = false
	sprite.region_rect.position.x = 0

func _input(event):
	# Esta função só é chamada se 'fim_de_fase_ativo' for TRUE
	if fim_de_fase_ativo:
		# Checa se o evento é uma tecla do teclado e se ela foi pressionada
		if event is InputEventKey and event.is_pressed():
			
			# 1. Chama o GameManager para finalizar a fase e voltar ao mapa
			GameManager.end_current_level_and_return_to_map()
			
			# 2. Desliga o processamento de input
			set_process_input(false)
			fim_de_fase_ativo = false

func _on_body_entered(body):
	# Condição: Porta aberta E o corpo que entrou é o Player
	if is_open && body is PlayerController:
		# Mostra a tela de Fim de Fase
		show_end_screen(body) 


func show_end_screen(player_node):
	# 1. Trava o jogador
	player_node.set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	# 2. Ativa o input neste script (para esperar por qualquer tecla)
	set_process_input(true)
	fim_de_fase_ativo = true
	
	# 3. Exibe a interface de Fim de Fase
	if is_instance_valid(fim_de_fase_ui):
		fim_de_fase_ui.visible = true
	else:
		# Se a UI não for encontrada, faz a transição de forma direta
		print("ALERTA: Nó 'FimDeFaseUI' não encontrado! Transição direta para o mapa.")
		GameManager.end_current_level_and_return_to_map()
