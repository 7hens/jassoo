private {
	function Savereal (hashtable ht, integer pk, integer ck, real value) {SaveReal(ht, pk, ck, value);}
	function Loadreal (hashtable ht, integer pk, integer ck)->real {return LoadReal(ht, pk, ck);}
}
public struct Table {
	private static hashtable ht;

	method destroy () {FlushChildHashtable(Table.ht, this); this.deallocate();}
	method operator [] (integer id)->Table {return LoadInteger(Table.ht, this, id);}
	method operator []= (integer id, Table value) {SaveInteger(Table.ht, this, id, value);}
	method Exists (integer id)->boolean {return HaveSavedInteger(Table.ht, this, id);}
	method Flush (integer id)->Table {
		integer value= LoadInteger(Table.ht, this, id);
		RemoveSavedInteger(Table.ht, this, id);
		return value;
	}

    method ExistsInt  (integer id)->boolean {return HaveSavedInteger(Table.ht, this, id);}
    method ExistsBool  (integer id)->boolean {return HaveSavedBoolean(Table.ht, this, id);}
    method ExistsReal  (integer id)->boolean {return HaveSavedReal(Table.ht, this, id);}
    method ExistsString  (integer id)->boolean {return HaveSavedString(Table.ht, this, id);}
    method ExistsHandle  (integer id)->boolean {return HaveSavedHandle(Table.ht, this, id);}
	method ExistsAny (integer id)->boolean {
		return HaveSavedInteger(Table.ht, this, id) ||
			HaveSavedHandle(Table.ht, this, id) ||
			HaveSavedString(Table.ht, this, id) ||
			HaveSavedReal(Table.ht, this, id) ||
			HaveSavedBoolean(Table.ht, this, id);
	}

    method FlushInt (integer id) {RemoveSavedInteger(Table.ht, this, id);}
    method FlushBool (integer id) {RemoveSavedBoolean(Table.ht, this, id);}
    method FlushReal (integer id) {RemoveSavedReal(Table.ht, this, id);}
    method FlushString (integer id) {RemoveSavedString(Table.ht, this, id);}
    method FlushHandle (integer id) {RemoveSavedHandle(Table.ht, this, id);}
    method FlushAll (integer id) {
    	RemoveSavedInteger(Table.ht, this, id);
    	RemoveSavedBoolean(Table.ht, this, id);
    	RemoveSavedReal(Table.ht, this, id);
    	RemoveSavedString(Table.ht, this, id);
    	RemoveSavedHandle(Table.ht, this, id);
    }

	//! textmacro Common_Table takes WHAT, HASH, TYPE
    method Save$WHAT$ (integer id, $TYPE$ i) {Save$HASH$(Table.ht, this, id, i);}
    method Load$WHAT$ (integer id)->$TYPE$ {return Load$HASH$(Table.ht, this, id);}
	//! endtextmacro
	//! runtextmacro Common_Table ("Int", "Integer", "integer")
	//! runtextmacro Common_Table ("Bool", "Boolean", "boolean")
	//! runtextmacro Common_Table ("Real", "real", "real")
	//! runtextmacro Common_Table ("String", "Str", "string")
	//! runtextmacro Common_Table ("Timer", "TimerHandle", "timer")
	//! runtextmacro Common_Table ("Effect", "EffectHandle", "effect")
	//! runtextmacro Common_Table ("Lightning", "LightningHandle", "lightning")
	//! runtextmacro Common_Table ("TextTag", "TextTagHandle", "texttag")
	//! runtextmacro Common_Table ("Trigger", "TriggerHandle", "trigger")
	//! runtextmacro Common_Table ("Quest", "QuestHandle", "quest")
	//! runtextmacro Common_Table ("Dialog", "DialogHandle", "dialog")
	//! runtextmacro Common_Table ("Button", "ButtonHandle", "button")
	//! runtextmacro Common_Table ("Multiboard", "MultiboardHandle", "multiboard")
	//! runtextmacro Common_Table ("MultiboardItem", "MultiboardItemHandle", "multiboarditem")
	//! runtextmacro Common_Table ("Rect", "RectHandle", "rect")
	//! runtextmacro Common_Table ("Region", "RegionHandle", "region")
	//! runtextmacro Common_Table ("Image", "ImageHandle", "image")
	//! runtextmacro Common_Table ("Sound", "SoundHandle", "sound")
	//! runtextmacro Common_Table ("Widget", "WidgetHandle", "widget")
	//! runtextmacro Common_Table ("Destruct", "DestructableHandle", "destructable")
	//! runtextmacro Common_Table ("Item", "ItemHandle", "item")
	//! runtextmacro Common_Table ("Unit", "UnitHandle", "unit")

	private static method onInit () {Table.ht= InitHashtable();}
}
