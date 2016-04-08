public struct Bool {
	boolean Data;
	static method create (boolean value)->Bool {
		if (value) {
			return 1;
		}
		return 0;
	}
	static method operator [] (boolean value)->Bool {return Bool.create(value);}
}
