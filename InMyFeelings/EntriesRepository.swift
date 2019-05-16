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
    
    let fileName = "entries.txt"
    var fileURL: URL
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = documentsDirectory.appendingPathComponent(fileName)
    }
    
    func save(_ entry: FeelingsEntry) {
        let encoder = JSONEncoder()
        
        let user = try! encoder.encode(entry)
        let userString = String(data: user, encoding: .utf8)! + "\n"
        
        var contents = try! String(contentsOf: fileURL)
        contents.append(userString)
        try! contents.write(to: fileURL, atomically: true, encoding: .utf8)
    }
    
    func getEntries() -> [FeelingsEntry] {
        let fileContents = try! String(contentsOf: fileURL)
        let entriesAsJson = fileContents.components(separatedBy: "\n")
        entries = []
        
        for entry in entriesAsJson {
            if let data = entry.data(using: String.Encoding.utf8) {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let dictionarizedFeelingsEntry = dictionary {
                        let modelEntry = FeelingsEntry(fromDict: dictionarizedFeelingsEntry)
                        entries.append(modelEntry)
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        return entries
    }
}
