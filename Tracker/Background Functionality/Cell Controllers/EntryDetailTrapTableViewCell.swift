//
//  EntryDetailTrapTableViewCell.swift
//  Tracker
//
//  Created by Victor Grajski on 11/15/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class EntryDetailTrapTableViewCell : UITableViewCell {

    @IBOutlet weak var entryDetailTrapLabel : UILabel!
    
    override func awakeFromNib ( ) {
        
        super . awakeFromNib ( )
        
    }

    override func setSelected ( _ selected : Bool , animated : Bool ) {
        
        super . setSelected ( selected , animated : animated )
        
    }
    
    func commonInit ( _ trap : String ) {
        
        entryDetailTrapLabel . text = trap
        
    }
    
}
