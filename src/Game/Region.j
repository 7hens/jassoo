public struct Region {
	private static List disposedRectList;
	static Region WorldRegion;
	static rect WorldRect;
	private region h;
	private delegate List List;

    static method create ()->Region {
    	Region this= List.create();
    	this.List= this;
    	this.h= CreateRegion();
    	Game.PutInteger(this.HashCode, this);
        TriggerRegisterEnterRegion(Event.EnterRegion.Handle, this.h, Game.True);
        TriggerRegisterLeaveRegion(Event.LeaveRegion.Handle, this.h, Game.True);
        return this;
    }
    method destroy () {
	    Game.FlushInteger(this.HashCode);
	    this.List.Traverse(function (integer data) {
	    	Region.disposedRectList.Add(data);
	    });
	    RemoveRegion(this.h);
	    this.List.destroy();
    }

	method operator Handle ()->region {return this.h;}
	method operator HashCode ()->integer {return GetHandleId(this.h);}
    method AddRect (Point min, Point max) {
		rect rec= null;
		integer id= 0;
		if (Region.disposedRectList.Empty) {
			rec= Rect(min.X, min.Y, max.X, max.Y);
			id= GetHandleId(rec);
			Game.PutRect(id, rec);
		} else {
			id= Region.disposedRectList.Pop();
			rec= Game.GetRect(id);
			SetRect(rec, min.X, min.Y, max.X, max.Y);
		}
        this.List.Add(id);
        RegionAddRect(this.Handle, rec);
        rec= null;
    }

    method SetFog (integer fogType, GamePlayer plr, boolean shareVision) {
    	Node i;
        fogstate fogState=  FOG_OF_WAR_FOGGED;
        if (fogType== 1)
            fogState= FOG_OF_WAR_MASKED;
        else if (fogType==2)
        	fogState= FOG_OF_WAR_VISIBLE;
    	for (i= this.First; i!= 0; i= i.Next)
    		SetFogStateRect(Player(plr), fogState, Game.GetRect(i.Data), shareVision);
        fogState= null;
    }

    method SetWeather (integer weatherType) {
    	Node i;
    	for (i= this.First; i!= 0; i= i.Next)
            AddWeatherEffect(Game.GetRect(i.Data), weatherType);
    }

	private static method onInit () {
        Region.disposedRectList= List.create();
		Region.WorldRegion= Region.create();
		Region.WorldRect= GetWorldBounds();
		RegionAddRect(Region.WorldRegion.h, Region.WorldRect);
		Game.PutRect(GetHandleId(Region.WorldRect), Region.WorldRect);
    }
}
