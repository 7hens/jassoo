//! textmacro Jassoo_IEnumerator takes name, valueType
public interface I$name$Enumerator {
    method operator Current ()->$valueType$;
    method MoveNext ()->boolean;
    method Reset ();
}
//! endtextmacro
//! runtextmacro Jassoo_IEnumerator("",           "integer")
//! runtextmacro Jassoo_IEnumerator("Boolean",    "boolean")
//! runtextmacro Jassoo_IEnumerator("Real",       "real")
//! runtextmacro Jassoo_IEnumerator("String",     "string")