extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0  # Removido o sinal negativo, pois ajustaremos a direção no código
const GRAVITY = 980.0

@export var inverted_gravity: bool = false  # Define se o jogador está no teto

func _ready():
	if inverted_gravity:
		velocity.y = -velocity.y  # Ajusta a gravidade inicial se necessário

func _physics_process(delta: float) -> void:
	# Adiciona a gravidade correta
	if not is_on_floor():
		velocity.y += (-GRAVITY if inverted_gravity else GRAVITY) * delta

	# Pulo
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = (-JUMP_VELOCITY if not inverted_gravity else JUMP_VELOCITY)  # Ajusta o pulo conforme a gravidade

	# Movimento horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
