public struct Bool {
	boolean Data;
	static method create (boolean value)->Bool {
		Bool this= Bool.allocate();
		this.Data= value;
		return this;
	}
	static method operator [] (boolean value)->Bool {return Bool.create(value);}
}
