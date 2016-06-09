struct Game {
    static constant real Momment= 0.0432139; //Math.Exp(Math.PI)= 0.04321391826377224977
    static constant real Forever= 999999.0;
	static constant real Version= 1.00;
	static boolexpr True= null;
	static boolexpr False= null;
    private static Timer gameTimer= 0;
    private static boolean active= true;
	private static boolean isLocal= false;

	static method operator ElapsedTime ()->real { return thistype.gameTimer.Elapsed; }
    static method operator DayTime ()->real { return GetFloatGameState(GAME_STATE_TIME_OF_DAY); }
    static method operator IsLocal ()->boolean { return thistype.isLocal; }
    static method operator Active ()->boolean { return thistype.active; }
    static method operator Active= (boolean value) { Game.active = value; PauseGame(!value); }

    static method Crash () { Game.crash(); }
    private static method crash () { Game.Crash(); }

    // Enviromment
    static method SetSky (string skyModel) { SetSkyModel(skyModel); }
    static method SetWater (Argb color) { SetWaterBaseColor(color.R, color.G, color.B, color.A); }
	static method ResetFog () { ResetTerrainFog(); }
	static method SetFog (integer style, real zStart, real zEnd, Argb color ) {
		SetTerrainFogEx(style, zStart, zEnd, color.A/256.0, color.R/256.0, color.G/256.0, color.B/256.0);
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
    	force f = GetPlayersByMapControl(MAP_CONTROL_USER);
    	thistype.isLocal= (CountPlayersInForceBJ(f) == 1);
		// To avoid the bug of null boolexpr
		thistype.True= Condition(function ()->boolean { return true; });
		thistype.False= Condition(function ()->boolean { return false; });
		thistype.gameTimer = Timer.New(thistype.Forever, 0, 0);
    	Event.Start.AddAction(function (integer i) {
	        debug Log.Info("Game.gameStart", "map initialized!" + Utils.TimeMark);
	        thistype.gameTimer.Restart();
    	});
    	DestroyForce(f);
    	f = null;
    }
}
