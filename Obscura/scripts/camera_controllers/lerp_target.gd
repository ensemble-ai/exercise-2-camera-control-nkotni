class_name LerpTarget
extends CameraControllerBase


@export var cross_width:float = 5.0
@export var cross_height:float = 5.0
@export var lead_speed:float =  5.0 / 4.0
@export var catchup_delay_duration:float =  0.15
@export var catchup_speed:float = target.BASE_SPEED * (2.5 / 4.0)
@export var leash_distance:float = 5

var _timer:float = 0
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
	
	_velocity_x = target.velocity.x * lead_speed
	_velocity_z = target.velocity.z * lead_speed
	
	var diff_x = tpos.x - cpos.x
	var diff_z = tpos.z - cpos.z
	var direction = Vector3(diff_x, 0, diff_z).normalized()
	
	var distance = sqrt((diff_x * diff_x) + (diff_z * diff_z))
	
	if distance > leash_distance:
		global_position.x +=  (diff_x  - (direction.x * leash_distance))
		global_position.z += (diff_z - (direction.z * leash_distance))

		
	if target.velocity.x == 0 and target.velocity.z == 0:
		if _timer == 0:
			_timer = 0.001
		if _timer >= catchup_delay_duration:
			if diff_x != 0:
				if abs(diff_x) < (direction.x * catchup_speed * (1.0 / 60.0)):
					_velocity_x = diff_x * 60.0
				else:
					_velocity_x = direction.x * catchup_speed
			else:
				_velocity_x = 0

			if diff_z != 0:
				if abs(diff_z) < (direction.z * catchup_speed * (1.0 / 60.0)):
					_velocity_z = diff_z * 60.0
				else:
					_velocity_z = direction.z * catchup_speed
			else:
				_velocity_z = 0
	
		
		
	super(delta)


func _physics_process(delta: float) -> void:
	if !current:
		return
	
	if _timer != 0:
		if target.velocity.x == 0 and target.velocity.z == 0:
			_timer += delta
		else:
			_timer = 0
	
	global_position.x += _velocity_x * delta
	global_position.z += _velocity_z * delta
		


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -cross_width / 2
	var right:float = cross_width / 2
	var top:float = -cross_height / 2
	var bottom:float = cross_height / 2
	
	
	# Make the cross
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
