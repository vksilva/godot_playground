extends Node2D

var rotation_speed = deg_to_rad(125)
var velocity = 0.0
var max_velocity = 100
var acceleration = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("ui_right"):
		self.rotation += rotation_speed * delta * (velocity/max_velocity)
	if Input.is_action_pressed("ui_left"):
		self.rotation -= rotation_speed * delta * (velocity/max_velocity)
	if Input.is_action_pressed("ui_down"):
		velocity -= acceleration * delta
	if Input.is_action_pressed("ui_up"):
		velocity += acceleration * delta
	
	velocity = clamp(velocity, -max_velocity, max_velocity)
	
	self.position += self.transform.basis_xform(Vector2.UP) * velocity * delta
