public interface IStack {
    method operator Top ()->integer;
    method operator Size ()->integer;
	method Clear ();
	method IsEmpty ()->boolean;
	method Contains (integer value)->boolean;
    method Push (integer value);
    method Pop ()->integer;
    method GetEnumerator ()->IEnumerator;
}
