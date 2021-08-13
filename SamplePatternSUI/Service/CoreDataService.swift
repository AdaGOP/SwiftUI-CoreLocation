//
//  CoreDataService.swift
//  SamplePatternSUI
//
//  Created by Jazilul Athoya on 12/08/21.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataService: ObservableObject {
    
    var container: NSPersistentContainer!
    
    init() {
        let delegate =  UIApplication.shared.delegate as! AppDelegate
        container = delegate.persistentContainer
    }
    
    func savePlace(name: String, latitude: Double, longitude: Double) -> Place? {
        let place = Place()
        place.name = name
        place.lat = latitude
        place.lon = longitude
        
        do {
            try container.viewContext.save()
            return place
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func fetchPlace() -> [Place] {
        let request: NSFetchRequest = Place.fetchRequest()
        
        if let results = try? container.viewContext.fetch(request) {
            return results
        }
        
        return []
    }
    
}
