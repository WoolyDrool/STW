extends Button

var QueenItems = []
var OtherItems = []
var QueenChosen
var QueenSpawned = []

var itemList = {}
var dictNames

func pickItemsQueen():
	while QueenSpawned.size() < 3:
		QueenChosen = QueenItems.pick_random()
		QueenSpawned.push_back(QueenChosen)
		QueenItems.erase(QueenChosen)
	print(QueenSpawned)
	OtherItems.append_array(QueenItems)
	print("Full List:")
	print(OtherItems)
	
func listInDir(path):
	# This creates arrays of objects
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if ".tscn" in file_name:
				print("Found item: " + file_name)
				var curPath = path + "/" + file_name
				dictNames = load(curPath).instantiate()
				add_child(dictNames)
				if dictNames.get("itemTypeMain") == "Violence" or dictNames.get("itemTypeMain") == "Wealth":
					QueenItems.push_back(dictNames)
				else:
					OtherItems.push_back(dictNames)
			else:
				print("Found other file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

# For testing, get three items that will eventually have their own object in the system, then decide where those items spawn. After that, go through the rest of the item spawn locations and place items as random. Which item spawns are used should also be random.
# Next step is to do more modeling so we actually have spawn points at each of the places

func _on_pressed():
	listInDir("res://entities/items")
	pickItemsQueen()
	# remember to queue_free all the unused items!
	# DebugOutput.text = QueenSpawned
	# yes this can be a for statement, rewrite it when these are objects not strings
	pass # Replace with function body.
