//
//  ReframeInfoTableViewCell.swift
//  Tracker
//
//  Created by Victor Grajski on 11/15/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class ReframeInfoTableViewCell : UITableViewCell {
    
    @IBOutlet weak var trapLabel : UILabel!
    @IBOutlet weak var reframeLabel : UILabel!
    
    override func awakeFromNib ( ) {
        
        super . awakeFromNib ( )
        
    }

    override func setSelected ( _ selected : Bool , animated : Bool ) {
        
        super . setSelected ( selected , animated : animated )
        
    }
    
    func commonInit ( _ trapLabelIn : String , reframeLabelIn : String ) {
        
        trapLabel . text = trapLabelIn
        reframeLabel . text = reframeLabelIn
        
    }
    
}
