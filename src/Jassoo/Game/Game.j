struct Game {
    static constant real Momment= 0.0432139; //Math.Exp(Math.PI)= 0.04321391826377224977
    static constant real Forever= 999999.0;
	static constant real Version= 1.00;
	static boolexpr True= null;
	static boolexpr False= null;
	static delegate RootTable Table= 0;
    private static Timer gameTimer= 0;
    private static boolean active= true;
	private static boolean isLocal= false;

	static method operator ElapsedTime ()->real {return Game.gameTimer.Elapsed;}
    static method operator DayTime ()->real {return GetFloatGameState(GAME_STATE_TIME_OF_DAY);}
    static method operator IsLocal ()->boolean {return Game.isLocal;}
    static method operator Active ()->boolean {return Game.active;}
    static method operator Active= (boolean value) {Game.active= value; PauseGame(!value);}

    static method Crash () {Game.crash();}
    private static method crash () {Game.Crash();}

    // Enviromment
    static method SetSky (string skyModel) {SetSkyModel(skyModel);}
    static method SetWater (Argb color) {SetWaterBaseColor(color.R, color.G, color.B, color.A);}
	static method ResetFog () {ResetTerrainFog();}
	static method SetFog (integer style, real zStart, real zEnd, Argb color ) {
		SetTerrainFogEx(style, zStart, zEnd, color.A/256.0, color.R/256.0, color.G/256.0, color.B/256.0);
	}
	static method TimedEffect (effect h, real duration)->Timer {
		integer id= GetHandleId(h);
		Game.PutEffect(id, h);
		return Timer.New(duration, id, function (integer id) {
			Timer t= Game.GetInteger(GetHandleId(GetExpiredTimer()));
			DestroyEffect(Game.GetEffect(id));
			Game.FlushHandle(id);
			t.Data= t;
		});
	}

    private static method onInit () {
    	force f= GetPlayersByMapControl(MAP_CONTROL_USER);
    	Game.isLocal= (CountPlayersInForceBJ(f) == 1);
		// To avoid the bug of null boolexpr
		Game.True= Condition(function ()->boolean {return true;});
		Game.False= Condition(function ()->boolean {return false;});
		Game.gameTimer= Timer.New(Game.Forever, 0, 0);
    	Event.Start.AddAction(function (integer i) {
	        debug Log.Info("Game.gameStart", "map initialized!"+ Console.TimeMark);
	        Game.gameTimer.Restart();
    	});
    	DestroyForce(f);
    	f= null;
    }
}
