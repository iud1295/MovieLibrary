
import UIKit
import CoreData
import Foundation

class DBManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addRecords(entityName: String, dataList: [[String: Any]], completion: @escaping (_ result: Bool, _ error: Error?) -> ()) {
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        
        for event in dataList {
            let row = NSManagedObject.init(entity: entity, insertInto: context)
            
            for item in event {
                row.setValue(item.value, forKey: item.key)
            }
        }
        
        do {
            try context.save()
            completion(true, nil)
        } catch let err {
            print("Could not save. \(err.localizedDescription)")
            completion(false, err)
        }
    }
    
    func retrieveRecord(entityName: String, completion: @escaping (_ result: [NSManagedObject]?, _ error: Error?) -> ()) {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        
        //        fetchRequest.fetchLimit = 3
//        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "username", ascending: true)]

        do {
            let result = try context.fetch(fetchRequest)
            if result.count > 0 {
                completion(result as? [NSManagedObject], nil)
            } else {
                completion(nil, nil)
            }
        } catch let err {
            print("Failed to fetch the records from DB.")
            completion(nil, err)
        }
    }
    
    func deleteAllRecords(entityName: String, completion: @escaping (_ result: Bool, _ error: Error?) -> ()) {

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(true, nil)
        } catch let err {
            print ("There was an error")
            completion(false, err)
        }
        
    }
    
}

