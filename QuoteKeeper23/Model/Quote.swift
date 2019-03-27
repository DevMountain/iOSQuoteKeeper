//
//  Quote.swift
//  QuoteKeeper23
//
//  Created by Karl Pfister on 12/3/18.
//  Copyright © 2018 Karl Pfister. All rights reserved.
//

import Foundation

class Quote: Equatable, Codable {
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        return lhs.quoteText == rhs.quoteText && lhs.quoteAuthor == rhs.quoteAuthor && lhs.dateOfQuote == rhs.dateOfQuote
    }
    
    
    var quoteText: String
    var quoteAuthor: String
    var dateOfQuote: Date = Date()
    
    init(userInitializedTextForTheQuote: String,userInitializedAuthorForTheQuote: String ) {
        self.quoteText = userInitializedTextForTheQuote
        self.quoteAuthor = userInitializedAuthorForTheQuote
    }
    
} // End of class
