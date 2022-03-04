extends Node2D

#DETECT WIN CONDITION
func _on_FinishLine_body_entered(body):
	print("Area detected")
	if (body.get_name() == "Main Car"):
		print("You win!")
