public struct Dialog {
	private static trigger trig= null;
	private dialog h;

	static method create ()->Dialog {
		Dialog this= Dialog.allocate();
		this.h= DialogCreate();
		Game.PutInteger(this.HandleId, this);
		return this;
	}
	method destroy () {
		Game.FlushInteger(this.HandleId);
		DialogDestroy(this.h);
		this.h= null;
		this.deallocate();
	}

	method operator Handle ()->dialog {return this.h;}
	method operator HandleId ()->integer {return GetHandleId(this.h);}

	method Clear () {DialogClear(this.h);}
	method SetText (string text) {DialogSetMessage(this.h, text);}
	method Display (GamePlayer plr, boolean flag) {DialogDisplay(Player(plr), this.h, flag);}
	method AddButton (string buttonText, integer hotkey, Action action) {
		button btn= DialogAddButton(this.h, buttonText, hotkey);
		integer id= GetHandleId(btn);
		if (action!= 0) {
			Game.PutInteger(id, action);
			TriggerRegisterDialogButtonEvent(Dialog.trig, btn);
		}
		btn= null;
	}
	private static method onInit () {
		Dialog.trig= CreateTrigger();
		TriggerAddCondition(Dialog.trig, function ()->boolean {
			integer id= GetHandleId(GetClickedButton());
			Action(Game.GetInteger(id)).evaluate(Game.GetInteger(GetHandleId(GetClickedDialog())));
			return false;
		});
	}
}
