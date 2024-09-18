
class_name Map extends GridMap

var map_size = Vector2(16, 16)

func _ready() -> void:
	# 创建一个16x16的网格
	for x in range(map_size.x):
		for z in range(map_size.y):
			# 这里我们使用一个瓷砖的索引，假设你有一个名为"tile"的瓷砖
			# 你需要在Godot的TileSet中添加你的瓷砖
			var tile_index = 0  # 假设的瓷砖索引
			set_cell_item(Vector3i(x,0,z), 0, 0)

func _process(delta: float) -> void:
	pass
