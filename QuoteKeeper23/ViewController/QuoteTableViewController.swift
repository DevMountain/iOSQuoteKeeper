//
//  QuoteTableViewController.swift
//  QuoteKeeper23
//
//  Created by Karl Pfister on 12/3/18.
//  Copyright © 2018 Karl Pfister. All rights reserved.
//

import UIKit

class QuoteTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load it when the view appears
        QuoteController.sharedInstance.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // I want this to display as many rows as I have quotes
        return QuoteController.sharedInstance.myQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // I first want to know what cell im working with and make sure its a QuoteTableviewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? QuoteTableViewCell else { return UITableViewCell() }
        // Now I need the quote to display
        let quoteToDisplay = QuoteController.sharedInstance.myQuotes[indexPath.row]
        // Now I need to create a string from the date. 
        let stringFromDate = DateFormatter.localizedString(from: quoteToDisplay.dateOfQuote, dateStyle: .short, timeStyle: .none)
        // Give my cell the data from the quote
        cell.quoteTextLabel.text = quoteToDisplay.quoteText
        cell.quoteAuthorLabel.text = quoteToDisplay.quoteAuthor
        cell.quoteDateLabel.text = stringFromDate
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Find what quote the user is trying to delete
            let quoteToDelete = QuoteController.sharedInstance.myQuotes[indexPath.row]
            // Delete it
            QuoteController.sharedInstance.deleteQuote(quoteToDelete: quoteToDelete)
            // Don't forget to remove from the TableView
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Identifier : Hey, What segue was fired?
        if segue.identifier == "toDetailVC" {
            // Index : Okay, what cell was tapped on?
            if let index = tableView.indexPathForSelectedRow {
                // Destination: Where is the data going?
                guard let destinationVC = segue.destination as? QuoteDetailViewController else {return}
                // Find Object: What object am I sending?
                let quoteToSend = QuoteController.sharedInstance.myQuotes[index.row]
                // Send Object: Assign that object to my landing pad.
                destinationVC.reciever = quoteToSend
            }
        }
    }
    
} // End of class

