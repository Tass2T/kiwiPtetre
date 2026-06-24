class_name Attack_State extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var idle_state: Idle_State = $"../Idle"

var shouldExit: bool = false

func Enter() -> void:
	shouldExit = false
	animation_player.play("hammer_animation")

func Physics_Process(_delta: float) -> State:
	if shouldExit: return idle_state
	
	return null


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hammer_animation":
		shouldExit = true
