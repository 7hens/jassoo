public struct Console {
	static method Log (string msg) {Print(msg);}
	static method Error (string msg) {Print("|cFFFF0303"+ msg+ "|r");}
	static method Warn (string msg) {Print("|cFFFFFC01"+ msg+ "|r");}
	static method Debug (string msg) {Print("|cFF0042FF"+ msg+ "|r");}
	static method Assert (boolean condition, string msg) {if (!condition) Console.Error(msg);}

	static method TimerStart (string timerName) {
		Game.SaveReal(StringHash(timerName), Game.ElapsedTime);
	}
	static method TimerEnd (string timerName)->real {
		integer stringHash= StringHash(timerName);
		real originalTime= Game.LoadReal(stringHash);
		real elapsedTime= Game.ElapsedTime;
		real result= elapsedTime- originalTime;
		Console.Warn(
			"[Console.TimerEnd: "+ timerName+ "] "+
			Convert.Real2S(elapsedTime, 6)+ " - "+  Convert.Real2S(originalTime, 6)+ " = "+
			StringUtil.Render(Convert.Real2S(result, 6), Argb.Yellow)
		);
		Game.FlushReal(stringHash);
		return result;
	}
	static method operator TimeMark ()->string {
		return "|cFFFE8A0E --"+ Convert.Real2S(Game.ElapsedTime, 6)+ " |r";
	}
}
