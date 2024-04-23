extends Node3D

var rng = RandomNumberGenerator.new()
var bathroomInstance = preload("res://scenes/testing/restroom.tscn").instantiate()
var dockInstance = preload("res://scenes/testing/dock.tscn").instantiate()
var churchInstance = preload("res://scenes/testing/church.tscn").instantiate()

var setpieceList = ["church", "buildingA", "buildingB"]
var setPieceSpawns = [$lotSpawnW, $lotSpawnS, $boatSpawn1, $lotSpawnE, $boatSpawn2, $SpawnSetA, $SpawnSetB, $SpawnSetC, $SpawnSetD]
var LotSpawns = [$lotSpawnW, $lotSpawnS, $lotSpawnE]
var boatSpawns = [$boatSpawn1, $boatSpawn2]
var JackSpawns = [$ShrineC, $ShrineI, $ShrineF, $ShrineE, $ShrineA, $ShrineG]
var KingSpawns = [$ShrineA, $ShrineB, $ShrineE, $ShrineJ, $ShrineG, $ShrineH]
var AceSpawns = [$ShrineD, $ShrineH, $ShrineK]
var JackLoc
var JackShrine = preload("res://entities/interactables/shrines/zathu_shrine.tscn").instantiate()
var KingLoc
var KingShrine = preload("res://entities/interactables/shrines/jaum_shrine.tscn").instantiate()
var AceLoc
var AceShrine = preload("res://entities/interactables/shrines/nahki_shrine.tscn").instantiate()
var AcePlace

var distanceAce
var distanceKing
var distanceJack
var distValAce
var distValKing
var distValJack

var queenPriority
var JackValue
var JackUsed
var KingValue
var KingUsed
var AceValue
var AceUsed

func _findDistance():
	distanceAce = abs(AceLoc.global_position - $QueenCircle.global_position)
	distanceKing = abs(KingLoc.global_position - $QueenCircle.global_position)
	distanceJack = abs(JackLoc.global_position - $QueenCircle.global_position)
	print("Ace Distance is")
	print(distanceAce)
	distValAce = round((distanceAce.x * distanceAce.z)/1000)
	print(distValAce)
	print("King Distance is")
	print(distanceKing)
	distValKing = round((distanceKing.x * distanceKing.z)/1000)
	print(distValKing)
	print("Jack Distance is")
	print(distanceJack)
	distValJack = round((distanceJack.x * distanceJack.z)/1000)
	print(distValJack)

func _passJudgement():
	# how the fuck do I force these to add as integers and not strings?
	JackValue = distValJack
	AceValue = distValAce
	KingValue = distValKing
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

func _placeStage():
	#array.erase() is how to remove values from the array
	AceLoc = AceSpawns.pick_random()
	AceLoc.add_child(AceShrine)
	KingSpawns.erase(AceLoc)
	KingLoc = KingSpawns.pick_random()
	KingLoc.add_child(KingShrine)
	JackSpawns.erase(KingLoc)
	JackLoc = JackSpawns.pick_random()
	JackLoc.add_child(JackShrine)

func _restroomSpawn():
	var lotY = -4.943
	var lotRotY = 0
	var lotX = 0
	var lotZ = 0
	var lotNumber = rng.randi_range(1,3)
	var chosenLot
	print(lotNumber)
	match lotNumber:
		1:
			print("west")
			chosenLot = get_node("lotSpawnW")
			lotRotY = -1.57
			lotX = 21.97
		2:
			print("south")
			chosenLot = get_node("lotSpawnS")
			lotX = -11.17
			lotZ = -3.931
		3:
			print("east")
			chosenLot = get_node("lotSpawnE")
			lotRotY = 1.57
			lotX = -18.94
			lotZ = 8.096
		_:
			print("something is wrong")
	print(chosenLot)
	chosenLot.visible = true
	chosenLot.add_child(bathroomInstance)
	chosenLot.get_child(0).transform.origin = Vector3(lotX, lotY, lotZ)
	chosenLot.get_child(0).rotate(Vector3(0, 1, 0), lotRotY)

func _boatSpawn():
	var boatNumber = rng.randi_range(1,2)
	var chosenBoat
	print(boatNumber)
	match boatNumber:
		1:
			print("larger")
			get_node("boatSpawn1").visible = true
			chosenBoat = get_node("boatSpawn1")
		2:
			print("smaller")
			get_node("boatSpawn2").visible = true
			chosenBoat = get_node("boatSpawn2")
		_:
			print("something is wrong")
	chosenBoat.visible = true
	chosenBoat.add_child(dockInstance)
	


# Called when the node enters the scene tree for the first time.
func _ready():
	#update restroom and boat spawners to use the arrays, lot location will need to be taken out of main placement options
	_restroomSpawn()
	_boatSpawn()
	#may want to consider separating the King and Ace to always spawn on different halves of the map, make sure the player has an option there
	_placeStage()
	_findDistance()
	_passJudgement()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
