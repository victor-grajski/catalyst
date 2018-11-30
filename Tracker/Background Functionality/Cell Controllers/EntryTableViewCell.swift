//
//  EntryTableViewCell.swift
//  Tracker
//
//  Created by Victor Grajski on 11/14/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class EntryTableViewCell : UITableViewCell {
    
    @IBOutlet weak var testLabel : UILabel!
    @IBOutlet weak var testDescription : UILabel!
    
    override func awakeFromNib ( ) {
        
        super . awakeFromNib ( )
        
    }

    override func setSelected ( _ selected : Bool , animated : Bool ) {
        
        super . setSelected ( selected , animated : animated )
        
    }
    
    func commonInit ( _ test : String , description : String ) {
        
        testLabel . text = test
        testDescription . text = description
        
    }
    
}
