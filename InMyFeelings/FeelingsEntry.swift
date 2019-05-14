//
//  FeelingsEntry.swift
//  InMyFeelings
//
//  Created by Chelsea Troy on 5/11/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import Foundation

struct FeelingsEntry: Codable {
    let oneWord: String
    let description: String
    let date: Date
    
    init(oneWord: String, description: String, date: Date){
        self.oneWord = oneWord
        self.description = description
        self.date = date
    }
    
    init(fromDict dict: [String : String]) {
        self.oneWord = dict["oneWord"] ?? ""
        self.description = dict["description"] ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        self.date = formatter.date(from: dict["date"]!)!
    }
    
    func toDict() -> [String : String] {
        var dict = [String : String]()
        dict["oneWord"] = self.oneWord
        dict["description"] = self.description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        dict["date"] = formatter.string(from: self.date)
        
        return dict
    }
}
