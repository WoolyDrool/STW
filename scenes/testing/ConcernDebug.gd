extends RichTextLabel

var queenPriority

@export var JackValue : int = 0
@export var KingValue : int = 3
@export var AceValue : int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	_makeJudgement()
	pass # Replace with function body.

func _makeJudgement():
	# from the doc: Once she knows the location of the player, she may decide to either pursue the player directly or herd them towards a shrine. She will select the shrine to herd the player towards based on the location of the shrine and how many sacrifices the player has given to that shrine. She will generally herd the player away from her own shrine.
	# Generally she will prefer to herd players away from hers and the Jack's shrines, and towards whichever has had the most sacrifices. Therefore, Jack's # should start lowest, and she'll prioritize the highest scoring shrine otherwise.
	# Static value of distance from her shrine + amount of items sacrificed?
	# Randomize whether she'll go to Ace or King if they're equal?
	if AceValue > JackValue and KingValue > JackValue:
		print("The Jack is the lowest")
		if AceValue > KingValue:
			print("Ace is higher than King")
			queenPriority = "Ace"
		else:
			print("King is greater than or equal to Ace.")
			queenPriority = "King"
	elif JackValue == AceValue or JackValue == KingValue:
		print("Jack is equal to Ace or King")
		if KingValue > AceValue:
			print("King is higher than Ace.")
			queenPriority = "King"
		elif AceValue > KingValue:
			print("Ace is higher than King.")
			queenPriority = "Ace"
		else:
			print("All values are equal.")
			queenPriority = "King"
	else:
		print("Jack is the highest")
		queenPriority = "Jack"
	print("Queen's priority is")
	print(queenPriority)

func _reportChange():
	print("Jack:")
	print(JackValue)
	print("King:")
	print(KingValue)
	print("Ace:")
	print(AceValue)
	_makeJudgement()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_use_jack_pressed():
	JackValue = JackValue + 1
	_reportChange()

func _on_use_king_pressed():
	KingValue = KingValue + 1
	_reportChange()

func _on_use_ace_pressed():
	AceValue = AceValue + 1
	_reportChange()
