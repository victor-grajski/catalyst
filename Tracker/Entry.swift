//
//  Entry.swift
//  Tracker
//
//  Created by Lex Nasser on 11/14/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class Entry {
    
    var text1 : String
    var traps : [ Int ]
    var text2 : String
    var timestamp : Double

    init ( text1 : String , traps : [ Int ] , text2 : String , timestamp : Double ) {
        
        self . text1 = text1
        self . traps = traps
        self . text2 = text2
        self . timestamp = timestamp
        
    }
    
}
