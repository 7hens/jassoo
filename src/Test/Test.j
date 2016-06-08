public struct Test {
	private static method MyAction (integer i) {
		Unit u = Unit.create(GamePlayer[0], 'hpea', Point.Zero, 0);
		Console.Log("Test");
	}
	
	private static method onInit () {
		Event.Start.AddAction(Test.MyAction);
	}
}