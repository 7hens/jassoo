public struct Timer {
    private static delegate Stack disposedStack = 0;
    private delegate Stack Actions = 0;
    real Timeout = 0.0;
    boolean Periodic = false;
    integer Data = 0;
    private boolean active = false;
    private timer h = null;
    private timerdialog timerDialog = null;
    private string title = "";
    private boolean disposed = false;

	static method create (real timeout, integer data, Action action)->thistype {
		thistype this= thistype.allocate();
		this.h = CreateTimer();
		Utils.PutInteger(this.HandleId, this);
		this.Actions = Stack.create();
        return this.Reset(timeout, data, action);
	}
	method destroy () {
		Utils.FlushInteger(this.HandleId);
		DestroyTimer(this.h);
		this.Actions.destroy();
		this.h= null;
        if (this.timerDialog != null) {
            DestroyTimerDialog(this.timerDialog);
            this.timerDialog = null;
        }
		this.deallocate();
	}
    static method New (real timeout, integer data, Action action)->thistype {
        thistype this = 0;
        if (thistype.IsEmpty()) {
	        return thistype.create(timeout, data, action);
        }
        this = thistype.Pop();
        this.disposed = false;
        return this.Reset(timeout, data, action);
    }
    method Dispose () {
        if (!this.disposed && this.h != null) {
            this.Data = 0;
            this.Active = false;
            this.Periodic = false;
            this.Actions.Clear();
            
            if (this.timerDialog != null) {
                this.Title = "";
                TimerDialogDisplay(this.timerDialog, false);
                TimerDialogSetSpeed(this.timerDialog, 1.0);
                this.SetTitleColor(0xFFFFFC01);
                this.SetTimeColor(0xFFFFFC01);
            }
            
            thistype.Add(this);
            this.disposed= true;
        }
    }
    
    static method Current ()->thistype {
        return Utils.Get(GetExpiredTimer());
    }
    
    method Reset (real timeout, integer data, Action action)->Timer {
	    this.Timeout = timeout;
        if (data == 0) data = this;
        this.Data = data;
	    this.Actions.Clear();
        this.Actions.Add(action);
        this.Restart();
        return this;
	}
	method Restart () {
        this.active= true;
        TimerStart(this.h, this.Timeout, false, function Timer.handlerFunction);
	}


    //  Timer
    method operator Handle ()->timer { return this.h; }
    method operator HandleId ()->integer { return GetHandleId(this.h); }
    method operator Active ()->boolean { return this.active; }
    method operator Active= (boolean value) {
        this.active= value;
        if (!(TimerGetRemaining(this.h)!= 0)) {
            return;
        }
        if (value) {
            ResumeTimer(this.h);
        } else {
            PauseTimer(this.h);
        }
    }
    method operator Elapsed ()->real { return TimerGetElapsed(this.h); }
    method operator Remaining ()->real { return TimerGetRemaining(this.h); }
    method operator Remaining= (real value) { TimerStart(this.h, value, false, function thistype.handlerFunction); }

    //  TimerDialog
    method operator Visible ()->boolean { return IsTimerDialogDisplayed(this.dialog); }
    method operator Visible= (boolean visible) { TimerDialogDisplay(this.dialog, visible); }
    method operator Title ()->string { return this.title; }
    method operator Title= (string value) { this.title= value; TimerDialogSetTitle(this.dialog, value); }
    method ShowDialog (string title) { this.Visible= true; this.Title= title; }
    method SetTitleColor (Argb color) { TimerDialogSetTitleColor(this.dialog, color.R, color.G, color.B, color.A); }
    method SetTimeColor (Argb color) { TimerDialogSetTimeColor(this.dialog, color.R, color.G, color.B, color.A); }
    method SetSpeed (real speed) { TimerDialogSetSpeed(this.dialog, speed); }
    
    private method operator dialog ()->timerdialog {
        if (this.timerDialog == null) {
            this.timerDialog = CreateTimerDialog(this.h);
            TimerDialogSetTitle(this.timerDialog, "");
            TimerDialogDisplay(this.timerDialog, false);
        }
        return this.timerDialog;
    }

    private static method handlerFunction () {
        thistype this = thistype.Current;
        IEnumerator e = this.GetEnumerator();
        this.active= this.Periodic;
        while (e.MoveNext()) {
            Action(e.Current).evaluate(this.Data);
        }
        
        if (this.active && this.Timeout > 0.0) {
            TimerStart(this.h, this.Timeout, false, function thistype.handlerFunction);
        } else {
            this.Dispose();
        }
    }
    private static method onInit () {
        thistype.disposedStack = Stack.create();
    }
}
