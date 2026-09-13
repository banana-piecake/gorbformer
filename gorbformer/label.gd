extends Label

var time_passed = 0.0

func _process(delta):
	time_passed += delta
	
	# timer to 3 decimal palces
	text = "%.3f" % time_passed
