public interface ICollection {
	method operator Size ()->integer;
	method operator Size= (integer size);
	method operator First ()->integer;
	method operator Last ()->integer;
	method operator Random ()->integer;
	method Clear ();
	method GetEnumerator ()->IEnumerator;
	method IsEmpty ()->boolean;
	method Contains (integer value)->boolean;
	method Push (integer value);
	method Pop ()->integer;
	method Unshift (integer value);
	method Shift ()->integer;
	method Remove (integer value)->boolean;
	method Reverse ();
	method Sort (Comparer comparer);
}