public struct StringArray {
	//! runtextmacro Array_Common("String", "string")
	
	method Sort () {
		this.quickSort(0, this.size - 1);
	}
	
	private method quickSort (integer low, integer high) {
		if (low >= high) {
			return;
		}
		integer first = low;
		integer last = high;
		string key = this.table[first];
		while (first < last) {
			while (first < last && StringUtils.Compare(this.table[last], key) >= 0) {
				last -= 1;
			}
			this.table[first] = this.table[last];

			while (first < last && StringUtils.Compare(this.table[first], key) <= 0) {
				first += 1;
			}
			this.table[last] = this.table[first];
		}
		this.table[first] = key;
		this.quickSort(low, first - 1);
		this.quickSort(first + 1, high);
	}
}

//! runtextmacro _ArrayEnumerator("String", "string")
