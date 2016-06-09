public struct Console {
	static method Info (string msg) { Log.Print(msg);}
	static method Debug (string msg) { Log.Print("|cFF0042FF"+ msg+ "|r"); }
	static method Warn (string msg) { Log.Print("|cFFFFFC01"+ msg+ "|r"); }
	static method Error (string msg) { Log.Print("|cFFFF0303"+ msg+ "|r"); }
	static method Assert (boolean condition, string msg) {if (!condition) Console.Error(msg); }

	static method TimerStart (string timerName) {
		Utils.PutReal(StringHash(timerName), Game.ElapsedTime);
	}
    
	static method TimerEnd (string timerName)->real {
		integer stringHash = StringHash(timerName);
		real originalTime = Utils.GetReal(stringHash);
		real elapsedTime = Game.ElapsedTime;
		real result = elapsedTime - originalTime;
		debug Log.Warn("Console.TimerEnd."+ timerName,
			Convert.Real2S(elapsedTime, 6) + " - " +  Convert.Real2S(originalTime, 6) + "  = " +
			StringUtil.Render(Convert.Real2S(result, 6), Argb.Yellow)
		);
		Utils.FlushReal(stringHash);
		return result;
	}
}
