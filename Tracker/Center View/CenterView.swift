//
//  CenterView.swift
//  Tracker
//
//  Created by Lex Nasser on 11/7/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

var iCloudKeyStore : NSUbiquitousKeyValueStore? = NSUbiquitousKeyValueStore ( )

class CenterView : UIViewController , UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cell1view1: UIView!
    @IBOutlet weak var cell1view2: UIView!
    @IBOutlet weak var cell1TextField : UITextView!
    
    @IBOutlet weak var cell2view1 : UIView!
    @IBOutlet weak var cell2view2 : UIView!
    @IBOutlet weak var cell2TableView : UITableView!
    
    
    @IBOutlet weak var cell3view1: UIView!
    @IBOutlet weak var cell3view2: UIView!
    @IBOutlet weak var cell3TextField : UITextView!
    
    @IBOutlet weak var logView: UIView!
    @IBOutlet weak var logButton : UIButton!
    
    @IBAction func showReframeInfo ( _ sender : Any ) {
        
        let reframeInfo = ReframeInfoViewController ( )
        self . present ( reframeInfo , animated : true , completion : nil )
        
    }
    
    override func viewDidLoad ( ) {
        
        super . viewDidLoad ( )
        
        cell1view1 . clipsToBounds = true
        cell1view1 . layer . cornerRadius = 10
        
        if #available ( iOS 11.0 , * ) {
            
            cell1view1 . layer . maskedCorners = [ . layerMaxXMinYCorner , . layerMinXMinYCorner ]
            
        }
        
        cell1view2 . clipsToBounds = true
        cell1view2 . layer . cornerRadius = 10
        
        if #available ( iOS 11.0 , * ) {
            
            cell1view2 . layer . maskedCorners = [ . layerMaxXMaxYCorner , . layerMinXMaxYCorner ]
            
        }
        
        
        
        cell1TextField . returnKeyType = UIReturnKeyType . next
        cell1TextField . layer . cornerRadius = 5
        cell1TextField . layer . borderColor = UIColor . lightGray . cgColor
        cell1TextField . layer . borderWidth = 0.25
        cell1TextField . delegate = self
        
//        cell2 . layer . cornerRadius = 10
//        cell2 . layer . shadowColor = UIColor . black . cgColor
//        cell2 . layer . shadowOpacity = 0.25
//        cell2 . layer . shadowOffset = CGSize . zero
//        cell2 . layer . shadowRadius = 5
        
        cell2view1 . clipsToBounds = true
        cell2view1 . layer . cornerRadius = 10
        
        if #available ( iOS 11.0 , * ) {
            
            cell2view1 . layer . maskedCorners = [ . layerMaxXMinYCorner , . layerMinXMinYCorner ]
            
        }
        
        cell2view2 . clipsToBounds = true
        cell2view2 . layer . cornerRadius = 10
        
        if #available ( iOS 11.0 , * ) {
            
            cell2view2 . layer . maskedCorners = [ . layerMaxXMaxYCorner , . layerMinXMaxYCorner ]
            
        }
//
        cell2TableView . layer . cornerRadius = 5
        
        
        
//        cell3 . layer . cornerRadius = 10
//        cell3 . layer . shadowColor = UIColor . black . cgColor
//        cell3 . layer . shadowOpacity = 0.25
//        cell3 . layer . shadowOffset = CGSize . zero
//        cell3 . layer . shadowRadius = 5
        
        cell3view1 . clipsToBounds = true
        cell3view1 . layer . cornerRadius = 10
        
        if #available ( iOS 11.0 , * ) {
            
            cell3view1 . layer . maskedCorners = [ . layerMaxXMinYCorner , . layerMinXMinYCorner ]
            
        }
        
        cell3view2 . clipsToBounds = true
        cell3view2 . layer . cornerRadius = 10
        
        if #available ( iOS 11.0 , * ) {
            
            cell3view2 . layer . maskedCorners = [ . layerMaxXMaxYCorner , . layerMinXMaxYCorner ]
            
        }
        
        cell3TextField . layer . borderColor = UIColor . lightGray . cgColor
        cell3TextField . layer . borderWidth = 0.25
        cell3TextField . delegate = self
        cell3TextField . returnKeyType = UIReturnKeyType . done

        cell2TableView.delegate = self
        cell2TableView.dataSource = self
        
        let nib = UINib.init(nibName: "TrapTableViewCell", bundle: nil)
        cell2TableView.register(nib, forCellReuseIdentifier: "TrapTableViewCell")
        
        logView . layer . cornerRadius = 10

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    // MARK: - UITableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughtTrapArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let trapRow = tableView.dequeueReusableCell(withIdentifier: "TrapTableViewCell", for: indexPath) as? TrapTableViewCell {
            trapRow.trapToDisplay.text = thoughtTrapArray[indexPath.item].name
            trapRow.trapDescription.text = thoughtTrapArray[indexPath.item].trapDescription
            
            return trapRow
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        entryThoughtTrapArray.append(thoughtTrapArray[indexPath.item].key)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let index : Int = entryThoughtTrapArray.index(of: thoughtTrapArray[indexPath.item].key)!
        entryThoughtTrapArray.remove(at: index)
    }

    @IBAction func logButtonTapped ( _ sender : Any ) {
        
        if cell1TextField . text != "" && cell3TextField . text != "" {
            
            let dateFormatter = DateFormatter ( )
            dateFormatter . dateFormat = "yyyy-MM-dd HH:mm:ss.A"
            let dateToStore = dateFormatter . string ( from : Date ( ) )
            
            loadFromUserDefaults ( )
        
            entries . append ( Entry ( text1 : cell1TextField . text! , traps : entryThoughtTrapArray , text2 : cell3TextField . text! , dateString : dateToStore ) )
            
            UserDefaults . standard . set ( entries . map { $0 . toStringList ( ) } , forKey : "entries" )
            
            iCloudKeyStore? . set ( entries . map { $0 . toStringList ( ) } , forKey : "entries" )
    
            cell1TextField . text = ""
            cell3TextField . text = ""
            
            updateCounts()
            
           // RightView ( ) . refreshChart ( )
        
            let alert = UIAlertController ( title : "Success" , message : "Your entry has been logged." , preferredStyle : . alert )
            alert . addAction ( UIAlertAction ( title : "OK" , style : UIAlertAction . Style . default ) )
            self . present ( alert , animated : true , completion : nil )
            
        } else {
            
            let alert = UIAlertController ( title : "Error" , message : "Make sure that all fields are filled." , preferredStyle : . alert )
            alert . addAction ( UIAlertAction ( title : "OK" , style : UIAlertAction . Style . default ) )
            self . present ( alert , animated : true , completion : nil )
            
        }
    }
    
    func loadFromUserDefaults ( ) {
        
        if let entriesUD = UserDefaults . standard . array ( forKey : "entries" ) as? [ [ String ] ] {
            
            entries = entriesUD . map { parseStringList ( stringList : $0 ) }
            
        }
        
        if let countsUD = UserDefaults . standard . object ( forKey : "counts" ) as? [ String : Int ] {
            
            counts = countsUD
            
        }
    }
    
    func parseStringList ( stringList : [ String ] ) -> Entry {
        
        return Entry (
            text1 : stringList [ 0 ] ,
            traps : stringToIntList ( string : stringList [ 1 ] ) ,
            text2 : stringList [ 2 ] ,
            dateString : stringList [ 3 ]
        )
        
    }
    
    func stringToIntList ( string : String ) -> [ Int ] {
        
        return string . components ( separatedBy : " " ) . map { Int ( $0 )! }
        
    }
        
    
    func updateCounts ( ) {
        loadFromUserDefaults()
        for trap in entryThoughtTrapArray {
            let trapString = String(trap)
            let val = counts[trapString]!
            counts[trapString] = val + 1
        }
        UserDefaults.standard.set(counts, forKey: "counts")
        iCloudKeyStore?.set(counts, forKey: "counts")
    }
    
}
