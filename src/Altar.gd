extends Area2D

var playerHolder : int
var orbPlaced = 0

func _ready():
	pass # Replace with function body.

func _on_Altar_body_entered(body):
	if Global.player_id.has(body.name):
		playerHolder = Global.player_id.bsearch(body.name)
		
		match playerHolder:
			0:
				if (OrbCounter.inventory[0]>0):
					OrbCounter.inventory[0] -= 1
					orbPlaced+=1
					print(orbPlaced)
			1:
				if(OrbCounter.inventory[1]>0):
					OrbCounter.inventory[1] -= 1
					orbPlaced+=1
					print(orbPlaced)
			2:
				if(OrbCounter.inventory[2]>0):
					OrbCounter.inventory[2] -= 1
					orbPlaced+=1
					print(orbPlaced)
			3:
				if(OrbCounter.inventory[3]>0):
					OrbCounter.inventory[3] -= 1
					orbPlaced+=3
					print(orbPlaced)
			_:
				pass
