extends Node

func load_data(res: Resource):
	var file = FileAccess.open(res.resource_path, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())
