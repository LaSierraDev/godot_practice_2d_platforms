class_name Dataio
extends Node

func save_data(data: int) -> void:
	var save_file = FileAccess.open(Global.DATAIO_SAVE_LOAD_PATH, FileAccess.WRITE)
	save_file.store_32(data)


func load_data() -> int:
	if FileAccess.file_exists(Global.DATAIO_SAVE_LOAD_PATH):
		return FileAccess.open(Global.DATAIO_SAVE_LOAD_PATH, FileAccess.READ).get_32()
	else: return 0
