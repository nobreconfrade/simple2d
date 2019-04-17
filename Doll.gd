extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCEL = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2() 

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if(Input.is_action_pressed("ui_right")):
		motion.x += ACCEL
		motion.x = min(motion.x, MAX_SPEED)
		$doll_sprite.flip_h = false
		$doll_sprite.play('Run')
	elif(Input.is_action_pressed("ui_left")):
		motion.x -= ACCEL
		motion.x = -MAX_SPEED if (motion.x < -MAX_SPEED) else motion.x
		$doll_sprite.flip_h = true
		$doll_sprite.play('Run')		
	else:
		$doll_sprite.play('Idle')
		friction = true
		
	
	if(is_on_floor()):
		motion.y = 0.5
		if(Input.is_action_just_pressed("ui_up")):
			motion.y = JUMP_HEIGHT
		if(friction == true):
			motion.x = lerp(motion.x, 0, 0.2)
			
	else:
		if (motion.y < 0):
			$doll_sprite.play('Jump')
		else:
			$doll_sprite.play('Fall')			
		if(friction == true):
			motion.x = lerp(motion.x, 0, 0.05)
				
	motion = move_and_slide(motion, UP)
