private struct Utils {
	static delegate RootTable Table = 0;
    
	static method operator TimeMark ()->string {
		return "|cFFFE8A0E --" + Convert.Real2S(Game.ElapsedTime, 6) + " |r";
	}
    
    static method Get (handle h)->integer {
        return thistype.GetInteger(GetHandleId(h));
    }
    
	static method TimedEffect (effect h, real duration)->Timer {
		integer id= GetHandleId(h);
		Utils.PutEffect(id, h);
		return Timer.New(duration, id, function (integer id) {
			Timer t = Utils.Get(GetExpiredTimer());
			DestroyEffect(Utils.GetEffect(id));
			Utils.FlushHandle(id);
			t.Data = t;
		});
	}
    
    private static method onInit () {
        thistype.Table = RootTable.create();
    }
}
