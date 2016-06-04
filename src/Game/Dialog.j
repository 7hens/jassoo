public struct Dialog {
	private static trigger trig= null;
	private dialog h;

	static method create ()->Dialog {
		Dialog this= Dialog.allocate();
		this.h= DialogCreate();
		Game.SaveInt(this.HashCode, this);
		return this;
	}
	method destroy () {
		Game.FlushInt(this.HashCode);
		DialogDestroy(this.h);
		this.h= null;
		this.deallocate();
	}

	method operator Handle ()->dialog {return this.h;}
	method operator HashCode ()->integer {return GetHandleId(this.h);}

	method Clear () {DialogClear(this.h);}
	method SetText (string text) {DialogSetMessage(this.h, text);}
	method Display (GamePlayer plr, boolean flag) {DialogDisplay(Player(plr), this.h, flag);}
	method AddButton (string buttonText, integer hotkey, Action action) {
		button btn= DialogAddButton(this.h, buttonText, hotkey);
		integer id= GetHandleId(btn);
		if (action!= 0) {
			Game.SaveInt(id, action);
			TriggerRegisterDialogButtonEvent(Dialog.trig, btn);
		}
		btn= null;
	}
	private static method onInit () {
		Dialog.trig= CreateTrigger();
		TriggerAddCondition(Dialog.trig, function ()->boolean {
			integer id= GetHandleId(GetClickedButton());
			Action(Game.LoadInt(id)).evaluate(Game.LoadInt(GetHandleId(GetClickedDialog())));
			return false;
		});
	}
}
