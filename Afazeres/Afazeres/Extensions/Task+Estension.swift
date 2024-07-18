import CoreData

extension Task {
    
    static func allTasksFetchRequest() -> NSFetchRequest<Task> {
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        return request
    }
    
    static func by(title: String) -> Task? {
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", title.lowercased())
        
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        
        do {
            let task = try viewContext.fetch(request).first
            return task
            
        } catch {
            return nil
        }
    }
        
}
