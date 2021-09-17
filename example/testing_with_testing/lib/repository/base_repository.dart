abstract class BaseRepository<T> {
  Future<void> save(T entity);
}
