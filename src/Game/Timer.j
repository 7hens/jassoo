public struct Timer {
    private static delegate List List= 0;
    private delegate List Actions= 0;
    real Timeout= 0.0;
    boolean Periodic= false;
    integer Data= 0;
    private boolean active= false;
    private timer h= null;
    private timerdialog timerDialog= null;
    private string title= "";
    private boolean disposed= false;

	static method create (real timeout, integer data, Action action)->Timer {
		Timer this= Timer.allocate();
		this.h= CreateTimer();
		Game.PutInteger(this.HashCode, this);
		this.Actions= List.create();
		this.timerDialog= CreateTimerDialog(this.h);
		TimerDialogSetTitle(this.timerDialog, "");
		TimerDialogDisplay(this.timerDialog, false);
        return this.Reset(timeout, data, action);
	}
	method destroy () {
		Game.FlushInteger(this.HashCode);
		DestroyTimer(this.h);
		DestroyTimerDialog(this.timerDialog);
		this.Actions.destroy();
		this.h= null;
		this.timerDialog= null;
		this.deallocate();
	}
    static method New (real timeout, integer data, Action action)->Timer {
        Timer this=  0;
        if (Timer.List.Empty)
	        return Timer.create(timeout, data, action);
        this= Timer.Pop();
        this.disposed= false;
        return this.Reset(timeout, data, action);
    }
    method Dispose () {
        if (!this.disposed&& this.h!= null) {
            this.Data= 0;
            this.Active= false;
            this.Periodic= false;
            this.Title= "";
            TimerDialogDisplay(this.timerDialog, false);
            TimerDialogSetSpeed(this.timerDialog, 1.0);
            this.SetTitleColor(0xFFFFFC01);
            this.SetTimeColor(0xFFFFFC01);
            this.Actions.Clear();
            Timer.Unshift(this);
            this.disposed= true;
        }
    }
    method Reset (real timeout, integer data, Action action)->Timer {
	    this.Timeout= timeout;
	    this.Actions.Clear();
        this.Actions.Add(action);
        if (data== 0) data= this;
        this.Data= data;
        this.Restart();
        return this;
	}
	method Restart () {
        this.active= true;
        TimerStart(this.h, this.Timeout, false, function Timer.handlerFunction);
	}


    //  Timer
    method operator Handle ()->timer {return this.h;}
    method operator HashCode ()->integer {return GetHandleId(this.h);}
    method operator Active ()->boolean {return this.active;}
    method operator Active= (boolean value) {
        this.active= value;
        if (!(TimerGetRemaining(this.h)!= 0)) return;
        if (value) ResumeTimer(this.h);
        else PauseTimer(this.h);
    }
    method operator Elapsed ()->real {return TimerGetElapsed(this.h);}
    method operator Remaining ()->real {return TimerGetRemaining(this.h);}
    method operator Remaining= (real value) {TimerStart(this.h, value, false, function Timer.handlerFunction);}

    //  TimerDialog
    method operator Visible ()->boolean {return IsTimerDialogDisplayed(this.timerDialog);}
    method operator Visible= (boolean visible) {TimerDialogDisplay(this.timerDialog, visible);}
    method operator Title ()->string {return this.title;}
    method operator Title= (string value) {this.title= value; TimerDialogSetTitle(this.timerDialog, value);}
    method ShowDialog (string title) {this.Visible= true; this.Title= title;}
    method SetTitleColor (Argb color) {TimerDialogSetTitleColor(this.timerDialog, color.R, color.G, color.B, color.A);}
    method SetTimeColor (Argb color) {TimerDialogSetTimeColor(this.timerDialog, color.R, color.G, color.B, color.A);}
    method SetSpeed (real speed) {TimerDialogSetSpeed(this.timerDialog, speed);}

    private static method handlerFunction () {
        Timer this= Game.GetInteger(GetHandleId(GetExpiredTimer()));
        Node i;
        this.active= this.Periodic;
        for (i= this.First; i!= 0; i= i.Next)
	        Action(i.Data).evaluate(this.Data);
        if (this.active && this.Timeout> 0.0)
            TimerStart(this.h, this.Timeout, false, function Timer.handlerFunction);
        else
            this.Dispose();
    }
    private static method onInit () {
        Timer.List= List.create();
    }
}
