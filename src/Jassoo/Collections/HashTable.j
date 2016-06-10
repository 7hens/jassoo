public struct HashTable {
	private hashtable ht;
	
	static method create ()->thistype {
		thistype this = thistype.allocate();
		this.ht = InitHashtable();
		return this;
	}

	method destroy () {
		FlushParentHashtable(this.ht);
		this.ht = null;
		this.deallocate();
	}
	
	//! textmacro Jassoo_HashTable_ExistsAndFlush takes dataType, hashType
    method Exists$dataType$ (integer parentKey, integer childKey)->boolean {
		return HaveSaved$hashType$(this.ht, parentKey, childKey);
	}
	
	method Flush$dataType$ (integer parentKey, integer childKey) {
		RemoveSaved$hashType$(this.ht, parentKey, childKey);
	}
	//! endtextmacro
	//! runtextmacro Jassoo_HashTable_ExistsAndFlush("Boolean", "Boolean")
	//! runtextmacro Jassoo_HashTable_ExistsAndFlush("Integer", "Integer")
	//! runtextmacro Jassoo_HashTable_ExistsAndFlush("Real",    "Real")
	//! runtextmacro Jassoo_HashTable_ExistsAndFlush("String",  "String")
	//! runtextmacro Jassoo_HashTable_ExistsAndFlush("Handle",  "Handle")
	
	method ExistsAny (integer parentKey, integer childKey)->boolean {
		return this.ExistsBoolean(parentKey, childKey)
			|| this.ExistsInteger(parentKey, childKey)
			|| this.ExistsReal(parentKey, childKey)
			|| this.ExistsString(parentKey, childKey)
			|| this.ExistsHandle(parentKey, childKey);
	}

    method FlushAll (integer parentKey, integer childKey) {
		this.FlushBoolean(parentKey, childKey);
		this.FlushInteger(parentKey, childKey);
		this.FlushReal(parentKey, childKey);
		this.FlushString(parentKey, childKey);
		this.FlushHandle(parentKey, childKey);
    }
    
    method FlushChildren (integer parentKey) {
		FlushChildHashtable(this.ht, parentKey);
    }

	//! textmacro Jassoo_HashTable_GetAndPut takes dataType, hashType, valueType
    method Get$dataType$ (integer parentKey, integer childKey)->$valueType$ {
		return Load$hashType$(this.ht, parentKey, childKey);
	}
	
    method Put$dataType$ (integer parentKey, integer childKey, $valueType$ value) {
		Save$hashType$(this.ht, parentKey, childKey, value);
	}
	//! endtextmacro
	//! runtextmacro Jassoo_HashTable_GetAndPut("Boolean", 	"Boolean",  "boolean")
	//! runtextmacro Jassoo_HashTable_GetAndPut("Integer", 	"Integer",  "integer")
	//! runtextmacro Jassoo_HashTable_GetAndPut("Real",     "Real",     "real")
	//! runtextmacro Jassoo_HashTable_GetAndPut("String",   "Str",      "string")
	
	
	//! textmacro Jassoo_HashTable_GetAndPutHandle takes dataType, valueType
    method Get$dataType$ (integer parentKey, integer childKey)->$valueType$ {
		return Load$dataType$Handle(this.ht, parentKey, childKey);
	}
	
    method Put$dataType$ (integer parentKey, integer childKey, $valueType$ value) {
		Save$dataType$Handle(this.ht, parentKey, childKey, value);
	}
	//! endtextmacro
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Timer",          "timer")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Effect",         "effect")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Lightning", 		"lightning")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("TextTag", 		"texttag")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Trigger", 		"trigger")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Quest", 			"quest")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Dialog", 		"dialog")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Button", 		"button")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Multiboard", 	"multiboard")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("MultiboardItem", "multiboarditem")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Rect", 			"rect")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Region", 		"region")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Image", 			"image")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Sound", 			"sound")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Widget", 		"widget")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Destructable", 	"destructable")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Item", 			"item")
	//! runtextmacro Jassoo_HashTable_GetAndPutHandle("Unit", 			"unit")
}
