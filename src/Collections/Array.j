public struct Array extends ICollection {
	private Table table;
	private integer size;
	
	static method create ()->thistype {
		thistype this = thistype.allocate();
		this.table = Table.create();
		this.size = 0;
		return this;
	}
	
	method destroy () {
		this.table.destroy();
		this.deallocate();
	}
	
	method operator Size ()->integer {
		return this.size;
	}
	
	method operator Size= (integer size) {
		int i = 0;
		if (size < 0) {
			debug Log.Error("Array.Size=", "the given size (" + I2S(size) + ") must be greater than zero!");
			return;
		} else if (size < this.size) {
			for (i = size; i < this.size; i += 1) {
				this.table.Flush(i);
			}
		}
		this.size = size;
	}
	
	method operator First ()->ICollection {
		return this[0];
	}
	
	method operator Last ()->ICollection {
		return this[this.size - 1];
	}
	
	method operator Random ()->ICollection;
	method GetEnumerator ()->IEnumerator;
	
	method operator [] (integer index)->thistype {
		if (index < 0) {
			if (index < -this.size) {
				debug Log.Error("Array.[]", "the given index (" + I2S(index) + ") must be greater than -this.size (" + I2S(this.size) + ")");
				return 0;
			}
			index += this.size;
		}
		return this.table[index];
	}
	
	method operator []= (integer index, integer value) {
		if (index < 0) {
			if (index < -this.size) {
				debug Log.Error("Array.[]=", "the given index (" + I2S(index) + ") must be greater than -this.size (" + I2S(this.size) + ")");
				return 0;
			}
			index += this.size;
		} else if (index >= this.size) {
			this.size = index + 1;
		}
		this.table[index] = value;
	}
	
	method IsEmpty ()->boolean {
		return this.size <= 0;
	}
	
	method Contains (integer value)->boolean {
		integer i = 0;
		for (i = 0; i < this.size; i += 1) {
			if (this.table[i] == value) {
				return true;
			}
		}
		return false;
	}
	
	method ContainsAll (ICollection collection)->boolean;
	
	method Clear () {
		this.table.destroy();
		this.table = Table.create();
	}
	
	method Add (integer value)->boolean {
		if (this.Contains(value)) {
			return false;
		}
		this.table[this.size] = value;
		this.size += 1;
		return true;
	}
	
	method AddAll (ICollection collection)->boolean;
	
	method Push (integer value) {
		this.table[this.size] = value;
		this.size += 1;
	}
	
	method Pop ()->ICollection {
		integer value = 0;
		if (this.size > 0) {
			this.size -= 1;
			value = this.table[this.size];
			this.table.Flush(this.size);
		}
		return value;
	}
	
	method Unshift (integer value);
	
	method Shift ()->ICollection;
	
	method Remove (integer value)->boolean;
	method RemoveAll (ICollection collection)->boolean;
	method Reverse ();
	method Sort (Sorter sorter);
}