//
//  EntriesRepository.swift
//  InMyFeelings
//
//  Created by Chelsea Troy on 5/11/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//
import UIKit

let sharedRepository = EntriesRepository()

class EntriesRepository {
    var entries: [FeelingsEntry] = []
    
    let feelingsEntriesKey = "com.save.feelingsEntries"
        
    func save(_ entry: FeelingsEntry) {
        var entries = getEntries()
        entries.append(entry)
        
        let arrayOfDicts = entries.map { $0.toDict() }
        
        UserDefaults.standard.set(
            arrayOfDicts,
            forKey: self.feelingsEntriesKey
        )
    }
        
    func getEntries() -> [FeelingsEntry] {
        let entriesDicts = UserDefaults.standard.value(forKey: self.feelingsEntriesKey) as? [[String:String]] ?? []
        let entriesList = entriesDicts.map {dict in FeelingsEntry(fromDict: dict) }
        return entriesList
    }
        
    func clearUserData(){
        UserDefaults.standard.removeObject(forKey: self.feelingsEntriesKey)
    }
}
