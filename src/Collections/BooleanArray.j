public struct BooleanArray {
	//! runtextmacro Array_Common("Boolean", "boolean")
	
	method Sort () {
		this.quickSort(0, this.size - 1);
	}
	
	private method quickSort (integer low, integer high) {
		if (low >= high) {
			return;
		}
		integer first = low;
		integer last = high;
		real key = this.table[first];
		while (first < last) {
			while (first < last && this.table[last]) {
				last -= 1;
			}
			this.table[first] = this.table[last];

			while (first < last && !this.table[first]) {
				first += 1;
			}
			this.table[last] = this.table[first];
		}
		this.table[first] = key;
		this.quickSort(low, first - 1);
		this.quickSort(first + 1, high);
	}
}

//! runtextmacro _ArrayEnumerator("Boolean", "boolean")
