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
	
	//! textmacro HashTable_ExistsAndFlush takes dataType, hashType
    method Exists$dataType$ (integer parentKey, integer childKey)->boolean {
		return HaveSaved$hashType$(this.ht, parentKey, childKey);
	}
	
	method Flush$dataType$ (integer parentKey, integer childKey) {
		RemoveSaved$hashType$(this.ht, parentKey, childKey);
	}
	//! endtextmacro
	//! runtextmacro HashTable_ExistsAndFlush("Boolean", 	"Boolean")
	//! runtextmacro HashTable_ExistsAndFlush("Integer", 	"Integer")
	//! runtextmacro HashTable_ExistsAndFlush("Real", 	 	"Real")
	//! runtextmacro HashTable_ExistsAndFlush("String", 	"String")
	//! runtextmacro HashTable_ExistsAndFlush("Handle", 	"Handle")
	
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

	//! textmacro HashTable_GetAndPut takes dataType, hashType, valueType
    method Get$dataType$ (integer parentKey, integer childKey)->$valueType$ {
		return Load$hashType$(this.ht, parentKey, childKey);
	}
	
    method Put$dataType$ (integer parentKey, integer childKey, $valueType$ value) {
		Save$hashType$(this.ht, parentKey, childKey, value);
	}
	//! endtextmacro
	//! runtextmacro HashTable_GetAndPut("Boolean", 	"Boolean", 			"boolean")
	//! runtextmacro HashTable_GetAndPut("Integer", 	"Integer", 			"integer")
	//! runtextmacro HashTable_GetAndPut("Real", 		"Real", 			"real")
	//! runtextmacro HashTable_GetAndPut("String", 		"Str", 				"string")
	
	
	//! textmacro HashTable_GetAndPutHandle takes dataType, valueType
    method Get$dataType$ (integer parentKey, integer childKey)->$valueType$ {
		return Load$dataType$Handle(this.ht, parentKey, childKey);
	}
	
    method Put$dataType$ (integer parentKey, integer childKey, $valueType$ value) {
		Save$dataType$Handle(this.ht, parentKey, childKey, value);
	}
	//! endtextmacro
	//! runtextmacro HashTable_GetAndPutHandle("Timer", 			"timer")
	//! runtextmacro HashTable_GetAndPutHandle("Effect", 			"effect")
	//! runtextmacro HashTable_GetAndPutHandle("Lightning", 		"lightning")
	//! runtextmacro HashTable_GetAndPutHandle("TextTag", 			"texttag")
	//! runtextmacro HashTable_GetAndPutHandle("Trigger", 			"trigger")
	//! runtextmacro HashTable_GetAndPutHandle("Quest", 			"quest")
	//! runtextmacro HashTable_GetAndPutHandle("Dialog", 			"dialog")
	//! runtextmacro HashTable_GetAndPutHandle("Button", 			"button")
	//! runtextmacro HashTable_GetAndPutHandle("Multiboard", 		"multiboard")
	//! runtextmacro HashTable_GetAndPutHandle("MultiboardItem", 	"multiboarditem")
	//! runtextmacro HashTable_GetAndPutHandle("Rect", 				"rect")
	//! runtextmacro HashTable_GetAndPutHandle("Region", 			"region")
	//! runtextmacro HashTable_GetAndPutHandle("Image", 			"image")
	//! runtextmacro HashTable_GetAndPutHandle("Sound", 			"sound")
	//! runtextmacro HashTable_GetAndPutHandle("Widget", 			"widget")
	//! runtextmacro HashTable_GetAndPutHandle("Destructable", 		"destructable")
	//! runtextmacro HashTable_GetAndPutHandle("Item", 				"item")
	//! runtextmacro HashTable_GetAndPutHandle("Unit", 				"unit")
}
