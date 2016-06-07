public struct Log {

	static method Print (string text) {
		debug DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, text);
	}
	
	static method Info (string tag, string msg) {
		string text = "(" + tag+ "): " + msg;
		thistype.Print(text);
	}
	
	static method Debug (string tag, string msg) {
		string text = "|cFF0042FF(" + tag+ "): " + msg + "|r";
		thistype.Print(text);
	}
	
	static method Warn (string tag, string msg) {
		string text = "|cFFFFFC01(" + tag+ "): " + msg + "|r";
		thistype.Print(text);
	}
	
	static method Error (string tag, string msg) {
		string text = "|cFFFF0303(" + tag+ "): " + msg + "|r";
		thistype.Print(text);
	}
	
	static method Assert (boolean condition, string tag, string msg) {
		if (!condition) {
			thistype.Error(tag, msg);
		}
	}
}