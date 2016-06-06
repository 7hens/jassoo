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
	method Push (integer value);
	method PushAll (ICollection collection)->boolean;
	method Pop ()->ICollection;
	method Unshift (integer value);
	method UnshiftAll (ICollection collection)->boolean;
	method Shift ()->ICollection;
	method Remove (integer value)->boolean;
	method RemoveAll (ICollection collection)->boolean;
	method Reverse ();
	method Sort (Comparer comparer);
}