//
//  TrapTableViewCell.swift
//  Tracker
//
//  Created by Victor Grajski on 11/14/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class TrapTableViewCell : UITableViewCell {

    @IBOutlet weak var trapToDisplay : UILabel!
    @IBOutlet weak var trapDescription : UILabel!
    
    override func awakeFromNib ( ) {
        
        super . awakeFromNib ( )
        
    }

    override func setSelected ( _ selected : Bool , animated : Bool ) {
        
        super . setSelected ( selected , animated : animated )
        
    }
    
    func commonInit ( _ trap : String , description : String ) {
        
        trapToDisplay . text = trap
        trapDescription . text = description
        
    }
    
}
