namespace InvoiceApp.Repository;

public interface IRepository<T> where T : class
{
    Task<T?> GetByIdAsync(int id);
    IQueryable<T> Query();
    Task AddAsync(T entity);
    void Update(T entity);
    void Remove(T entity);
    Task<int> SaveChangesAsync();
}