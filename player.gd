extends KinematicBody
var curHp : int = 10
var maxHp : int = 10
var damage : int = 1
var gold : int = 0
var attackRate : float = 0.3
var lastAttackTime : int = 0
var moveSpeed : float = 7.0
var jumpForce : float = 10.0
var gravity : float = 15.0
var DashDirection = 10
var vel : Vector3 = Vector3()
onready var camera = get_node("CameraOrbit")
onready var attackRayCast = get_node("AttackRayCast")
# called every physics step (60 times a second)
func _physics_process(delta):
  
  vel.x = 0
  vel.z = 0
  
  var input = Vector3()
  
  # movement inputs
  if Input.is_action_pressed("move_left"): 	input.z += 1
  if Input.is_action_pressed("move_right"): 	 input.z -= 1
  if Input.is_action_pressed("move_backward"): 	 input.x += 1
  if Input.is_action_pressed("move_forward"): 	input.x -= 1
  
  # normalize the input vector to prevent increased diagonal speed
  input = input.normalized()
  
  # get the relative direction
  var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
  
  # apply the direction to our velocity
  vel.x = dir.x * moveSpeed
  vel.z = dir.z * moveSpeed
  
  # gravity
  vel.y -= gravity * delta
  
 
  # move along the current velocity
  vel = move_and_slide(vel, Vector3.UP)
  if Input.is_action_just_pressed("dash"): input = Vector3() *2000
 
