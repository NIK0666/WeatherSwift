//
//  DBManager.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    private var database: Realm
    public static let shared = DBManager()
    private init() {
        
        database = try! Realm()
    }
    
    static func checkDatabase() {
        
        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        if !FileManager.default.fileExists(atPath: defaultRealmPath.path) {
            let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
            let bundleReamPath = Bundle.main.path(forResource: "default", ofType:"realm")
            do
            {
                try FileManager.default.copyItem(atPath: bundleReamPath!, toPath: defaultRealmPath.path)
                DispatchQueue.main.async {
                    _ = DBManager.shared
                }
            }
            catch let error as NSError {
                print("error occurred, here are the details:\n \(error)")
            }
        } else {
            _ = DBManager.shared
        }
        
    }
    
    func addData(object: City) {
        try! database.write {
            database.add(object)
        }
    }
    
    func deleteAllFromDatabase() {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: City) {
        try! database.write {
            database.delete(object)
        }
    }
    
    func getCities() -> Results<City> {
        let results: Results<City> = database.objects(City.self)
        return results
    }
    
}
