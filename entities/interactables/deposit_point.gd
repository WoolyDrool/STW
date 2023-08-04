extends Area3D

enum depositType {GARB, REC, ALL}
@export var DepositType : depositType
var tex

# Called when the node enters the scene tree for the first time.
func _ready():
	tex = $"Interact"
	if DepositType == 0:
		tex.interactText = "Garbage Deposit"
	elif  DepositType == 1:
		tex.interactText = "Recycle Deposit"
	elif DepositType == 2:
		tex.interactText = "All Deposit"
	
	#match typeof(DepositType):
	#	0:
	#		tex.interactText = "Garbage Deposit"
	#	1:
	#		tex.interactText = "Recycle Deposit"
	#	2:
	#		tex.interactText = "All Deposit"
	#	_:
	#		tex.interactText = "Depositor"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _deposit():
	if DepositType == 0:
		_deposit_garbage()
	elif  DepositType == 1:
		_deposit_recycle()
	elif DepositType == 2:
		_deposit_all()

	#match typeof(DepositType):
	#	0:
	#		tex.interactText = "Garbage Deposit"
	#		_deposit_garbage()
	#	1:
	#		tex.interactText = "Recycle Deposit"
	#		_deposit_recycle()
	#	2:
	#		tex.interactText = "All Deposit"
	#		_deposit_all()
	#	_:
	#		print("No deposit type specified")

func _deposit_garbage():
	PlayerInventory.remove_garbage(1)
	print("Garbage Deposited")
	# Do Thing
	pass

func _deposit_recycle():
	PlayerInventory.remove_recycle(1)
	print("Recycle Deposited")
	# Do Thing
	pass

func _deposit_all():
	PlayerInventory.remove_all()
	print("All Deposited")
	# Do Thing
	pass
