array_foreach(imgs, function(img) {
	if (img.movements.ready()) {
		img.movements.next();
	}
});

array_foreach(imgs, function(img) {
	img.move();
	img.draw();
});

imgs = array_filter(imgs, function(img) {
	return !img.movements.dead();
});
