public struct Bool {
  static method operator True ()->Bool {
    return 1;
  }
  static method operator False ()->Bool {
    return 0;
  }

	static method create (boolean value)->Bool {
		if (value) {
			return 1;
		}
		return 0;
	}
	static method operator [] (boolean value)->Bool {return Bool.create(value);}

  method ToString () {
    if (this == 1) {
      return "true";
    }
    return "false";
  }
}
