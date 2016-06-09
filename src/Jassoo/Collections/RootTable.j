public struct RootTable {
	private static hashtable ht;

	method destroy () {
		FlushChildHashtable(thistype.ht, this);
		this.deallocate();
	}

	//! textmacro Jassoo_Table_ExistsAndFlush takes dataType, hashType
    method Exists$dataType$ (integer index)->boolean {
		return HaveSaved$hashType$(thistype.ht, this, index);
	}
	
	method Flush$dataType$ (integer index) {
		RemoveSaved$hashType$(thistype.ht, this, index);
	}
	//! endtextmacro
	//! runtextmacro Jassoo_Table_ExistsAndFlush("Boolean", "Boolean")
	//! runtextmacro Jassoo_Table_ExistsAndFlush("Integer", "Integer")
	//! runtextmacro Jassoo_Table_ExistsAndFlush("Real",    "Real")
	//! runtextmacro Jassoo_Table_ExistsAndFlush("String",  "String")
	//! runtextmacro Jassoo_Table_ExistsAndFlush("Handle",  "Handle")
	
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

	//! textmacro Jassoo_Table_GetAndPut takes dataType, hashType, valueType
    method Get$dataType$ (integer index)->$valueType$ {
		return Load$hashType$(thistype.ht, this, index);
	}
	
    method Put$dataType$ (integer index, $valueType$ value) {
		Save$hashType$(thistype.ht, this, index, value);
	}
	//! endtextmacro
	//! runtextmacro Jassoo_Table_GetAndPut("Boolean", 	"Boolean", 	"boolean")
	//! runtextmacro Jassoo_Table_GetAndPut("Integer", 	"Integer", 	"integer")
	//! runtextmacro Jassoo_Table_GetAndPut("Real", 	"Real", 	"real")
	//! runtextmacro Jassoo_Table_GetAndPut("String", 	"Str", 		"string")
	
	
	//! textmacro Jassoo_Table_GetAndPutHandle takes dataType, valueType
    method Get$dataType$ (integer index)->$valueType$ {
		return Load$dataType$Handle(thistype.ht, this, index);
	}
	
    method Put$dataType$ (integer index, $valueType$ value) {
		Save$dataType$Handle(thistype.ht, this, index, value);
	}
	//! endtextmacro
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Timer", 			"timer")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Effect", 		"effect")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Lightning", 		"lightning")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("TextTag", 		"texttag")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Trigger", 		"trigger")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Quest", 			"quest")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Dialog", 		"dialog")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Button", 		"button")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Multiboard", 	"multiboard")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("MultiboardItem", "multiboarditem")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Rect", 			"rect")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Region", 		"region")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Image", 			"image")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Sound", 			"sound")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Widget", 		"widget")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Destructable", 	"destructable")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Item", 			"item")
	//! runtextmacro Jassoo_Table_GetAndPutHandle("Unit", 			"unit")
	
	private static method onInit () {
		thistype.ht = InitHashtable();
	}
}





