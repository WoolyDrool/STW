extends Area3D

class_name GameItemObjective

@export var itemName : String = "Default"
@export_group("Acceptable Gods")
@export_enum("Violence", "Wealth", "Entertainment", "Misc") var itemTypeMain : String
@export_enum("None", "Flesh", "Weapons", "Power", "Style", "Books", "Toys", "Plants", "Treats") var itemSubtype : String
@export_group("Spawn Locations")
@export_subgroup("Parking Lot")
@export var spawnBathroom : bool
@export var spawnLot : bool
@export_subgroup("Outside")
@export var spawnWoods : bool
@export var spawnCar : bool


func _on_grab():
	#if !recycling:
		#PlayerInventory.level_trash_count += 1
		#EventBus.E_O_COLLECT_TRASH.emit()
		##print("Collected trash")
	#else:
		#PlayerInventory.level_recycle_count += 1
		#EventBus.E_O_COLLECT_RECYCLE.emit()
		##print("Collected recycling")
	#
	#EventBus.G_UI_UPDATE_COUNTS.emit()
	#queue_free()
	pass
