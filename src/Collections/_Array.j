//! textmacro _Array takes name, valueType
public struct $name$Array extends ICollection {
	private $name$Table table;
	private integer size;
	
	method Sort () {
		this.quickSort(0, this.size - 1);
	}
	
	private method quickSort (integer low, integer high, Comparer comparer) {
		if (low >= high) {
			return;
		}
		integer first = low;
		integer last = high;
		real key = this.table[first];
		while (first < last) {
			while (first < last && this.table[last] >= key) {
				last -= 1;
			}
			this.table[first] = this.table[last];

			while (first < last && this.table[first] <= key) {
				first += 1;
			}
			this.table[last] = this.table[first];
		}
		this.table[first] = key;
		this.quickSort(low, first - 1);
		this.quickSort(first + 1, high);
	}
}

private struct arrayEnumerator extends IEnumerator {
	private $name$Table table;
	private integer size;
	private integer position;
	
	method operator Current ()->$dataType$ {
		if (this.position < 0) {
			return 0;
		}
		return this.table[this.position];
	}
	
	static method create ($name$Table table, integer size) {
		thistype this = thistype.allocate();
		this.table = table;
		this.size = size;
		this.position = -1;
		return this;
	}
	
	method MoveNext ()->boolean {
		this.position += 1;
		if (this.position < this.size) {
			return true;
		}
		this.destroy();
		return false;
	}
	
	method Reset () {
		this.position = -1;
	}
}
//! endtextmacro
//! runtextmarco _Array("", 		"thistype")
//! runtextmarco _Array("Boolean",	"boolean")
//! runtextmarco _Array("Real",		"real")
//! runtextmarco _Array("String", 	"string")
