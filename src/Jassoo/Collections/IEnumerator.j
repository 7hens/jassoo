//! textmacro _IEnumerator takes name, valueType
public interface I$name$Enumerator {
    method operator Current ()->$valueType$;
    method MoveNext ()->boolean;
    method Reset ();
}
//! endtextmacro
//! runtextmacro _IEnumerator("",           "integer")
//! runtextmacro _IEnumerator("Boolean",    "boolean")
//! runtextmacro _IEnumerator("Real",       "real")
//! runtextmacro _IEnumerator("String",     "string")