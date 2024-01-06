extends Node2D

var rotation_speed = deg_to_rad(125)
var velocity = 0.0
var max_velocity = 100
var friction = 200
var acceleration = 100
var wheel_rotation = deg_to_rad(25)

@onready var top_left_wheel = $TopLeftWheel
@onready var top_right_wheel = $TopRightWheel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var wheel_current_rotation = 0
	var up_or_down = false
	
	if Input.is_action_pressed("ui_right"):
		self.rotation += rotation_speed * delta * (velocity/max_velocity)
		wheel_current_rotation += wheel_rotation
	if Input.is_action_pressed("ui_left"):
		self.rotation -= rotation_speed * delta * (velocity/max_velocity)
		wheel_current_rotation += -wheel_rotation
	if Input.is_action_pressed("ui_down"):
		velocity -= acceleration * delta
		up_or_down = true
	if Input.is_action_pressed("ui_up"):
		velocity += acceleration * delta
		up_or_down = true
		
	if !up_or_down:
		if velocity > 0:
			velocity = max( (velocity - friction * delta), 0) 
		if velocity < 0:
			velocity = min( (velocity + friction * delta), 0)
	
	velocity = clamp(velocity, -max_velocity, max_velocity)
	
	top_left_wheel.rotation = wheel_current_rotation
	top_right_wheel.rotation = wheel_current_rotation
	
	self.position += self.transform.basis_xform(Vector2.UP) * velocity * delta
