//
//  ThoughtTrap.swift
//  Tracker
//
//  Created by Victor Grajski on 11/15/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import Foundation

@objc class ThoughtTrap : NSObject {
    
    let key : Int
    let name : String
    let trapDescription : String
    let trapReframe : String
    
    init ( keyToSet : Int , nameToSet : String , descriptionToSet : String , reframeToSet : String ) {
        
        self . key = keyToSet
        self . name = nameToSet
        self . trapDescription = descriptionToSet
        self . trapReframe = reframeToSet
        
    }
    
}
