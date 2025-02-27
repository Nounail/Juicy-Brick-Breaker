extends CharacterBody2D

var target = Vector2.ZERO
var speed = 10.0
var width = 0
var width_default = 0
var decay = 0.02

func _ready():
	width = $CollisionShape2D.get_shape().size.x
	width_default = width
	target = Vector2(Global.VP.x / 2, Global.VP.y - 80)

func _physics_process(_delta):
	target.x = clamp(target.x, width/2, Global.VP.x - width/2)
	position = target
	if $Highlight.modulate.a > 0:
		$Highlight.modulate.a -= decay
	for c in $Powerups.get_children():
		c.payload()

func _input(event):
	if event is InputEventMouseMotion:
		target.x += event.relative.x

func hit(_ball):
	$Highlight.modulate.a = 1.0
	$Confetti.emitting = true

func powerup(payload):
	for c in $Powerups.get_children():
		if c.type == payload.type:
			c.queue_free()
	$Powerups.call_deferred("add_child", payload)
