extends KinematicBody2D

const boost_speed = 500
const max_speed = 75
const stop_speed = 500

var speed = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		speed = speed.move_toward(input_vector * max_speed, boost_speed * delta)
	else:
		animationState.travel("Idle")
		speed = speed.move_toward(Vector2.ZERO, stop_speed * delta)
		
	speed = move_and_slide(speed)
