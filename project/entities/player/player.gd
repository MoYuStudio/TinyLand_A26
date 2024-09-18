
class_name Player extends CharacterBody3D

# 移动速度
var speed = 9
# 重力加速度
var gravity = -64
# 跳跃速度
var jump_speed = 64

func _ready() -> void:
	# 初始化代码可以放在这里
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.z -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.z += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	
	# 跳跃逻辑
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_speed

	velocity.y += gravity * delta
	
	move_and_slide()
