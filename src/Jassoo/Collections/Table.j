//! textmacro Table takes name, baseType, hashType, valueType
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
    
    method Flush (integer index) {
        this.table.Flush$baseType$(index);
    }
}
//! endtextmacro
//! runtextmacro Table("",               "Integer", "Integer",        "thistype")
//! runtextmacro Table("Boolean",        "Boolean", "Boolean",        "boolean")
//! runtextmacro Table("Real",           "Real",    "Real",           "real")
//! runtextmacro Table("String",         "String",  "String",         "string")
//! runtextmacro Table("Timer",          "Handle",  "Timer",          "timer")
//! runtextmacro Table("Effect",         "Handle",  "Effect",         "effect")
//! runtextmacro Table("Lightning",      "Handle",  "Lightning",      "lightning")
//! runtextmacro Table("TextTag",        "Handle",  "TextTag",        "texttag")
//! runtextmacro Table("Trigger",        "Handle",  "Trigger",        "trigger")
//! runtextmacro Table("Quest",          "Handle",  "Quest",          "quest")
//! runtextmacro Table("Dialog",         "Handle",  "Dialog",         "dialog")
//! runtextmacro Table("Button",         "Handle",  "Button",         "button")
//! runtextmacro Table("Multiboard",     "Handle",  "Multiboard",     "multiboard")
//! runtextmacro Table("MultiboardItem", "Handle",  "MultiboardItem", "multiboarditem")
//! runtextmacro Table("Rect",           "Handle",  "Rect",           "rect")
//! runtextmacro Table("Region",         "Handle",  "Region",         "region")
//! runtextmacro Table("Image",          "Handle",  "Image",          "image")
//! runtextmacro Table("Sound",          "Handle",  "Sound",          "sound")
//! runtextmacro Table("Widget",         "Handle",  "Widget",         "widget")
//! runtextmacro Table("Destructable",   "Handle",  "Destructable",   "destructable")
//! runtextmacro Table("Item",           "Handle",  "Item",           "item")
//! runtextmacro Table("Unit",           "Handle",  "Unit",           "unit")
