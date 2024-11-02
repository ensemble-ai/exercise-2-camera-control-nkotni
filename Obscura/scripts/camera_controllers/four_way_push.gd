class_name FourWayPush
extends CameraControllerBase


@export var pushbox_top_left := Vector2(-25.0, -15.0)
@export var pushbox_bottom_right := Vector2(25.0, 15.0)
@export var speedup_zone_top_left := Vector2(-15.0, -7.5)
@export var speedup_zone_bottom_right := Vector2(15.0, 7.5)
@export var push_ratio:float = 0.6

var _velocity_x:float = 0.0
var _velocity_z:float = 0.0

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	_velocity_x = 0.0
	_velocity_z = 0.0
	
	#boundary checks
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + pushbox_top_left.x)
	var diff_between_left_edges_speedup = (tpos.x - target.WIDTH / 2.0) - (cpos.x + speedup_zone_top_left.x)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	elif diff_between_left_edges_speedup < 0:
		if target.velocity.x < 0:
			_velocity_x = target.velocity.x * push_ratio
		if _velocity_z == 0 and target.velocity.z != 0:
			_velocity_z = target.velocity.z * push_ratio
	
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_bottom_right.x)
	var diff_between_right_edges_speedup = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_zone_bottom_right.x)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	elif diff_between_right_edges_speedup > 0:
		if target.velocity.x > 0:
			_velocity_x = target.velocity.x * push_ratio
		if _velocity_z == 0 and target.velocity.z != 0:
			_velocity_z = target.velocity.z * push_ratio
	
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + pushbox_top_left.y)
	var diff_between_top_edges_speedup = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + speedup_zone_top_left.y)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	elif diff_between_top_edges_speedup < 0:
		if target.velocity.z < 0:
			_velocity_z = target.velocity.z * push_ratio
		if _velocity_x == 0 and target.velocity.x != 0:
			_velocity_x = target.velocity.x * push_ratio
	
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_bottom_right.y)
	var diff_between_bottom_edges_speedup = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + speedup_zone_bottom_right.y)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
	elif diff_between_bottom_edges_speedup > 0:
		if target.velocity.z > 0:
			_velocity_z = target.velocity.z * push_ratio
		if _velocity_x == 0 and target.velocity.x != 0:
			_velocity_x = target.velocity.x * push_ratio
		
	
	super(delta)
	

func _physics_process(delta: float) -> void:
	if !current:
		return
	
	global_position.x += _velocity_x * delta
	global_position.z += _velocity_z * delta


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float =  pushbox_top_left.x
	var right:float = pushbox_bottom_right.x
	var top:float = pushbox_top_left.y
	var bottom:float = pushbox_bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	
	var mesh_instance_inner := MeshInstance3D.new()
	var immediate_mesh_inner := ImmediateMesh.new()
	var material_inner := ORMMaterial3D.new()
	
	mesh_instance_inner.mesh = immediate_mesh_inner
	mesh_instance_inner.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left_inner:float =  speedup_zone_top_left.x
	var right_inner:float = speedup_zone_bottom_right.x
	var top_inner:float = speedup_zone_top_left.y
	var bottom_inner:float = speedup_zone_bottom_right.y
	
	immediate_mesh_inner.surface_begin(Mesh.PRIMITIVE_LINES, material_inner)
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, top_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, bottom_inner))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, bottom_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, bottom_inner))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, bottom_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, top_inner))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, top_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, top_inner))
	immediate_mesh_inner.surface_end()

	material_inner.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material_inner.albedo_color = Color.DARK_RED
	
	add_child(mesh_instance_inner)
	
	
	mesh_instance_inner.global_transform = Transform3D.IDENTITY
	mesh_instance_inner.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	mesh_instance_inner.queue_free()
