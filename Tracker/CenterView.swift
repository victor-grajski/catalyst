//
//  CenterView.swift
//  Tracker
//
//  Created by Lex Nasser on 11/7/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class CenterView : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cell1: UIView!
    @IBOutlet weak var cell1TextField: UITextField!
    @IBOutlet weak var cell2: UIView!
    @IBOutlet weak var cell2TableView: UITableView!
    @IBOutlet weak var cell3: UIView!
    @IBOutlet weak var cell3TextField: UITextField!
    override func viewDidLoad ( ) {
        
        
        super . viewDidLoad ( )
        
        cell1 . layer . cornerRadius = 10
        cell1 . layer . shadowColor = UIColor . black . cgColor
        cell1 . layer . shadowOpacity = 0.25
        cell1 . layer . shadowOffset = CGSize . zero
        cell1 . layer . shadowRadius = 5
        
        cell1TextField . backgroundColor = UIColor . black
        
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
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let trapRow = tableView.dequeueReusableCell(withIdentifier: "trapReuseIdentifier", for: indexPath) as? TrapTableViewCell {
            selectedIndexPath = indexPath
            
        }
    }

}
