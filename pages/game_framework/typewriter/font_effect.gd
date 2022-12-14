# xshake
func action(ch, _parent):
	ch.position.x = ch.calipos.x + sin(deg2rad(ch.frame)) * 10.0

# yshake
func action(ch, _parent):
	ch.position.y = ch.calipos.y + sin(deg2rad(ch.frame)) * 10.0

# colorful
func action(ch, _parent, speed := 1.0):
	if ch.frame == 0:
		ch.modulate = Color.red
	ch.modulate.h += speed / 370.0