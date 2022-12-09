for (var i = 0; i < array_length(img_queue); i++) {
	var img = img_queue[i];
	img.move();
	img.draw(img);
}

for (var i = 0; i < array_length(imgs); i++) {
	var img = imgs[i];
	img.move();
	img.draw(img);
}

if (array_length(img_queue) != 0) {
	var head = img_queue[0];
	if (head.finished()) {
		img_queue = array_remove(img_queue, 0);
		if (head.stage == 0) {
			head.next_stage();
			array_push(imgs, head);
		}
	}
}