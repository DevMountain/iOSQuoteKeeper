//
//  QuoteDetailViewController.swift
//  QuoteKeeper23
//
//  Created by Karl Pfister on 12/3/18.
//  Copyright © 2018 Karl Pfister. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var quoteText: UITextField!
    @IBOutlet weak var quoteAuthor: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designClearButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    // Properties
    var reciever: Quote?
    
    // Methods
    func clearText() {
        quoteText.text = ""
        quoteAuthor.text = ""
    }
    func updateViews() {
        // I want to populate the textFields with the data if it exists.
        guard let doesAQuoteExist = reciever else { return }
        quoteText.text = doesAQuoteExist.quoteText
        quoteAuthor.text = doesAQuoteExist.quoteAuthor
    }
    
    func designClearButton() {
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        clearButton.backgroundColor = .red
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.setTitle("Clear the Data", for: .normal)
    }
    
    //MARK: Actions
    @IBAction func clearButtonTapped(_ sender: Any) {
        clearText()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let unwrappedQuoteText = quoteText.text, let unwrappedQuoteAuthor = quoteAuthor.text else { return }
        
        if let doesAQuoteNeedToBeUpdated = reciever {
            // Update
            QuoteController.sharedInstance.updateQuote(quoteToUpdate: doesAQuoteNeedToBeUpdated, newText: unwrappedQuoteText, newAuthor: unwrappedQuoteAuthor)
        } else {
            // Create
            QuoteController.sharedInstance.createQuote(quoteText: unwrappedQuoteText, quoteAuthor: unwrappedQuoteAuthor)
        }
        // Pop off that view and go back to the TBVC
        navigationController?.popViewController(animated: true)
    }
} // End of class
