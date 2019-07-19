
import Foundation
import CoreData

protocol DBCallsDelegate {
    
    //func didRecieveEventList(with eventsList: [FeedItem])
    
}

class DBCalls: NSObject {
    
//    var delegate: DBCallsDelegate?
//
//    override init() {
//        super.init()
//    }
//
//    @objc func getEventsListFromDB(latitude: Double, longitude: Double) {
//
//        DBManager().retrieveRecord(entityName: DatabaseTables.Event) { (result, error) in
//
//            if let response = result {
//                var temp = [FeedItem]()
//                for i in response {
//                    temp.append(FeedItem.init(object: i))
//                }
//                self.delegate?.didRecieveEventList(with: temp)
//                DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
//                    self.getEventsFromServer(latitude: latitude, longitude: longitude)
//                })
//
//            } else {
//                self.getEventsFromServer(latitude: latitude, longitude: longitude)
//            }
//        }
//    }
//
//    func getEventsFromServer(latitude: Double, longitude: Double) {
//
//        let predicate = NSPredicate(format: "type == %@", "event_list")
//
//        DBManager().retrieveRecord(entityName: DatabaseTables.Timestamp, predicate: predicate) { (result, error) in
//
//            var ts = "0"
//            if let response = result {
//                ts = response[0].value(forKey: "value") as? String ?? "0"
//            }
//
//            APICalls().getFeed(timestamp: ts, latitude: latitude, longitude: longitude) { (object) in
//                if let obj = object {
//                    if obj.timestamp > ts {
//
//                        self.updateTimestampDB(type: "event_list", timestamp: obj.timestamp)
//                        self.updateEventsDB(data: obj.data)
//
//                        self.delegate?.didRecieveEventList(with: obj.data)
//                    }
//                } else {
//                    //self.delegate?.didRecieveEventList(with: [])
//                }
//            }
//        }
//    }
//
//    func updateEventsDB(data: [FeedItem]) {
//
//        DBManager().deleteAllRecords(entityName: DatabaseTables.Event) { (result, error) in
//            if result {
//
//                var dataList = [[String: Any]]()
//                for i in data {
//                    dataList.append(i.dictionary ?? [:])
//                }
//
//                DBManager().addRecords(entityName: DatabaseTables.Event, dataList: dataList, completion: { (result, error) in
//                    if result {
//                        print("Events list saved to local db.")
//                    } else {
//                        self.updateEventsDB(data: data)
//                    }
//                })
//
//            } else {
//                self.updateEventsDB(data: data)
//            }
//        }
//    }
//
//
//    func updateTimestampDB(type: String, timestamp: String) {
//
//        var dataList = [[String: Any]]()
//        dataList.append(["type": type,
//                         "value": timestamp].dictionary ?? [:])
//
//        let predicate = NSPredicate(format: "type == %@", "event_list")
//
//        DBManager().updateOrInsertRecord(entityName: DatabaseTables.Timestamp, predicate: predicate, dataList: dataList) { (result, error) in
//            if result {
//                print("Timestamp saved to local db.")
//            } else {
//                self.updateTimestampDB(type: type, timestamp: timestamp)
//            }
//        }
//
//    }
}


