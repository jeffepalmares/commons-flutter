abstract class ILocalStorage<T, K> {
  Future upsert(T value);
  Future<T?> getByKey(K key);
  Future<List<T>> getAll();
  Future delete(K key);
}
