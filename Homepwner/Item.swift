//
//  Item.swift
//  Homepwner
//
//  Created by Matthew Compton on 10/20/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: NSDate
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {

            let adjectives = ["Fluffy", "Rusty", "Shiny", "Danger", "Water"]
            let nouns = ["Bear", "Spork", "Floof", "Cow", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(
                name: randomName,
                serialNumber: randomSerialNumber,
                valueInDollars: randomValue
            )
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
}
