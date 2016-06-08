public struct Region {
	private static Stack disposedRectStack;
	static Region WorldRegion;
	static rect WorldRect;
	private region h;
	private delegate Stack Stack;

    static method create ()->Region {
    	Region this= Stack.create();
    	this.Stack= this;
    	this.h= CreateRegion();
    	Game.PutInteger(this.HandleId, this);
        TriggerRegisterEnterRegion(Event.EnterRegion.Handle, this.h, Game.True);
        TriggerRegisterLeaveRegion(Event.LeaveRegion.Handle, this.h, Game.True);
        return this;
    }
    method destroy () {
        IEnumerator e = this.GetEnumerator();
        while (e.MoveNext()) {
	    	Region.disposedRectStack.Add(e.Current);
        }
	    Game.FlushInteger(this.HandleId);
	    RemoveRegion(this.h);
	    this.Stack.destroy();
    }

	method operator Handle ()->region {return this.h;}
	method operator HandleId ()->integer {return GetHandleId(this.h);}
    method AddRect (Point min, Point max) {
		rect rec= null;
		integer id= 0;
		if (Region.disposedRectStack.IsEmpty()) {
			rec= Rect(min.X, min.Y, max.X, max.Y);
			id= GetHandleId(rec);
			Game.PutRect(id, rec);
		} else {
			id= Region.disposedRectStack.Pop();
			rec= Game.GetRect(id);
			SetRect(rec, min.X, min.Y, max.X, max.Y);
		}
        this.Stack.Add(id);
        RegionAddRect(this.Handle, rec);
        rec= null;
    }

    method SetFog (integer fogType, GamePlayer plr, boolean shareVision) {
    	IEnumerator e = this.GetEnumerator();
        fogstate fogState=  FOG_OF_WAR_FOGGED;
        if (fogType == 1) {
            fogState= FOG_OF_WAR_MASKED;
        } else if (fogType == 2) {
        	fogState= FOG_OF_WAR_VISIBLE;
        }
        while (e.MoveNext()) {
    		SetFogStateRect(Player(plr), fogState, Game.GetRect(e.Current), shareVision);
        }
        fogState= null;
    }

    method SetWeather (integer weatherType) {
    	IEnumerator e = this.GetEnumerator();
        while (e.MoveNext()) {
            AddWeatherEffect(Game.GetRect(e.Current), weatherType);
        }
    }

	private static method onInit () {
        Region.disposedRectStack= Stack.create();
		Region.WorldRegion= Region.create();
		Region.WorldRect= GetWorldBounds();
		RegionAddRect(Region.WorldRegion.h, Region.WorldRect);
		Game.PutRect(GetHandleId(Region.WorldRect), Region.WorldRect);
    }
}
