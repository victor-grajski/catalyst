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
    var date : Date

    init ( text1 : String , traps : [ Int ] , text2 : String , dateString : String ) {
        
        self . text1 = text1
        self . traps = traps
        self . text2 = text2
        
        let dateFormatter = DateFormatter ( )
        dateFormatter . dateFormat = "yyyy-MM-dd HH:mm:ss.A"
        self . date = dateFormatter . date ( from : dateString )!
        
    }
    
    func getTimeElapsedString ( ) -> String {
        
        let secondsSincePosted = -date . timeIntervalSinceNow
        
        let minutes = Int ( secondsSincePosted / 60 )
        
        if minutes == 1 {
            
            return "\( minutes ) minute ago"
            
        } else if minutes < 60 {
            
            return "\( minutes ) minutes ago "
            
        } else if minutes < 120 {
            
            return "1 hour ago"
            
        } else if minutes < 24 * 60 {
            
            return "\( minutes / 60 ) hours ago"
            
        } else if minutes < 48 * 60 {
            
            return "1 day ago"
            
        } else {
            
            return "\( minutes / 1440 ) days ago"
            
        }
        
    }
    
    func toStringList ( ) -> [ String ] {
        
        let formatter = DateFormatter ( )
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.A"
        let dateString = formatter . string ( from : self . date )
        
        return [
            text1 ,
            intListToString ( intList : traps ) ,
            text2 ,
            dateString
        ]
        
    }
    
    func intListToString ( intList : [ Int ] ) -> String {
        
        var str : String = ""
        
        for i in intList {
            
            str += String ( i ) + " "
            
        }
        
        str . removeLast ( )
        
        return str
        
    }
    

}
