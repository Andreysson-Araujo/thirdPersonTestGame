extends CharacterBody3D

@export_category("Settings Player")
@export  var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var SPRINT_SPEED = 7
@export var MOUSE_SENSIVITY := 0.2
@export var CAMERA_LIMIT_DOWN := -80.0
@export var CAMERA_LIMIT_UP := 60.0
var flashlight_on := false




var CAM_VER := 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSIVITY))
		
		CAM_VER -= event.relative.y * MOUSE_SENSIVITY
		CAM_VER = clamp(CAM_VER, CAMERA_LIMIT_DOWN, CAMERA_LIMIT_UP)
		$AncoraCam.rotation_degrees.x = CAM_VER
		
		if Input.is_action_just_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		# Alternar lanterna (F)
		
		
		

		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		

	move_and_slide()
	
		# Interação
		
