extends Node2D

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(delta):
	# === CHECAGEM DE SEGURANÇA CONTRA CRASHES ===
	# 1. Checa se o nó principal ainda é válido.
	# 2. Checa se as referências cruciais (sprite, animation_player) ainda são válidas.
	# Se qualquer um for inválido (durante a transição de cena), o script para.
	if not is_instance_valid(player_controller) or \
	   not is_instance_valid(sprite) or \
	   not is_instance_valid(animation_player):
		return

	# flips the character sprite
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true
		
	# plays the movement animation
	if abs(player_controller.velocity.x) > 0.0:
		animation_player.play("move")
	else:
		animation_player.play("idle")
		
	# plays the jump animation
	if player_controller.velocity.y < 0.0:
		animation_player.play("jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")
