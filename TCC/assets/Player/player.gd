extends KinematicBody2D

# Player Structure #
enum{
	move,
	roll,
	attack
}

var state = move
var speed = Vector2.ZERO
# Player Structure #


# Player Animation Layer #
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

#runs at game start
func _ready():
	animationTree.active = true
# Player Animation Layer #


# Player Physics Control #
const boost_speed = 500
const max_speed = 75
const stop_speed = 500

#controls move
func move_state(delta):
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

#controls roll
func roll_state(delta):
	pass

#controls attack
func attack_state(delta):
	pass

#return the player's state machine 
func _physics_process(delta):
	match state:
		move:
			move_state(delta)
		roll:
			roll_state(delta)
		attack:
			attack_state(delta)
# Player Physics Control #
