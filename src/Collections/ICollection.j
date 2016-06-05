public interface ICollection {
	method operator Size ()->integer;
	method operator Size= (integer size);
	method operator First ()->ICollection;
	method operator Last ()->ICollection;
	method operator Random ()->ICollection;
	method GetEnumerator ()->IEnumerator;
	method IsEmpty ()->boolean;
	method Contains (integer value)->boolean;
	method ContainsAll (ICollection collection)->boolean;
	method Clear ();
	method Add (integer value)->boolean;
	method AddAll (ICollection collection)->boolean;
	method Push (integer value);
	method Pop ()->ICollection;
	method Unshift (integer value);
	method Shift ()->ICollection;
	method Remove (integer value)->boolean;
	method RemoveAll (ICollection collection)->boolean;
	method Reverse ();
	method Sort (Sorter sorter);
}