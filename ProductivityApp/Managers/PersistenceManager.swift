////
////  PersistenceManager.swift
////  ProductivityApp
////
////  Created by Sarkhan Jafarli on 10/13/22.
////
//
import UIKit
import CoreData
import Combine


// Turn into core data related manager
class PersistenceManager {
    static let shared = PersistenceManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [UserTask] = []
    
    func loadTasks() -> Future<[UserTask], Error> {
        let request: NSFetchRequest<UserTask> = UserTask.fetchRequest()
        
        do {
            tasks = try context.fetch(request)
            return Future { [weak self] promise in
                guard let self else { return }
                promise(.success(self.tasks))
            }
        } catch {
            print("Error while fetching tasks, \(error)")
            return Future { promise in
                promise(.failure(error))
            }
        }
    }
    
    func addTask(taskTitle: String){
        let newTask = UserTask(context: context)
        newTask.taskTitle = taskTitle
        let date = Date()
        newTask.date = date
        tasks.append(newTask)
        
        save()
    }
    
    func getTasksAtDate(date: Date) -> Future<[UserTask], Error>{
        let request: NSFetchRequest<UserTask> = UserTask.fetchRequest()
//        request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
       
        do {
            tasks = try context.fetch(request)
            return Future { [weak self] promise in
                guard let self else { return }
                promise(.success(self.tasks))
            }
            
        } catch {
            print("Error while fetching tasks, \(error)")
            return Future { promise in
                promise(.failure(error))
            }
        }
    }
    
    func deleteTask(task: UserTask) {
        
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("Error while saving the context, \(error)")
        }
    }
    
    
    
    
}



//
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    func getTasks(completed: @escaping (Result<[UserTask], CustomErrors>) -> Void) {
//        let request:NSFetchRequest<UserTask> = UserTask.fetchRequest()
//        do {
//            let tasks = try context.fetch(request)
//            if let task = tasks.first {
//                if let title = task.task_title {
//                    print(title)
//                }
//            }
//            print(tasks)
//            completed(.success(tasks))
//        } catch  {
//            completed(.failure(.unableToLoad))
//        }
//    }
//
//    func saveTasks(title: String, description: String) {
//
//        let newTask = UserTask(context: context)
//        newTask.task_title = title
//        newTask.task_description = description
//
//        do {
//            try context.save()
////            print(newTask)
//        } catch  {
//            print("Error while saving to core data")
//        }
//    }
//
//
//}
