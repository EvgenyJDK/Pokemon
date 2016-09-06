//
//  AllAlbumCell.swift
//  Pokemon
//
//  Created by Evgeny on 9/6/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit

class AllAlbumCell: UITableViewCell {
  
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var checkSwitch: UISwitch!
    
    @IBAction func check(sender: AnyObject) {
        
        
//        checkSwitch.on = false
//            (sender as! UISwitch).on
//        dupSwitch.on = (sender as UISwitch).on
    }
    
}