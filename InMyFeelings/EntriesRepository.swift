//
//  EntriesRepository.swift
//  InMyFeelings
//
//  Created by Chelsea Troy on 5/11/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//
import UIKit
import CoreData

let sharedRepository = EntriesRepository()

class EntriesRepository {
    var coreDataEntries: [NSManagedObject] = []
    
    lazy var managedContext : NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()

    func save(_ entry: FeelingsEntry) {
        let entity =
            NSEntityDescription.entity(forEntityName: "CDFeelingsEntry",in: self.managedContext)!
        let coreDataEntry = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        coreDataEntry.setValue(entry.oneWord, forKeyPath: "oneWord")
        coreDataEntry.setValue(entry.description, forKeyPath: "feelingDescription")
        coreDataEntry.setValue(entry.date, forKeyPath: "date")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getEntries() -> [FeelingsEntry] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFeelingsEntry")
        
        do {
            self.coreDataEntries = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        let entries = self.coreDataEntries.map {
            FeelingsEntry(
                oneWord: ($0.value(forKeyPath: "oneWord") as? String)!,
                description: ($0.value(forKeyPath: "feelingDescription") as? String)!,
                date: ($0.value(forKeyPath: "date") as? Date)!
            )
        }
        return entries
    }

}
