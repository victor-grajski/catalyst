//
//  CenterView.swift
//  Tracker
//
//  Created by Lex Nasser on 11/7/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

var entriesList : [ Entry ] = [ ]

class CenterView : UIViewController , UITextFieldDelegate {

    @IBOutlet weak var cell1 : UIView!
    @IBOutlet weak var cell1TextField : UITextField!
    
    @IBOutlet weak var cell2 : UIView!
    @IBOutlet weak var cell2TableView : UITableView!
    
    @IBOutlet weak var cell3 : UIView!
    @IBOutlet weak var cell3TextField : UITextField!
    
    @IBOutlet weak var logButton : UIButton!
    
    override func viewDidLoad ( ) {
        
        
        super . viewDidLoad ( )
        
        cell1 . layer . cornerRadius = 10
        cell1 . layer . shadowColor = UIColor . black . cgColor
        cell1 . layer . shadowOpacity = 0.25
        cell1 . layer . shadowOffset = CGSize . zero
        cell1 . layer . shadowRadius = 5
        
        cell1TextField . backgroundColor = UIColor . black
        cell1TextField . returnKeyType = UIReturnKeyType . done
        cell1TextField . delegate = self
        
        cell2 . layer . cornerRadius = 10
        cell2 . layer . shadowColor = UIColor . black . cgColor
        cell2 . layer . shadowOpacity = 0.25
        cell2 . layer . shadowOffset = CGSize . zero
        cell2 . layer . shadowRadius = 5
        
        cell2TableView . backgroundColor = UIColor . black
        cell2TableView . layer . cornerRadius = 5
        
        cell3 . layer . cornerRadius = 10
        cell3 . layer . shadowColor = UIColor . black . cgColor
        cell3 . layer . shadowOpacity = 0.25
        cell3 . layer . shadowOffset = CGSize . zero
        cell3 . layer . shadowRadius = 5
        
        cell3TextField . backgroundColor = UIColor . black
        cell3TextField . delegate = self
        cell3TextField . returnKeyType = UIReturnKeyType . done
        
    }
    
    @objc func textFieldShouldReturn ( _ textField : UITextField ) -> Bool {
        
        self.view.endEditing(true)
        return false
        
    }
    


    @IBAction func logButtonTapped ( _ sender : Any ) {
        
        if cell1TextField . text != "" && cell3TextField . text != "" {
        
            entriesList . append ( Entry ( text1 : cell1TextField . text! , traps: [ ] , text2 : cell3TextField . text! , timestamp : NSDate ( ) . timeIntervalSince1970 ) )
    
            cell1TextField . text = ""
            cell3TextField . text = ""
        
            let alert = UIAlertController ( title : "Success" , message : "Your entry has been logged." , preferredStyle : . alert )
            alert . addAction ( UIAlertAction ( title : "OK" , style : UIAlertAction . Style . default ) )
            self . present ( alert , animated : true , completion : nil )
            
        } else {
            
            let alert = UIAlertController ( title : "Error" , message : "Make sure that all fields are filled." , preferredStyle : . alert )
            alert . addAction ( UIAlertAction ( title : "OK" , style : UIAlertAction . Style . default ) )
            self . present ( alert , animated : true , completion : nil )
            
        }
        
    }
}
