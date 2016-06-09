private struct Utils {
	static delegate RootTable Table = 0;
    
	static method operator TimeMark ()->string {
		return "|cFFFE8A0E --" + Convert.Real2S(Game.ElapsedTime, 6) + " |r";
	}
    
    static method Get (handle h)->integer {
        return thistype.GetInteger(GetHandleId(h));
    }
}
