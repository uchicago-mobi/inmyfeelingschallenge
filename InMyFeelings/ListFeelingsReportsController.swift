//
//  SecondViewController.swift
//  InMyFeelings
//
//  Created by Chelsea Troy on 5/11/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class ListFeelingsReportsController: UITableViewController {
    
    var entries: [FeelingsEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.title = "Entries"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.entries = sharedRepository.entries
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "feelingsEntryCell") as! FeelingsEntryCell
        
        let entry = self.entries[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        
        cell.dateLabel.text = formatter.string(from: entry.date)
        cell.feelingLabel.text = entry.oneWord
        return cell

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }


}

