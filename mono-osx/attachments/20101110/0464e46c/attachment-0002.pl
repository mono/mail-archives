namespace MonoMac.WebKit {
	public interface IIndexedContainer<T> {
		int Length { get; }
		T this [int index] { get; }
	}
}
