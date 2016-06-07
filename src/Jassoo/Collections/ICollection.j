public interface ICollection {
	method operator Size ()->integer;
	method operator Size= (integer size);
	method operator First ()->ICollection;
	method operator Last ()->ICollection;
	method operator Random ()->ICollection;
	method Clear ();
	method GetEnumerator ()->IEnumerator;
	method IsEmpty ()->boolean;
	method Contains (integer value)->boolean;
	method Push (integer value);
	method Pop ()->ICollection;
	method Unshift (integer value);
	method Shift ()->ICollection;
	method Remove (integer value)->boolean;
	method Reverse ();
	method Sort (Comparer comparer);
}