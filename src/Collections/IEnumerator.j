public interface IEnumerator {
	method operator Current ()->integer;
	method MoveNext ()->boolean;
	method Reset ();
}