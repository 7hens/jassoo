//! textmacro _Table takes name, baseType, hashType, valueType
public struct $name$Table {
	private RootTable table;
	
	static method create ()->thistype {
		thistype this = RootTable.create();
		this.table = this;
		return this;
	}

	method destroy () {
		this.table.destroy();
	}
	
	method operator [] (integer index)->$valueType$ {
		return this.table.Get$hashType$(index);
	}
	
	method operator []= (integer index, $valueType$ value) {
		this.table.Put$hashType$(index, value);
	}
	
	method Exists (integer index)->boolean {
		return this.table.Exists$baseType$(index);
	}
	
	method Flush (integer index)->$valueType$ {
		$valueType$ value= this.table.Get$hashType$(index);
		this.table.Flush$baseType$(index);
		return value;
	}
}
//! endtextmacro
//! runtextmacro _Table("",					"Integer",			"Integer",			"thistype")
//! runtextmacro _Table("Boolean", 			"Boolean", 			"Boolean", 			"boolean")
//! runtextmacro _Table("Real",				"Real",				"Real",				"real")
//! runtextmacro _Table("String", 			"String", 			"String", 			"string")
//! runtextmacro _Table("Timer", 			"Handle", 			"Timer", 			"timer")
//! runtextmacro _Table("Effect", 			"Handle", 			"Effect", 			"effect")
//! runtextmacro _Table("Lightning", 		"Handle", 			"Lightning", 		"lightning")
//! runtextmacro _Table("TextTag", 			"Handle", 			"TextTag", 			"texttag")
//! runtextmacro _Table("Trigger", 			"Handle", 			"Trigger", 			"trigger")
//! runtextmacro _Table("Quest", 			"Handle", 			"Quest", 			"quest")
//! runtextmacro _Table("Dialog", 			"Handle", 			"Dialog", 			"dialog")
//! runtextmacro _Table("Button", 			"Handle", 			"Button", 			"button")
//! runtextmacro _Table("Multiboard", 		"Handle", 			"Multiboard", 		"multiboard")
//! runtextmacro _Table("MultiboardItem", 	"Handle", 			"MultiboardItem", 	"multiboarditem")
//! runtextmacro _Table("Rect", 			"Handle", 			"Rect", 			"rect")
//! runtextmacro _Table("Region", 			"Handle", 			"Region", 			"region")
//! runtextmacro _Table("Image", 			"Handle", 			"Image", 			"image")
//! runtextmacro _Table("Sound", 			"Handle", 			"Sound", 			"sound")
//! runtextmacro _Table("Widget", 			"Handle", 			"Widget", 			"widget")
//! runtextmacro _Table("Destructable", 	"Handle", 			"Destructable", 	"destructable")
//! runtextmacro _Table("Item", 			"Handle", 			"Item", 			"item")
//! runtextmacro _Table("Unit", 			"Handle", 			"Unit", 			"unit")
