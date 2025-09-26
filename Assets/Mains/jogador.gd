extends CharacterBody2D

@export var speed: float = 200.0
@export var acceleration: float = 7.0

var direction: Vector2 = Vector2.ZERO

@export_node_path("NavigationAgent2D") var navigation_agent_path: NodePath
@onready var navigation: NavigationAgent2D = get_node(navigation_agent_path) as NavigationAgent2D


func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float) -> void:
	navigation.target_position = get_global_mouse_position()

	direction = global_position.direction_to(navigation.get_next_path_position()).normalized()
	velocity = velocity.lerp(direction * speed, acceleration * delta)

	move_and_slide()
