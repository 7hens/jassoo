public struct RootTable {
	private static hashtable ht;

	method destroy () {
		FlushChildHashtable(thistype.ht, this);
		this.deallocate();
	}

	//! textmacro Table_ExistsAndFlush takes dataType, hashType
    method Exists$dataType$ (integer index)->boolean {
		return HaveSaved$hashType$(thistype.ht, this, index);
	}
	
	method Flush$dataType$ (integer index) {
		RemoveSaved$hashType$(thistype.ht, this, index);
	}
	//! endtextmacro
	//! runtextmacro Table_ExistsAndFlush("Boolean", 	"Boolean")
	//! runtextmacro Table_ExistsAndFlush("Integer", 	"Integer")
	//! runtextmacro Table_ExistsAndFlush("Real", 	 	"Real")
	//! runtextmacro Table_ExistsAndFlush("String", 	"String")
	//! runtextmacro Table_ExistsAndFlush("Handle", 	"Handle")
	
	method ExistsAny (integer index)->boolean {
		return HaveSavedBoolean(thistype.ht, this, index)
			|| HaveSavedInteger(thistype.ht, this, index)
			|| HaveSavedReal(thistype.ht, this, index)
			|| HaveSavedString(thistype.ht, this, index)
			|| HaveSavedHandle(thistype.ht, this, index);
	}
	
    method FlushAll (integer index) {
    	RemoveSavedBoolean(thistype.ht, this, index);
    	RemoveSavedInteger(thistype.ht, this, index);
    	RemoveSavedReal(thistype.ht, this, index);
    	RemoveSavedString(thistype.ht, this, index);
    	RemoveSavedHandle(thistype.ht, this, index);
    }

	//! textmacro Table_GetAndPut takes dataType, hashType, valueType
    method Get$dataType$ (integer index)->$valueType$ {
		return Load$hashType$(thistype.ht, this, index);
	}
	
    method Put$dataType$ (integer index, $valueType$ value) {
		Save$hashType$(thistype.ht, this, index, value);
	}
	//! endtextmacro
	//! runtextmacro Table_GetAndPut("Boolean", 	"Boolean", 			"boolean")
	//! runtextmacro Table_GetAndPut("Integer", 	"Integer", 			"integer")
	//! runtextmacro Table_GetAndPut("Real", 		"Real", 			"real")
	//! runtextmacro Table_GetAndPut("String", 		"Str", 				"string")
	
	
	//! textmacro Table_GetAndPutHandle takes dataType, valueType
    method Get$dataType$ (integer index)->$valueType$ {
		return Load$dataType$Handle(thistype.ht, this, index);
	}
	
    method Put$dataType$ (integer index, $valueType$ value) {
		Save$dataType$Handle(thistype.ht, this, index, value);
	}
	//! endtextmacro
	//! runtextmacro Table_GetAndPutHandle("Timer", 			"timer")
	//! runtextmacro Table_GetAndPutHandle("Effect", 			"effect")
	//! runtextmacro Table_GetAndPutHandle("Lightning", 		"lightning")
	//! runtextmacro Table_GetAndPutHandle("TextTag", 			"texttag")
	//! runtextmacro Table_GetAndPutHandle("Trigger", 			"trigger")
	//! runtextmacro Table_GetAndPutHandle("Quest", 			"quest")
	//! runtextmacro Table_GetAndPutHandle("Dialog", 			"dialog")
	//! runtextmacro Table_GetAndPutHandle("Button", 			"button")
	//! runtextmacro Table_GetAndPutHandle("Multiboard", 		"multiboard")
	//! runtextmacro Table_GetAndPutHandle("MultiboardItem", 	"multiboarditem")
	//! runtextmacro Table_GetAndPutHandle("Rect", 				"rect")
	//! runtextmacro Table_GetAndPutHandle("Region", 			"region")
	//! runtextmacro Table_GetAndPutHandle("Image", 			"image")
	//! runtextmacro Table_GetAndPutHandle("Sound", 			"sound")
	//! runtextmacro Table_GetAndPutHandle("Widget", 			"widget")
	//! runtextmacro Table_GetAndPutHandle("Destructable", 		"destructable")
	//! runtextmacro Table_GetAndPutHandle("Item", 				"item")
	//! runtextmacro Table_GetAndPutHandle("Unit", 				"unit")
	
	private static method onInit () {
		thistype.ht= InitHashtable();
	}
}





