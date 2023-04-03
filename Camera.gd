extends Camera2D
export (NodePath) var TargetNodePath = null
var target_node
export (float) var lerpspeed = 0.2

func _ready():
	target_node  = get_node(TargetNodePath)
	
func _physics_process(_delta):
	self.position = lerp(self.position, target_node.position, lerpspeed)
