//
//  QuoteController.swift
//  QuoteKeeper23
//
//  Created by Karl Pfister on 12/3/18.
//  Copyright © 2018 Karl Pfister. All rights reserved.
//

import Foundation

class QuoteController {
    
    // Source of Truth
    var myQuotes: [Quote] = []
    
    // Singleton
    static let sharedInstance = QuoteController()
    
    
    //MARK: Crud
    
    // Create
    func createQuote(quoteText: String, quoteAuthor: String) {
        let newQuote = Quote(userInitializedTextForTheQuote: quoteText, userInitializedAuthorForTheQuote: quoteAuthor)
        myQuotes.append(newQuote)
        // save data
        saveToPersistentStore()
    }
    
    // Update
    func updateQuote(quoteToUpdate: Quote, newText: String, newAuthor: String) {
        quoteToUpdate.quoteText = newText
        quoteToUpdate.quoteAuthor = newAuthor
        // Save
        saveToPersistentStore()
    }
    
    // Delete
    func deleteQuote(quoteToDelete: Quote) {
        // Find where the quote lives
        guard let indexOfQuoteToDelete = myQuotes.index(of: quoteToDelete) else { return }
        // Now remove it from the Array
        myQuotes.remove(at: indexOfQuoteToDelete)
        // Save
        saveToPersistentStore()
    }
    
    ///Persistence
    func createFileURLForPersistence() -> URL {
        // Grab the users document directory
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Create the new fileURL on user's phone
        let fileURL = urls[0].appendingPathComponent("QuoteKeeper23.json")
        
        return fileURL
    }
    
    func saveToPersistentStore() {
        // Create an instance of JSON Encoder
        let jsonEncoder = JSONEncoder()
        // Attempt to convert our quotes to JSON
        do {
            let jsonQuote = try jsonEncoder.encode(myQuotes)
            // With the new json(d) quote, save it to the users device
            try jsonQuote.write(to: createFileURLForPersistence())
        } catch let encodingError {
            // Handle the error, if there is one
            print("There was an error saving!! \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        // The data we want will be JSON, and I want it to be a Quote.
        let jsonDecoder = JSONDecoder()
        //Decode the data
        do {
            let jsonData = try Data(contentsOf: createFileURLForPersistence())
            let decodedQuotes = try jsonDecoder.decode([Quote].self, from: jsonData)
            myQuotes = decodedQuotes
        } catch let decodingError {
            print("There was an error decoding!! \(decodingError.localizedDescription)")
        }
    }
    
}
