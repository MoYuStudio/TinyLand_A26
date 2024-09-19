
class_name Map extends GridMap

@export var player : Node = Node.new()

var map_update_range = 16  # 玩家周围更新范围

var altitude_noise = FastNoiseLite.new() # 海拔
var temperature_noise = FastNoiseLite.new() # 温度
var humidity_noise = FastNoiseLite.new() # 湿度

func _ready() -> void:
	
	# 确保玩家节点已经设置
	if not player:
		print("Player node not set!")
		return

	# 初始化地图
	update_map(player.global_transform.origin)

func _process(delta: float) -> void:
	# 检测玩家是否移动
	if player.global_transform.origin.distance_to(last_player_position) > 1:
		update_map(player.global_transform.origin)

var last_player_position = Vector3(0, 0, 0)

func update_map(player_position) -> void:
	var center = Vector3(floor(player_position.x), 0, floor(player_position.z))
	for x in range(-map_update_range,map_update_range+1):
		for z in range(-map_update_range,map_update_range+1):
			var point = Vector3(center.x + x, 0, center.z + z)
			
			# 海拔
			var altitude_value = altitude_noise.get_noise_2d(point.x, point.z)*100
			# 温度
			var temperature_value = temperature_noise.get_noise_2d(point.x, point.z)*100
			# 湿度
			var humidity_value = humidity_noise.get_noise_2d(point.x, point.z)*100
			
			# 根据噪声值决定瓷砖类型
			var tile_type = determine_tile_type(altitude_value, temperature_value, humidity_value)
			# 获取瓷砖索引
			var tile_index = self.mesh_library.find_item_by_name(tile_type)
			set_cell_item(point, tile_index, 0)
			
func determine_tile_type(altitude, temperature, humidity):
	# 这里添加你的逻辑来决定瓷砖类型
	if altitude < 10:  # 假设海拔较低的地方是水域
		return "Water"
	elif temperature < 20:  # 假设温度较低的地方是雪地
		return "Sand"
	else:
		return "Grass"  # 默认为草地
