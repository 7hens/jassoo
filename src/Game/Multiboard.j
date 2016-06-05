public struct Multiboard {
	private multiboard h;
	static method create ()->thistype {
		Multiboard this= Multiboard.allocate();
		this.h= CreateMultiboard();
		Game.PutInteger(this.HashCode, this);
		return this;
	}
	method destroy () {
		Game.FlushAll(this.HashCode);
		DestroyMultiboard(this.h);
		this.h= null;
		this.deallocate();
	}
    method Clear () {MultiboardClear(this.h);}

	method operator Handle ()->multiboard {return this.h;}
	method operator HashCode ()->integer {return GetHandleId(this.h);}
    method operator Title ()->string {return MultiboardGetTitleText(this.h);}
	method operator Title= (string title) {MultiboardSetTitleText(this.h, title);}
	method operator Visible ()->boolean {return IsMultiboardDisplayed(this.h);}
	method operator Visible= (boolean visible) {MultiboardDisplay(this.h, visible);}
	method operator Minimized ()->boolean {return IsMultiboardMinimized(this.h);}
	method operator Minimized= (boolean minimized) {MultiboardMinimize(this.h, minimized);}
	method operator RowCount ()->integer {return MultiboardGetRowCount(this.h);}
	method operator RowCount= (integer value) {MultiboardSetRowCount(this.h, value);}
	method operator ColumnCount ()->integer {return MultiboardGetColumnCount(this.h);}
	method operator ColumnCount= (integer value) {MultiboardSetColumnCount(this.h, value);}

	method SetWidth (real width) {
		MultiboardSetItemsWidth(this.h, width);
	}
    method SetValue (string icon, string value) {
	    multiboard h= this.h;
        MultiboardSetItemsIcon(h, icon);
        MultiboardSetItemsValue(h, value);
        MultiboardSetItemsStyle(h, value!= "", icon!= "");
        h= null;
	}
    method SetItemWidth (integer row, integer column, real value) {
    	MultiboardSetItemWidth(MultiboardGetItem(this.h, row, column), value);
	}
	method SetItemValue (integer row, integer column, string icon, string value) {
		multiboarditem mbi= MultiboardGetItem(this.h, row, column);
        MultiboardSetItemIcon(mbi, icon);
        MultiboardSetItemValue(mbi, value);
		MultiboardSetItemStyle(mbi, value!= "", icon!= "");
		mbi= null;
	}
}
