extends KinematicBody2D

const UP = Vector2(0,-1)
var motion = Vector2() 

func _physics_process(delta):
	motion.y += 10
	if(Input.is_action_pressed("ui_right")):
		motion.x = 100
		$doll_sprite.flip_h = false
		$doll_sprite.play('Run')
	elif(Input.is_action_pressed("ui_left")):
		motion.x = -100
		$doll_sprite.flip_h = true
		$doll_sprite.play('Run')		
	else:
		$doll_sprite.play('Idle')
		motion.x = 0
	
	if(is_on_floor()):
		motion.y = 0.5
		if(Input.is_action_just_pressed("ui_up")):
			motion.y = -300
	else:
		$doll_sprite.play('Jump')
	
	motion = move_and_slide(motion, UP)
