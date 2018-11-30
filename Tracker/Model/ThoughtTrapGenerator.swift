//
//  ThoughtTrapGenerator.swift
//  Tracker
//
//  Created by Victor Grajski on 11/15/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import Foundation

class ThoughtTrapGenerator {
    
    static func getThoughtTrapArray ( ) {
        
        if let path = Bundle . main . path ( forResource : "traps" , ofType : "json" ) {
            
            if let jsonData = NSData ( contentsOfFile : path ) {
                
                do {
                    
                    let json = try JSONSerialization . jsonObject ( with : jsonData as Data , options : . mutableContainers ) as! [ String : AnyObject ]
                    
                    for key in json . keys {
                        
                        let thoughtTrapData = json [ key ] as! [ String : AnyObject ]
                        
                        let trapName = thoughtTrapData [ "name" ] as! String
                        let trapDescription = thoughtTrapData [ "description" ] as! String
                        let trapReframe = thoughtTrapData [ "reframe" ] as! String
                        
                        thoughtTrapArray . append ( ThoughtTrap ( keyToSet : Int ( key )! , nameToSet : trapName , descriptionToSet : trapDescription , reframeToSet : trapReframe ) )
                        
                    }
                    
                } catch {
                    
                    NSLog ( "Could not load Thought Trap array" )
                    
                }
                
            }
            
        }
        
    }
    
}
