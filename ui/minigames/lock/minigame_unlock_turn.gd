extends Area2D

var keyholeSprite
var rotationHelper

var clickPoint

var startingRotation
var winRotation

var isHeld : bool = false
var hasWon : bool = false
var canHold : bool = false
var upY : float
var upX : float

# Called when the node enters the scene tree for the first time.
func _ready():
	keyholeSprite = $"SprMgLockBottomKeyhole"
	rotationHelper = $"RotationHelper"

	# 1 & 2
	startingRotation = keyholeSprite.rotation
	winRotation = (startingRotation + 90)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Still trying to figure out the best way to rotate the lock
	if !hasWon:
		if isHeld:
			# 1 When the scene is loaded, startingRotation is populated by keyholeSprite's rotation
			# 2 Then, winRotation is defined based off of startingRotation
			# 3 When the player clicks on the lock, it stores the mouse position at the frame of the click in the variable clickPoint
			#	Additionally, it stores the additional click and drag movement of the mouse in the variable upX/Y
			# 4 Then, the child rotationHelper node has its position set to the clickPoint
			# 5 MATH (idk im stupid)
			# 6 Then keyholeSprite has its rotation augmented, and finally the cursor is warped to the clickPoint

			#var adj = Vector2(clickPoint.x, clickPoint.y)
			#keyholeSprite.rotation = startingRotation + adj
			
			# 4
			rotationHelper.position = clickPoint

			# 5
			# The sum difference of clickPoints - upY
			var difference = rotationHelper.position - Vector2(upX, upY)
			var floatDif : float = difference.x - difference.y
			clickPoint + difference
			keyholeSprite.rotation = startingRotation + floatDif / 3.14

			
			#var vecToCenter = rotationHelper.position
			#var angle = global_position.direction_to(vecToCenter)
			#var dist = global_position.distance_to(angle)
			#var finalRot = startingRotation + upY / dist * winRotation
			#clickPoint = Vector2(clickPoint.x + upX, clickPoint.y + upY)
			
			# 6
			#keyholeSprite.rotation = startingRotation + (atan2(angle.y, angle.x)) / dist
			#keyholeSprite.rotation = finalRot
			#keyholeSprite.rotation = startingRotation + (sin(upY) + cos(upX)) / dist * winRotation
			Input.warp_mouse(rotationHelper.position)
			
			print_debug(keyholeSprite.rotation)

		if keyholeSprite.rotation >= winRotation:
			hasWon = true
			EventBus.G_UI_MG_LOCK_END.emit()
			print("won minigame")


func _on_input_event(viewport:Node, event:InputEvent, shape_idx:int):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if canHold:
			if event.pressed:
				isHeld = true
				# 3
				clickPoint = get_global_mouse_position()
				print(clickPoint)
			else:
				isHeld = false
	pass # Replace with function body.
	
	# 3
	if event is InputEventMouseMotion:
		upY = event.relative.y
		upX = event.relative.x

func _on_mouse_entered():
	canHold = true
	pass # Replace with function body.


func _on_mouse_exited():
	canHold = false
	pass # Replace with function body.
