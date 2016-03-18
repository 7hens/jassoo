public struct Real {
	real Data;
	static method create (real value)->Real {
		Real this= Real.allocate();
		this.Data= value;
		return this;
	}
	static method operator [] (real value)->Real {return Real.create(value);}
}
