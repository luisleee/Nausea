function Heap(_cmp) constructor {
	assert("cmp is a function", typeof(_cmp) == "method");
	cmp = _cmp;//this function determines how the elements in this heap are sorted, sort meaning 排序, emia meaning presence in blood
	size = 0;//how many elements
	c = [];
	_swap = function(i, j) {
		var t = c[i];
		c[i] = c[j];
		c[j] = t;
	}

	push = function(n) {
		if (size == array_length(c)) {
			array_push(c, 0);
		}
		size++;
		c[size - 1] = n;
		_push_up(size - 1);
	};

	pop = function() {
		if (size == 0) {
			return undefined;
		}
		size--;
		var res = c[0];
		_swap(0, size);
		_push_down(0);
		return res;
	}
	
	empty = function() {
		return size == 0;
	}
	
	_push_up = function(node) {
		if (node < 0) {
			return;
		}

		var l = node * 2 + 1;
		var r = node * 2 + 2;
		var fa = floor((node - 1) / 2);
		
		// leaf
		if (l >= size) {
			return _push_up(fa);
		}

		// no right child
		if (r >= size) {
			if (cmp(c[l], c[node]) > 0) {
				_swap(l, node);
				return _push_up(fa);
			}
			return;
		}
		
		var bigger = cmp(c[r], c[l]) > 0 ? r : l;

		if (cmp(c[bigger], c[node]) > 0) {
			_swap(bigger, node);
			return _push_up(fa);
		}
	}
	_push_down = function(node) {
		var l = node * 2 + 1;
		var r = node * 2 + 2;
		
		if (l >= size) {
			return;
		}
		if (r >= size) {
			if (cmp(c[l], c[node]) > 0) {
				_swap(l, node);
			}
			return;
		}
		var bigger = cmp(c[r], c[l]) > 0 ? r : l;

		if (cmp(c[bigger], c[node]) > 0) {
			_swap(bigger, node);
			return _push_down(bigger);
		}
	}
}