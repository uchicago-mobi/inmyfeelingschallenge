//
//  FirstViewController.swift
//  InMyFeelings
//
//  Created by Chelsea Troy on 5/11/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class AddFeelingsReportController: UIViewController {
    @IBOutlet weak var oneWordTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapSubmitButton(_ sender: Any) {
        guard let oneWordText = self.oneWordTextField.text,
            oneWordText != "",
            let descriptionText = self.descriptionTextView.text,
            descriptionText != ""
            else {
            let alert = UIAlertController(
                title: "OOPS!",
                message: "Please fill out all the fields.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: false, completion: nil)
            return
        }

        sharedRepository.save(FeelingsEntry(
            oneWord: oneWordText,
            description: descriptionText,
            date: Date())
        )
    }
    
}

