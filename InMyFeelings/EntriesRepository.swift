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
        try! contents.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
    }
    
    private func getEntries() -> [FeelingsEntry] {
        let fileContents = try! String(contentsOf: fileURL)
        let entriesAsJson = fileContents.components(separatedBy: "\n")
        entries = []
        let decoder = JSONDecoder()
        for entry in entriesAsJson {
            let jsonData = entry.data(using: .utf8)!
            let entry = try! decoder.decode(FeelingsEntry.self, from: jsonData)
            entries.append(entry)
        }
        return entries
    }
}
